  .type max_1_ind_asm, @function
  .global max_1_ind_asm
  .text

# rdi  long long* tab,
# rsi  long long n,
# rdx  long long* even_count,
# rcx  long long* neg_count

max_1_ind_asm:
  push %r12 # zapisujemy rejestr chroniony, bedziemy tu trzymac max ilosc jedynek
  mov $0, %r12 # zerujemy maxa
  mov %rdx, %r8 # ten rejestr bedziemy uzywac przy dzieleniu
  mov $0, %r11 # to jest wartosc zwracana - tu bedzie indeks ktory ma najwiecej 1 w binarnym
  movq $0, (%r8) # zerujemy even_count
  movq $0, (%rcx) # zerujemy neg_count
  sub $1, %rsi # odejmujemy 1 od n tak zeby sprawdzac indeksy tablicy od (0..n-1)

main_loop:
  cmp $0, %rsi # sprawdzamy czy rsi jest >= 0
  jnge end # jak nie to koniec

  mov (%rdi, %rsi, 8), %r9 # przenosimy element tablicy do r9
  mov %r9, %rax # kopiujemy, bo bedziemy kilka razy edytowac a przeniesienie rejestr -> rejestr jest wydajniejsze

  and $0x01, %rax
  cmp $1, %rax # w rdx jest reszta z dzielenia
  je odd # jak nieparzysta to skacz
  incq (%r8) # jak nie to dodaj 1 do licznika

odd:

  mov %r9, %rax # przenosimy od nowa element z tablicy bo znowu go zniszczymy
  mov $0x8000000000000000, %r10 # przenosimy maske do rejestru
  and %r10, %rax # nakladamy maske
  cmp $0, %rax # sprawdzamy czy jest dodatnia
  je positive # jak tak to skacz
  incq (%rcx) # jak nie to dodaj 1 do neg_count

positive:

  mov $0, %rdx # to bedzie ilosc 1
  mov $0x01, %r10 # przenosimy maske do rejestru

one_counting:

  mov %r9, %rax # przenosimy element tablicy do zalozenia maski
  and %r10, %rax # nakladamy maske
  add %rax, %rdx # jak na skraju byla jedynka to ja dodajemy (jak nie bylo to dodajemy zero)

  shr $1, %r9 # przesuwamy bity elementu o 1 w prawo
  cmp $0, %r9 # jak jest 0 to juz nie bedzie jedynek
  jne one_counting # jak jednak cos jest to lecimy dalej

# ----------

  cmp %r12, %rdx # prowonojemy ilosc jedynek z maxem
  jl cnt # jak jest mniejsza niz max to skaczemy
  mov %rdx, %r12 # jak nie to zapisujemy max ilosc jedynek
  mov %rsi, %r11 # i indeks

cnt:

  dec %rsi # zmniejszamy indeks
  jmp main_loop # i od nowa

end:

  pop %r12 # przywracamy wartosc r12
  mov %r11, %rax # przenosimy wartosc zwracana tam gdzie ma byc
  ret # NARA
