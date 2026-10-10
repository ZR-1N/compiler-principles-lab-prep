; Handwritten LLVM IR for reference.sy (opaque-pointer syntax).
; No SysY-to-IR compiler was used.
; Link with the SysY runtime providing getint, putint, and putch.

declare i32 @getint()
declare void @putint(i32)
declare void @putch(i32)

define i32 @calc(ptr %a, i32 %n) {
entry:
  br label %loop.cond

loop.cond:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop.latch ]
  %ans = phi i32 [ 0, %entry ], [ %ans.next, %loop.latch ]
  %in.range = icmp slt i32 %i, %n
  br i1 %in.range, label %loop.body, label %loop.end

loop.body:
  %idx = sext i32 %i to i64
  %elem.ptr = getelementptr inbounds i32, ptr %a, i64 %idx
  %value = load i32, ptr %elem.ptr, align 4
  %remainder = srem i32 %value, 2
  %is.even = icmp eq i32 %remainder, 0
  br i1 %is.even, label %if.even, label %if.odd

if.even:
  %half = sdiv i32 %value, 2
  %four.times.half = mul i32 %half, 4
  %ans.even = add i32 %ans, %four.times.half
  br label %loop.latch

if.odd:
  %ans.odd = sub i32 %ans, %value
  br label %loop.latch

loop.latch:
  %ans.next = phi i32 [ %ans.even, %if.even ], [ %ans.odd, %if.odd ]
  %i.next = add i32 %i, 1
  br label %loop.cond

loop.end:
  ret i32 %ans
}

define i32 @main() {
entry:
  ; A local SysY array (five consecutive 32-bit elements).
  %a = alloca [5 x i32], align 16
  %a0 = getelementptr inbounds [5 x i32], ptr %a, i64 0, i64 0
  %a1 = getelementptr inbounds [5 x i32], ptr %a, i64 0, i64 1
  %a2 = getelementptr inbounds [5 x i32], ptr %a, i64 0, i64 2
  %a3 = getelementptr inbounds [5 x i32], ptr %a, i64 0, i64 3
  %a4 = getelementptr inbounds [5 x i32], ptr %a, i64 0, i64 4
  store i32 1, ptr %a0, align 4
  store i32 2, ptr %a1, align 4
  store i32 3, ptr %a2, align 4
  store i32 4, ptr %a3, align 4
  store i32 5, ptr %a4, align 4

  %input = call i32 @getint()

  ; Two consecutive if-statements, represented by SSA selects.
  %negative = icmp slt i32 %input, 0
  %nonnegative = select i1 %negative, i32 0, i32 %input
  %too.large = icmp sgt i32 %nonnegative, 5
  %n = select i1 %too.large, i32 5, i32 %nonnegative

  %result = call i32 @calc(ptr %a0, i32 %n)
  call void @putint(i32 %result)
  call void @putch(i32 10)
  ret i32 0
}
