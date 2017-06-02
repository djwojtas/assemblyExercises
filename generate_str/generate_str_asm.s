  .type generate_str_asm, @function
  .global generate_str_asm
  .text

generate_str_asm:
  mov %rsi, %r9 #zaczynamy od tego bo rsi nie da sie podzielic na 8bitow :( a potrzebujemy tego bo char to bajt

  cmp $0, %rcx #sprawdzanie czy mamy inkrementowac
  je no_increment #skocz jak rdx == 0
  mov $1, %rcx #jak nie to ustaw rdx = 1

no_increment:
  mov $0, %r8 #robimy fora gdzie 'int i = 0' to r8 = 0

loop:
  cmp %r8, %rdx #porównujemy rdx z r8
  jle end # jak rdx jest mniejsze lub rowne r8 to skocz do end

  movb %r9b, (%rdi, %r8, 1) #ustawiamy znak w tablicy o adresie zawartym w %rdi przesuniety o %r8*1 elementow
  add %rcx, %r9 #ewentualnie inkrementujemy znak
  inc %r8 #inkrementujemy nasz licznik petli

  jmp loop #skok na pocz petli

end:
  movb $0, (%rdi, %rdx, 1) #dodajemy nulla na koncu zeby printf ogranal koniec stringa
  mov %rdi, %rax #zwracamy adres na nasza tablice
  ret #ELO 320
