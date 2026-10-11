# 编译原理预习作业：了解你的编译器

本仓库保存两人小组完成编译原理预习作业的源程序、编译阶段产物、手写 LLVM IR、手写 RISC-V 汇编和 MLIR 进阶实验记录。实验围绕三个问题展开：源程序如何经过编译工具链形成可执行程序，同一程序如何用不同层次的表示实现，以及高层计算如何逐步降低为显式控制流。

小组成员：张晨旭（2411326）、尚文轩（2412456）。

## 实验内容

| 部分 | 主要内容 | 主要产物 |
| --- | --- | --- |
| Part1 | C/C++ 编译全过程观察；O0、O1、O2 优化对比 | 预处理文本、词法记号、AST、LLVM IR、汇编、目标文件和可执行文件 |
| Part2 | SysY 示例设计；等价 LLVM IR 与 RV64 汇编编写；输出对照 | SysY 源程序、手写 IR、手写汇编、参考产物和运行输出 |
| MLIR 进阶 | 向量加法的 Linalg → SCF → CF 降低 | 各阶段 MLIR、阶段差异、Pass 日志和耗时记录 |

## 目录结构

```text
.
├── README.md
├── Part1/
│   ├── Fib.cpp                      # 基础斐波那契程序
│   ├── test.cpp                     # 宏、数组、函数和循环的补充实验
│   └── build/
│       ├── Fib.ii / test.ii         # 预处理结果
│       ├── *.tokens.txt             # 词法记号
│       ├── *.ast.txt                # 抽象语法树
│       ├── *_O0.ll / *_O1.ll / *_O2.ll
│       ├── *_O0.s / *_O1.s / *_O2.s
│       ├── Fib.o / test.o           # 目标文件
│       ├── Fib / test               # 可执行文件
│       └── lab.zip                  # 已保存的归档文件
├── Part2/
│   ├── reference.sy                # SysY 示例
│   ├── sysy_compat.h               # 独立 C 参考编译使用的接口声明
│   └── build/
│       ├── reference/              # 保存的参考 IR、汇编及输出
│       └── lab/                    # 手写实现及输出
│           ├── reference.ll
│           ├── reference_rv64.S
│           ├── reference_ir / reference_riscv
│           └── ir.out / riscv.out
└── mlir_exploration/
    ├── input/vecadd_linalg.mlir
    ├── stages/
    │   ├── 00_linalg.mlir
    │   ├── 01_scf.mlir
    │   ├── 02_cf.mlir
    │   ├── 02_pipeline.mlir
    │   └── 02_pipeline_changed.mlir
    └── logs/
        ├── linalg_vs_scf.diff
        ├── scf_vs_cf.diff
        ├── pipeline.log
        ├── pipeline_changed.log
        └── timing.log
```

## Part1：编译流程与优化观察

### 基础程序

`Fib.cpp` 通过 C++ 标准输入读取 `n`，先输出数列的前两项，再通过 `while` 循环完成递推和输出。实验用它观察以下处理链：

```text
C++ 源程序 → 预处理 → 前端分析 → LLVM IR → 汇编 → 目标文件 → 链接后的程序
```

词法记号和 AST 是前端分析的观察产物。预处理结果及前端输出包含标准库头文件内容，分析时需要结合源文件位置定位用户程序。LLVM IR 和汇编则用于追踪局部变量、循环条件、递推计算与输入输出调用。

### 补充程序与优化现象

`test.cpp` 包含类型替换宏 `size32`、循环宏 `fre`、数组递推、求和函数 `sum`，以及带有取余和按位异或操作的 `inline` 函数 `f`。

仓库保存两份程序在 O0、O1、O2 下的 IR 与汇编，重点比较内存读写、基本块、循环和函数结构。现有产物中可以直接观察到：

- `test_O1.ll` 的 `sum` 使用标量循环和 `phi` 表达循环数据流。
- `test_O2.ll` 的 `sum` 出现 `<4 x i32>` 向量加载、向量加法和 `llvm.vector.reduce.add.v4i32`，体现循环向量化。
- `test_O2.ll` 的 `main` 简化为 `ret i32 0`。源程序中的计算结果没有输出，也没有其他需要保留的可观察副作用，因此相关计算可以被消除。

### 复现示例

以下命令在 Linux/WSL 中从仓库根目录运行，生成结果放入临时目录。已有 IR 标注使用 Linux x86-64 目标，部分文件记录的 Clang 版本为 18.1.3；不同版本、目标架构和编译参数可能产生不同文本。

```bash
part1_out=$(mktemp -d)
for name in Fib test; do
  src="Part1/${name}.cpp"
  clang++ -E "$src" -o "$part1_out/${name}.ii"
  clang++ -fsyntax-only -Xclang -dump-tokens "$src" \
    2> "$part1_out/${name}.tokens.txt"
  clang++ -fsyntax-only -Xclang -ast-dump "$src" \
    > "$part1_out/${name}.ast.txt"
  for level in 0 1 2; do
    clang++ -O"$level" -S -emit-llvm "$src" \
      -o "$part1_out/${name}_O${level}.ll"
    clang++ -O"$level" -S "$src" \
      -o "$part1_out/${name}_O${level}.s"
  done
  clang++ -c "$src" -o "$part1_out/${name}.o"
  clang++ "$part1_out/${name}.o" -o "$part1_out/$name"
done
printf '5\n' | "$part1_out/Fib"
```

## Part2：SysY、LLVM IR 与 RISC-V 等价实现

### 示例语义

`reference.sy` 定义数组 `{1, 2, 3, 4, 5}`，读取整数 `n` 并将其限制在 `[0, 5]`。函数 `calc` 遍历前 `n` 个元素：偶数元素按 `(a[i] / 2) * 4` 加入累积值，奇数元素从累积值中减去。最终通过 `putint` 和 `putch` 输出结果及换行。

例如输入 `5` 时，结果为 `-1 + 4 - 3 + 8 - 5 = 3`。

### 手写实现与参考产物

| 文件或目录 | 用途 |
| --- | --- |
| `build/lab/reference.ll` | 手写 LLVM IR；使用基本块、`phi`、数组寻址和运行库调用实现源程序 |
| `build/lab/reference_rv64.S` | 手写 RV64 汇编；实现数组访问、32 位整数运算、分支及调用约定 |
| `build/reference/` | 保存的参考 IR、RISC-V 汇编、可执行文件与输出，用于对照 |
| `sysy_compat.h` | 为 Clang 独立 C 参考编译声明 `getint`、`putint`、`putch` |

手写 IR 的循环条件块通过 `phi` 维护下标与累积值，分支汇合块通过 `phi` 合并奇偶分支结果；`main` 使用 `select` 表达输入限制。手写汇编使用 `a0`、`a1` 传递参数，以 4 字节为步长访问数组；`main` 分配 48 字节栈空间并保存返回地址，调用时保持 16 字节栈对齐。

保存的 `reference/expected.out`、`reference/ir.out`、`reference/riscv.out`、`lab/ir.out` 和 `lab/riscv.out` 内容均为 `3`。

### 复现示例

需要 Clang、RV64 Linux GCC 交叉工具链、QEMU 用户态模拟器，以及课程提供的 SysY 运行库。运行库未包含在仓库中。以下示例使用运行库 C 源文件；将路径替换为本机实际位置。若使用预编译运行库，需选择与目标架构和 ABI 匹配的版本。

```bash
part2_out=$(mktemp -d)
sysy_runtime_src=/absolute/path/to/sylib.c
riscv_sysroot=/usr/riscv64-linux-gnu

# 独立 C 参考执行
clang -x c -include Part2/sysy_compat.h Part2/reference.sy \
  "$sysy_runtime_src" -o "$part2_out/reference_c"

# 手写 LLVM IR 的本机执行
clang Part2/build/lab/reference.ll "$sysy_runtime_src" \
  -o "$part2_out/reference_ir"

# 手写 RISC-V 汇编的交叉编译与执行
riscv64-linux-gnu-gcc -march=rv64gc -mabi=lp64d \
  Part2/build/lab/reference_rv64.S "$sysy_runtime_src" \
  -o "$part2_out/reference_riscv"

printf '5\n' | "$part2_out/reference_c" > "$part2_out/expected.out"
printf '5\n' | "$part2_out/reference_ir" > "$part2_out/ir.out"
printf '5\n' | qemu-riscv64 -L "$riscv_sysroot" \
  "$part2_out/reference_riscv" > "$part2_out/riscv.out"
diff -u "$part2_out/expected.out" "$part2_out/ir.out"
diff -u "$part2_out/expected.out" "$part2_out/riscv.out"
```

两个 `diff` 无输出且退出码为 0，表示本次输入下的输出一致。Sysroot 路径需与交叉工具链的动态运行环境对应。

## 进阶：MLIR 多层表示与降低过程

### 实验对象与转换路线

`input/vecadd_linalg.mlir` 定义长度为 16、元素类型为 `i16` 的逐元素加法，三个参数均为 `memref<16xi16>`，计算关系为 `c[i] = a[i] + b[i]`。

```text
linalg.generic
    │ convert-linalg-to-loops
    ▼
scf.for + memref.load/store + arith.addi
    │ convert-scf-to-cf
    ▼
基本块 + cf.br/cf.cond_br + 基本块参数
```

| 阶段 | 主要观察点 |
| --- | --- |
| `00_linalg.mlir` | 索引映射、`parallel` 迭代属性和运算区域描述高层逐元素计算 |
| `01_scf.mlir` | 显式循环边界、步长、加载、加法和存储 |
| `02_cf.mlir` | 条件块、循环体、出口和回边；循环下标通过块参数传递 |
| `02_pipeline*.mlir` | 连续 Pass 流水线得到的最终控制流表示 |

这里的 `parallel` 描述迭代性质；已保存的 SCF 阶段使用 `scf.for`。实验重点是表示转换，而非多线程执行。

`linalg_vs_scf.diff` 和 `scf_vs_cf.diff` 记录相邻阶段的结构变化；`pipeline.log` 和 `pipeline_changed.log` 记录两个降低 Pass 后的 IR。两份日志及流水线结果分别保存，便于对照，但当前文本没有展示不同计算语义。

`timing.log` 记录总处理时间为 `0.0019` 秒，包括解析、`LinalgLowerToLoops`、`SCFToControlFlow`、输出及其他开销。这是工具处理该输入的耗时记录，不是向量加法的运行性能数据。

### 复现示例

需要提供相应方言和转换 Pass 的 `mlir-opt`，从仓库根目录运行：

```bash
mlir_out=$(mktemp -d)
mlir-opt mlir_exploration/input/vecadd_linalg.mlir \
  -o "$mlir_out/00_linalg.mlir"
mlir-opt "$mlir_out/00_linalg.mlir" --convert-linalg-to-loops \
  -o "$mlir_out/01_scf.mlir"
mlir-opt "$mlir_out/01_scf.mlir" --convert-scf-to-cf \
  -o "$mlir_out/02_cf.mlir"

mlir-opt mlir_exploration/input/vecadd_linalg.mlir \
  --convert-linalg-to-loops --convert-scf-to-cf \
  --mlir-print-ir-after-all -o "$mlir_out/02_pipeline.mlir" \
  2> "$mlir_out/pipeline.log"
mlir-opt mlir_exploration/input/vecadd_linalg.mlir \
  --convert-linalg-to-loops --convert-scf-to-cf \
  --mlir-print-ir-after-all --mlir-print-ir-after-change \
  -o "$mlir_out/02_pipeline_changed.mlir" \
  2> "$mlir_out/pipeline_changed.log"
mlir-opt mlir_exploration/input/vecadd_linalg.mlir \
  --convert-linalg-to-loops --convert-scf-to-cf --mlir-timing \
  -o /dev/null 2> "$mlir_out/timing.log"

diff -u "$mlir_out/00_linalg.mlir" "$mlir_out/01_scf.mlir" \
  > "$mlir_out/linalg_vs_scf.diff"
diff -u "$mlir_out/01_scf.mlir" "$mlir_out/02_cf.mlir" \
  > "$mlir_out/scf_vs_cf.diff"
```

阶段比较中的 `diff` 退出码为 1 表示两个阶段存在差异，这是本实验的预期现象。以上命令用于重新生成对应类别的产物；打印格式和耗时可能随工具版本及运行环境变化。

## 小组分工

| 工作内容 | 张晨旭（2411326） | 尚文轩（2412456） |
| --- | --- | --- |
| Part1 | 基础斐波那契实验；预处理、词法、AST 和 IR 分析 | 补充程序；O0/O1/O2 对比；无用计算消除与向量化分析 |
| Part2 | 手写 LLVM IR；基本块、`phi` 和 SSA 数据流分析 | 手写 RV64 汇编；寄存器、数组寻址、栈帧和调用约定分析 |
| MLIR 进阶 | Linalg 表示与索引映射；Linalg→SCF 降低和阶段差异 | SCF→CF 降低；块参数与回边；Pass 日志及耗时分析 |
| 验证与报告 | 主责内容验证及章节撰写，交叉复核汇编和 CF 分析 | 主责内容验证及章节撰写，交叉复核 IR 和 Linalg/SCF 分析 |

实验方案、SysY 示例语义、参考输出对照、MLIR 各阶段语义分析及报告整合由两人共同完成。双方均承担核心技术实现、结果分析和报告撰写。
