.type check_tab, @function
.global check_tab
.text

// Unsigned int check_tab(int* tab, int n, int *max)
// Int * tab - tablica liczb
// N DLUGOSC TABLICY
// Sprawdzic elementy z tablicy pod wzgledem wystepowania liczb z zakresu 0,63
// Trzeba policzyc ile razy ktorys element sie pojawil (np dwojka pojawila sie 5 razy itd)
// Poprzez wskaznik max mamy zwrocic maxymalna liczbe wystapien i funkcja ma zwrocic wartosc w postaci ciagu 64 bitow (kazdy bit okresla wystapienie liczby odpowiadajacy itemu elementu, 1 - jesli wystepuje)
// MIMUM - zliczanie wystepien i zwrocenie maksymalnej liczby wystapien (na 3)

.equ LEFT_BIT, 0x8000000000000000

check_tab:
  mov $0, %rax # czyszczenie wart zwracanej
  mov $0, %rcx # licznik wystapien max
  mov $0, %r11 # liczba z max wystapien
  mov $-1, %r8 # licznik petli glownej

  push %r12
  mov $LEFT_BIT, %r12

main_loop:
  inc %r8

  cmp $64, %r8
  je end

  shr %rax

  mov $-1, %r9 # licznik petli przechodzacej po tablicy
  mov $0, %r10 # licznik wystapien lokalnych

tab_loop:
  inc %r9

  cmp %r9d, %esi
  je continue

  cmp %r8d, (%rdi, %r9, 4)
  jne tab_loop

  inc %r10
  jmp tab_loop

continue:

  cmp $0, %r10
  je main_loop

  or %r12, %rax

  cmp %rcx, %r10
  jl main_loop

  mov %r10, %rcx
  mov %r10, (%rdx)

  jmp main_loop

end:

  pop %r12
  ret
