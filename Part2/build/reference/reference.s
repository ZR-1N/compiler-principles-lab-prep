	.text
	.globl main
	.attribute	4, 16
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0"

calc:
.calc_0:
	sd			s2, -24(sp)
	sd			s1, -16(sp)
	sd			ra, -8(sp)
	addi		sp, sp, -40
	add			a1, x0, a1
	add			s2, x0, a0
	sw			a1, 8(sp)
	jal			x0, .calc_1
.calc_1:
	addiw		t0, x0, 0
	sw			t0, 4(sp)
	addiw		t0, x0, 0
	sw			t0, 0(sp)
	jal			x0, .calc_2
.calc_2:
	lw			t1, 4(sp)
	lw			t0, 8(sp)
	blt			t1, t0, .calc_3
	jal			x0, .calc_4
.calc_3:
	lw			t2, 4(sp)
	add			t2, x0, t2
	slli		t1, t2, 2
	add			t0, s2, t1
	lw			t2, 0(t0)
	addiw		t0, x0, 2
	remw		t1, t2, t0
	addiw		t0, x0, 0
	beq			t1, t0, .calc_5
	jal			x0, .calc_7
.calc_4:
	lw			a0, 0(sp)
	add			a0, x0, a0
	addi		sp, sp, 40
	ld			ra, -8(sp)
	ld			s1, -16(sp)
	ld			s2, -24(sp)
	jalr		x0, ra, 0
.calc_5:
	lw			s1, 0(sp)
	lw			t2, 4(sp)
	add			t2, x0, t2
	slli		t1, t2, 2
	add			t0, s2, t1
	lw			t1, 0(t0)
	addiw		t0, x0, 2
	divw		t2, t1, t0
	addiw		t0, x0, 4
	mulw		t1, t2, t0
	addw		t0, s1, t1
	sw			t0, 0(sp)
	jal			x0, .calc_6
.calc_6:
	lw			t2, 4(sp)
	addiw		t1, x0, 1
	addw		t0, t2, t1
	sw			t0, 4(sp)
	jal			x0, .calc_2
.calc_7:
	lw			s1, 0(sp)
	lw			t2, 4(sp)
	add			t2, x0, t2
	slli		t1, t2, 2
	add			t0, s2, t1
	lw			t1, 0(t0)
	subw		t0, s1, t1
	sw			t0, 0(sp)
	jal			x0, .calc_6
main:
.main_0:
	sd			ra, -8(sp)
	addi		sp, sp, -40
	jal			x0, .main_1
.main_1:
	addi		a0, sp, 8
	addiw		a1, x0, 0
	addiw		a2, x0, 20
	call		memset
	addiw		t1, x0, 1
	addi		t0, sp, 8
	sw			t1, 0(t0)
	addiw		t2, x0, 2
	addiw		t0, x0, 4
	addi		t1, sp, 8
	add			t0, t1, t0
	sw			t2, 0(t0)
	addiw		t2, x0, 3
	addiw		t0, x0, 8
	addi		t1, sp, 8
	add			t0, t1, t0
	sw			t2, 0(t0)
	addiw		t2, x0, 4
	addiw		t0, x0, 12
	addi		t1, sp, 8
	add			t0, t1, t0
	sw			t2, 0(t0)
	addiw		t2, x0, 5
	addiw		t0, x0, 16
	addi		t1, sp, 8
	add			t0, t1, t0
	sw			t2, 0(t0)
	call		getint
	add			a0, x0, a0
	sw			a0, 4(sp)
	lw			t1, 4(sp)
	addiw		t0, x0, 0
	blt			t1, t0, .main_2
	jal			x0, .main_3
.main_2:
	addiw		t0, x0, 0
	sw			t0, 4(sp)
	jal			x0, .main_3
.main_3:
	lw			t1, 4(sp)
	addiw		t0, x0, 5
	bgt			t1, t0, .main_4
	jal			x0, .main_5
.main_4:
	addiw		t0, x0, 5
	sw			t0, 4(sp)
	jal			x0, .main_5
.main_5:
	addi		a0, sp, 8
	lw			a1, 4(sp)
	add			a0, x0, a0
	add			a1, x0, a1
	call		calc
	add			a0, x0, a0
	sw			a0, 0(sp)
	lw			a0, 0(sp)
	add			a0, x0, a0
	call		putint
	addiw		a0, x0, 10
	add			a0, x0, a0
	call		putch
	addiw		a0, x0, 0
	add			a0, x0, a0
	addi		sp, sp, 40
	ld			ra, -8(sp)
	jalr		x0, ra, 0
	.data
