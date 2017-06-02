.type getbiggest_asm_32, @function
.global getbiggest_asm_32
.text

getbiggest_asm_32:
  push %ebp
  mov %esp, %ebp

  fldl 8(%ebp)
  fmull 16(%ebp)
  fstpl -8(%ebp)

  fldl 8(%ebp)
  faddl 16(%ebp)
  fstpl -16(%ebp)

  fldl 8(%ebp)
  fsubl 16(%ebp)
  fstpl -24(%ebp)

  fldl -8(%ebp)
  fldl -16(%ebp)

  fcomip	%st(1), %st(0)
  ja test_addition

  fldl -24(%ebp)

  fcomip	%st(1), %st(0)
  ja test_addition

  jmp end

test_addition:
  fstp %st(0)
  fldl -16(%ebp)
  fldl -24(%ebp)

  fcomi	%st(1), %st(0)
  ja substraction

  fstp %st(0)

  jmp end

substraction:
  fstp %st(0)
  fstp %st(0)
  fldl -24(%ebp)

end:
  mov %ebp, %esp
  pop %ebp
  ret
