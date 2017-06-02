// unsigned long int check_div (int a, int b, int c)
//
// sprawdzic w zaleznosci od parametru c
// c == 0 a dzieli sie calkowicie przez b
// zwraca reszte
// c != 0 funkcja nie uwzglednia b,
// sprawdza podzielnosc a przez liczby 1..64
// zwraca: najbardziej znaczacy bit to rezultat dzielenia przez 64,
// najmniej to przez 1

.type check_div, @function
.global check_div
.text

.equ INT_MASK, 0xffffffff

check_div:
  mov $INT_MASK, %r8 # chwilowa maska do usuniecia smieci z rdi
  and %r8, %rdi # upewniamy sie ze nie bedzie siupy z intem
  mov $64, %rcx #licznik petli
  mov $0, %r8 # wynik

div_loop:
  shl %r8 # przesuwamy nasz wynik o 1 w lewo

  cmp $0, %rcx # sprawdzamy czy koniec petli
  je end # jak 0 to koniec

  mov $0, %rdx # zerujemy bo się idiv wysypie
  mov %rdi, %rax # a przenosimy do rax bo idiv tam wymaga licznika

  idiv %rcx # dzielimy rax/rcx
  dec %rcx # dekrementujemy rcx do kolejnego obiegu pętli i do ew. zapisu
  cmp $0, %rdx # w rdx jest reszta z dzielenia
  jne div_loop # jak reszta != to nic nie robimy

  or $0x01, %r8 # ustawiamy prawy bit na 1

  jmp div_loop # lecimy od nowa

end:

  mov %r8, %rax # wynik do wart. zwracanej

  ret
