  .type encode, @function
  .global encode
 
.text
 
 encode:
  mov %rdi, %rax # zwracamy wskaźnik na podanego str
  mov %cl, %dil # cl potrzebne do shr
  mov $0, %r8 # licznik zapisu
  mov $0, %r9 # licznik odczytu
 
  cmp $0, %edx # jesli operation == 0 to nic nie robimy
  je end
 
  jmp no_inc # pierwsze przejście bez inkrementacji liczników
 
str_loop:
  inc %r8
  inc %r9
 
no_inc:
  mov (%rax, %r9, 1), %r11b # przenosimy znak z odczytu
  mov %r11b, (%rax, %r8, 1) # do zapisu tak aby remove działał
 
  cmp $0x00, (%rax, %r9, 1) # czy koniec strigna?
  je end
 
  cmpb $'0', (%rax, %r9, 1) # czy jest cyfrą cz.1
  jl str_loop
 
  cmpb $'9', (%rax, %r9, 1) # i cz.2
  jg str_loop
 
 
  mov %esi, %r10d # backup maski, bo będę ją przesuwał
 
  mov (%rax, %r9, 1), %cl # przesuwamy odczytywany znak do cl (tylko ten rejestr przyjmuje shr według manuala)
  sub $'0', %cl # robimy ze znaku liczbę z zakresu 0-9
  shr %cl, %r10d # przesuwamy maskę tak aby interesujący bit był najmłodszy
 
  and $0x01, %r10d # maska na ostatni bit
  cmp $0, %r10d # jak 0 to omijamy znak
  je str_loop
 
  cmp $1, %edx # operacja remove?
  je remove
 
  cmp $3, %edx # operacja change?
  je change
 
  mov $'9', %r11b # przygotowanie do transpozycji
  sub %cl, %r11b # transpozycja
  mov %r11b, (%rax, %r8, 1) # zapis nowego znaku
 
  jmp str_loop
 
remove:
  inc %r9 # inkrementujemy tylko licznik odczytu
  jmp no_inc
 
change:
  mov %dil, (%rax, %r8, 1) # podmieniamy znak
 
  jmp str_loop
 
end:
  ret
