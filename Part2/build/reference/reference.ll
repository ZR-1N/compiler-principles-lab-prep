declare i32 @getint()
declare i32 @getch()
declare i32 @getarray(ptr)
declare float @getfloat()
declare i32 @getfarray(ptr)
declare void @putint(i32)
declare void @putch(i32)
declare void @putarray(i32, ptr)
declare void @putfloat(float)
declare void @putfarray(i32, ptr)
declare void @_sysy_starttime(i32)
declare void @_sysy_stoptime(i32)
declare void @llvm.memset.p0.i32(ptr, i8, i32, i1)
declare void @lsccll.lib.memset_i8(ptr, i8, i32)
declare void @lsccll.lib.memset_i32(ptr, i32, i32)
declare void @lsccll.lib.parallel.loop(ptr, i32, i32, i32, i32, ...)


define i32 @calc(ptr %reg_0, i32 %reg_1)
{
Block0: ; Func define at line 2
	%reg_5 = alloca i32
	%reg_3 = alloca i32
	%reg_2 = alloca i32
	store i32 %reg_1, ptr %reg_2
	br label %Block1
Block1: ; Func body at line 2
	%reg_4 = add i32 0, 0
	store i32 %reg_4, ptr %reg_3
	%reg_6 = add i32 0, 0
	store i32 %reg_6, ptr %reg_5
	br label %Block2
Block2: ; While condition at line 6
	%reg_7 = load i32, ptr %reg_3
	%reg_8 = load i32, ptr %reg_2
	%reg_9 = icmp slt i32 %reg_7, %reg_8
	br i1 %reg_9, label %Block3, label %Block4
Block3: ; While body at line 6
	%reg_10 = load i32, ptr %reg_3
	%reg_11 = getelementptr i32, ptr %reg_0, i32 %reg_10
	%reg_12 = load i32, ptr %reg_11
	%reg_13 = add i32 2, 0
	%reg_14 = srem i32 %reg_12, %reg_13
	%reg_15 = add i32 0, 0
	%reg_16 = icmp eq i32 %reg_14, %reg_15
	br i1 %reg_16, label %Block5, label %Block7
Block4: ; While end at line 6
	%reg_34 = load i32, ptr %reg_5
	ret i32 %reg_34
Block5: ; If then at line 7
	%reg_17 = load i32, ptr %reg_5
	%reg_18 = load i32, ptr %reg_3
	%reg_19 = getelementptr i32, ptr %reg_0, i32 %reg_18
	%reg_20 = load i32, ptr %reg_19
	%reg_21 = add i32 2, 0
	%reg_22 = sdiv i32 %reg_20, %reg_21
	%reg_23 = add i32 4, 0
	%reg_24 = mul i32 %reg_22, %reg_23
	%reg_25 = add i32 %reg_17, %reg_24
	store i32 %reg_25, ptr %reg_5
	br label %Block6
Block6: ; If end at line 7
	%reg_31 = load i32, ptr %reg_3
	%reg_32 = add i32 1, 0
	%reg_33 = add i32 %reg_31, %reg_32
	store i32 %reg_33, ptr %reg_3
	br label %Block2
Block7: ; If else at line 7
	%reg_26 = load i32, ptr %reg_5
	%reg_27 = load i32, ptr %reg_3
	%reg_28 = getelementptr i32, ptr %reg_0, i32 %reg_27
	%reg_29 = load i32, ptr %reg_28
	%reg_30 = sub i32 %reg_26, %reg_29
	store i32 %reg_30, ptr %reg_5
	br label %Block6
}

define i32 @main()
{
Block0: ; Func define at line 18
	%reg_21 = alloca i32
	%reg_11 = alloca i32
	%reg_0 = alloca [5 x i32]
	br label %Block1
Block1: ; Func body at line 18
	call void @llvm.memset.p0.i32(ptr %reg_0, i8 0, i32 20, i1 1)
	%reg_1 = add i32 1, 0
	%reg_2 = getelementptr [5 x i32], ptr %reg_0, i32 0, i32 0
	store i32 %reg_1, ptr %reg_2
	%reg_3 = add i32 2, 0
	%reg_4 = getelementptr [5 x i32], ptr %reg_0, i32 0, i32 1
	store i32 %reg_3, ptr %reg_4
	%reg_5 = add i32 3, 0
	%reg_6 = getelementptr [5 x i32], ptr %reg_0, i32 0, i32 2
	store i32 %reg_5, ptr %reg_6
	%reg_7 = add i32 4, 0
	%reg_8 = getelementptr [5 x i32], ptr %reg_0, i32 0, i32 3
	store i32 %reg_7, ptr %reg_8
	%reg_9 = add i32 5, 0
	%reg_10 = getelementptr [5 x i32], ptr %reg_0, i32 0, i32 4
	store i32 %reg_9, ptr %reg_10
	%reg_12 = call i32 @getint()
	store i32 %reg_12, ptr %reg_11
	%reg_13 = load i32, ptr %reg_11
	%reg_14 = add i32 0, 0
	%reg_15 = icmp slt i32 %reg_13, %reg_14
	br i1 %reg_15, label %Block2, label %Block3
Block2: ; If then at line 22
	%reg_16 = add i32 0, 0
	store i32 %reg_16, ptr %reg_11
	br label %Block3
Block3: ; If end at line 22
	%reg_17 = load i32, ptr %reg_11
	%reg_18 = add i32 5, 0
	%reg_19 = icmp sgt i32 %reg_17, %reg_18
	br i1 %reg_19, label %Block4, label %Block5
Block4: ; If then at line 25
	%reg_20 = add i32 5, 0
	store i32 %reg_20, ptr %reg_11
	br label %Block5
Block5: ; If end at line 25
	%reg_22 = getelementptr [5 x i32], ptr %reg_0, i32 0
	%reg_23 = load i32, ptr %reg_11
	%reg_24 = call i32 @calc(ptr %reg_22, i32 %reg_23)
	store i32 %reg_24, ptr %reg_21
	%reg_25 = load i32, ptr %reg_21
	call void @putint(i32 %reg_25)
	%reg_26 = add i32 10, 0
	call void @putch(i32 %reg_26)
	%reg_27 = add i32 0, 0
	ret i32 %reg_27
}
