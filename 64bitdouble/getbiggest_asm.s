.type getbiggest_asm, @function
.global getbiggest_asm
.text

getbiggest_asm:
  movsd %xmm0, %xmm2
  movsd %xmm0, %xmm3

  mulsd %xmm1, %xmm0
  addsd %xmm1, %xmm2
  subsd %xmm1, %xmm3

  ucomisd %xmm2, %xmm0
  jb test_addition
  ucomisd %xmm3, %xmm0
  jb test_addition

  ret

test_addition:
  ucomisd %xmm3, %xmm2
  jb substraction

  movsd %xmm2, %xmm0

  ret

substraction:
  movsd %xmm3, %xmm0

  ret
