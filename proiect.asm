    .586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extern printf: proc
extern puts: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Exemplu proiect desenare",0
area_width EQU 640
area_height EQU 450
area DD 0

doi DD 0
noua DD 9
patru DD 4
zece DD 10
nrbombe DD 15
seventeen DD 17
fifteen DD 15
sixteen DD 16
index DD 0
bombe_vecine DD 0
vector_logic DD 289 DUP(0) ;17*17 pt ca am borduri
vector_stare DD 289 DUP(0)
format DB "%d    ", 0
linie DB " ", 0 ;backtick ca sa functione ca endline
adr DD 0
adr_stare DD 0
adr_inc_vect DD 0
current_x_vec DD 0
current_y_vec DD 0
bomba_apasata DD 0
nr_tile_apasate DD 210 

x_temp DD 0
y_temp DD 0

counter0 DD 0 ; numara evenimentele de tip timer
counter1 DD 0
counterOK DD 0; nr3 s
cinci DD 5

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

image_width EQU 16
image_height EQU 16
include mine.inc
include tile.inc
include point_flag.inc
include empty tile.inc
include flag.inc
include zero.inc
include unu.inc
include doi.inc
include trei.inc
include patru.inc
include cinci.inc
include sase.inc

current_tile_x DD 0
current_tile_y DD 0
x_first_tile EQU 160
y_first_tile EQU 144
tile_pe_linie EQU 15

symbol_width EQU 10
symbol_height EQU 20
include digits.inc
include letters.inc
point_flag_height EQU 20
point_flag_width EQU 20

point_tile_x EQU 200
point_tile_y EQU 80
point_tile_size EQU 50

point_block_x EQU 255
point_block_y EQU 40
point_block_size EQU 50

flag_tile_block DD 0 ;0 tile, 1 flag

point_flag_x EQU 310
point_flag_y EQU 80
point_flag_size EQU 50

bombe_x EQU 10
bombe_y EQU 0
bombe_size EQU	80

timer_x EQU 550
timer_y EQU 0
timer_size EQU	80

.code
make_zero proc
	push ebp
	mov ebp, esp
	pusha
	
	push EAX
	push EBX
	push ECX
	push EDX

	lea esi, zero_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	
	pop EDX
	pop ECX
	pop EBX
	pop EAX
	
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_zero endp

; simple macro to call the procedure easier
make_zero_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_zero
	add esp, 12
endm

make_one proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, unu_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_one endp

; simple macro to call the procedure easier
make_one_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_one
	add esp, 12
endm

make_two proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, doi_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_two endp

; simple macro to call the procedure easier
make_two_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_two
	add esp, 12
endm

make_three proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, trei_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_three endp

; simple macro to call the procedure easier
make_three_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_three
	add esp, 12
endm

make_four proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, patru_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_four endp

; simple macro to call the procedure easier
make_four_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_four
	add esp, 12
endm

make_five proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, cinci_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_five endp

; simple macro to call the procedure easier
make_five_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_five
	add esp, 12
endm

make_six proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, sase_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_six endp

; simple macro to call the procedure easier
make_six_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_six
	add esp, 12
endm

bordare macro
local bucla1, bucla2
	push EAX
	push EBX
	push ECX
	push EDX
	
	lea EAX, vector_logic
	mov index,17
	mov ECX, 17
bucla1:
	mov EBX, -1
	mov [EAX], EBX
	add EAX, 4
	loop bucla1
	
	mov EAX, index
	mul sixteen
	mul patru
	mov EDX, EAX
	lea EAX, vector_logic
	add EAX, EDX
	mov ECX, 17
bucla2:
	mov EBX,-1
	mov [EAX], EBX
	add EAX,4
	loop bucla2
	
	pop EDX
	pop ECX
	pop EBX
	pop EAX
endm

inserare_bombe macro 
local bucla
	push EAX
	push EBX
	push ECX
	push EDX

	mov ECX, 15 ;nr bombe
	mov index, 0
bucla:
	lea EAX, vector_logic ; pun in EAX adresa vectorului
	add EAX, 68 ; sa inceapa mereu sub bordura de sus
	mov adr, EAX
	push EAX ; o salvez pt ca voi folosi EAX la altceva
	mov EAX, 0
	xor EDX, EDX
	rdtsc ;valori random in EAX si EDX
	mov EDX, 0
	mov DL, AL
	mov EAX, 0
	mov AL, DL
	mov EDX, 0 ;RDTSC E PSEUDO ALEATOR
	mov EAX, 0
	xor EDX, EDX
	rdtsc ;valori random in EAX si EDX
	mov EDX, 0
	mov DL, AL
	mov EAX, 0
	mov AL, DL
	mov EDX, 0
	div fifteen ; impart cu 15 pt a primit o coloana random
	mov EAX, index
	push EDX ;salvam valoarea
	mul seventeen;inmultesc linia cu nr coloane
	mul patru ;un element are 4 bytes
	push EAX
	push EAX
	mov EBX, -1
	add EAX, adr
	mov [EAX], EBX
	pop EAX; reluam iar linia
	add EAX, adr
	add EAX, 64
	mov [EAX], EBX
	pop EAX
	add EAX, 4
	mov EBX, EAX; pastram temporar in EBX valoarea calculata
	mov EAX, 0
	pop EDX
	add EAX, EDX ;adaug restul adica coloana la care suntem pe aceea linie
	mul patru ;inmultim cu patru pt ca fiecare element are 4 bytes (coloana * 4)
	add EAX, EBX
	mov EDX, EAX ; pun temporar indexul calculat
	pop EAX ; scot adresa liniei a 2 a vectorului
	add EAX, EDX 
	mov EBX, 100
	mov [EAX], EBX ;adaug pe linia index + DL(pozitia de pe linia index) o bomba
	inc index
	dec ECX
	cmp ECX, 0
	jg bucla	
	
	pop EDX
	pop ECX
	pop EBX
	pop EAX
endm

nr_bombe_vecini macro 
local bucla1, bomba1, next1, bucla2, bomba2, next2, bucla3, bomba3, next3
	push EAX
	push EBX ; salvam valorile de dinaintea folosirii macroului
	push ECX
; cele trei elemente de deasupra	
	mov EBX, adr
	sub EBX, 72; mutam EBX colt stanga sus , 72 pt ca aici am 17 elemente pe rand
	mov ECX, 3
bucla1:
	mov EAX, 100
	cmp [EBX], EAX
	je bomba1
	jmp next1
bomba1:
	inc bombe_vecine
next1:
	add EBX, 4
	dec ECX
	cmp ECX, 0
	jg bucla1

;elementele din stanga si dreapta	
mov EBX, adr
sub EBX, 4
mov ECX, 2
bucla2:
	mov EAX, 100
	cmp[EBX], EAX
	je bomba2
	jmp next2
bomba2:
	inc bombe_vecine
next2:
	add EBX, 8
	dec ECX
	cmp ECX, 0
	jg bucla2
	
;cele 3 elemente de sub
mov EBX, adr
add EBX, 64
mov ECX, 3
bucla3:
	mov EAX, 100
	cmp[EBX], EAX
	je bomba3
	jmp next3
bomba3:
	inc bombe_vecine
next3:
	add EBX, 4
	dec ECX
	cmp ECX, 0
	jg bucla3
	
	mov EBX, adr
	mov EAX, bombe_vecine
	mov [EBX], EAX
	
	pop ECX
	pop EBX
	pop EAX
endm

inserare_nr_bombe macro
local bucla, next_tile
	push EAX
	push EBX
	push ECX
	
	mov ECX, 289
	lea EAX, vector_logic
bucla:
	mov EBX, -1
	cmp [EAX], EBX
	je next_tile
	mov EBX, 100
	cmp [EAX], EBX
	je next_tile
	mov bombe_vecine, 0
	push ECX
	mov adr, EAX
	nr_bombe_vecini
	pop ECX
next_tile:
	add EAX, 4
	dec ECX
	cmp ECX, 0
	jg bucla
	
	pop ECX
	pop EBX
	pop EAX
endm

afisare_matrice_logica macro
local bucla, linie_noua, next_element, afara
	push EAX
	push EBX
	push ECX
	push EDX

mov ECX, 288
lea EAX, vector_logic
bucla:
	push ECX ;punem pe stiva, deoarece se modifica dupa printf
	push EAX
	push [EAX] ;punem elementul i din vector pe stiva
	push offset format
	call printf
	add ESP, 8
	pop EAX
	pop ECX ;luam valorile de dinainte de modificare
	add EAX, 4 ;trecem la urmatorul element din vector
	; punem un endline daca e multiplu de nrcoloane
	push EAX
	mov EAX, ECX
	mov EDX, 0
	div seventeen
	cmp EDX, 0
	je linie_noua
	jmp next_element
linie_noua:
	push ECX
	push offset linie
	call puts
	add ESP, 4
	pop ECX
next_element:
	pop EAX
	sub ECX, 1
	cmp ECX, 0
	jl afara
	jmp bucla
afara:
	pop EDX
	pop ECX
	pop EBX
	pop EAX	
endm



initializare_matr_stare macro
local bucla, next_rand, next
	push EAX
	push EBX
	push ECX
	push EDX

	lea EAX, vector_stare
	add EAX, 72
	mov EDX, 1; coloana la care suntem
	mov ECX, 225
bucla:
	mov EBX, 0
	mov [EAX], EBX
	add EAX, 4
	inc EDX
	cmp EDX, 16
	je next_rand
	jmp next
next_rand:
	add EAX, 8
	mov EDX, 1 ; rand nou
next:
	dec ECX
	cmp ECX, 0
	jg bucla
	
	pop EDX
	pop ECX
	pop EBX
	pop EAX
endm

bordare_stare macro
local bucla1, bucla2
	push EAX
	push EBX
	push ECX
	push EDX
	
	lea EAX, vector_stare
	mov index,17
	mov ECX, 17
bucla1:
	mov EBX, -1
	mov [EAX], EBX
	add EAX, 4
	loop bucla1
	
	mov EAX, index
	mul sixteen
	mul patru
	mov EDX, EAX
	lea EAX, vector_stare
	add EAX, EDX
	mov ECX, 17
bucla2:
	mov EBX,-1
	mov [EAX], EBX
	add EAX,4
	loop bucla2
	
	pop EDX
	pop ECX
	pop EBX
	pop EAX
endm

bordare_lat_stare macro 
local bucla
	push EAX
	push EBX
	push ECX
	push EDX

	mov ECX, 15 ;nr bombe
	mov index, 0
bucla:
	lea EAX, vector_stare ; pun in EAX adresa vectorului
	add EAX, 68 ; sa inceapa mereu sub bordura de sus
	mov adr_stare, EAX
	
	mov EAX, index
	mul seventeen;inmultesc linia cu nr coloane
	mul patru ;un element are 4 bytes
	mov EBX, -1
	add EAX, adr_stare
	mov [EAX], EBX
	add EAX, 64
	mov [EAX], EBX

	inc index
	dec ECX
	cmp ECX, 0
	jg bucla	
	
	pop EDX
	pop ECX
	pop EBX
	pop EAX
endm

afisare_matrice_stare macro
local bucla, linie_noua, next_element, afara
	push EAX
	push EBX
	push ECX
	push EDX

mov ECX, 288
lea EAX, vector_stare
bucla:
	push ECX ;punem pe stiva, deoarece se modifica dupa printf
	push EAX
	push [EAX] ;punem elementul i din vector pe stiva
	push offset format
	call printf
	add ESP, 8
	pop EAX
	pop ECX ;luam valorile de dinainte de modificare
	add EAX, 4 ;trecem la urmatorul element din vector
	; punem un endline daca e multiplu de nrcoloane
	push EAX
	mov EAX, ECX
	mov EDX, 0
	div seventeen
	cmp EDX, 0
	je linie_noua
	jmp next_element
linie_noua:
	push ECX
	push offset linie
	call puts
	add ESP, 4
	pop ECX
next_element:
	pop EAX
	sub ECX, 1
	cmp ECX, 0
	jl afara
	jmp bucla
afara:
	pop EDX
	pop ECX
	pop EBX
	pop EAX	
endm

; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

make_bomb proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, mine_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_bomb endp

; simple macro to call the procedure easier
make_bomb_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_bomb
	add esp, 12
endm

make_tile proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, tile_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_tile endp

; simple macro to call the procedure easier
make_tile_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_tile
	add esp, 12
endm

make_point_flag proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, point_flagg_0
	
draw_image:
	mov ecx, point_flag_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, point_flag_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, point_flag_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_point_flag endp

; simple macro to call the procedure easier
make_point_flag_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_point_flag
	add esp, 12
endm

make_empty_tile proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, empty_tile_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_empty_tile endp

; simple macro to call the procedure easier
make_empty_tile_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_empty_tile
	add esp, 12
endm

line_horizontal macro x, y, len, color
local bucla
	mov EAX, y 
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	
	mov ECX, len
bucla:
	mov DWORD PTR [EAX], color
	add EAX, 4
	loop bucla
endm

line_vertical macro x, y, len, color
local bucla
	mov EAX, y 
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	
	mov ECX, len
bucla:
	mov DWORD PTR [EAX], color
	add EAX, area_width*4
	loop bucla
endm

tile_map macro area, x, y
local bucla, urm_linie, next_tile
	mov EAX, x
	mov EBX, y
	mov EDX, 1
	mov ECX, 225
bucla:
	make_tile_macro area, EAX, EBX
	cmp EDX, 15
	je urm_linie
	inc EDX
	add EAX, 16
	jmp next_tile
urm_linie:
	mov EAX, x_first_tile
	add EBX, 16
	mov EDX, 1
next_tile:
	loop bucla
endm

make_flag proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, flag_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_flag endp

; simple macro to call the procedure easier
make_flag_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_flag
	add esp, 12
endm

lat_sus_st macro x, y, len, color
local bucla
	mov EAX, y 
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	
	mov ECX, len
bucla:
	mov DWORD PTR [EAX], color
	sub EAX, area_width*4
	sub EAX, 4
	loop bucla
endm

lat_sus_dr macro x, y, len, color
local bucla
	mov EAX, y 
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	
	mov ECX, len
bucla:
	mov DWORD PTR [EAX], color
	sub EAX, area_width*4
	add EAX, 4
	loop bucla
endm

lat_jos_st macro x, y, len, color
local bucla
	mov EAX, y 
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	
	mov ECX, len
bucla:
	mov DWORD PTR [EAX], color
	add EAX, area_width*4
	sub EAX, 4
	loop bucla
endm

lat_jos_dr macro x, y, len, color
local bucla
	mov EAX, y 
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	
	mov ECX, len
bucla:
	mov DWORD PTR [EAX], color
	add EAX, area_width*4
	add EAX, 4
	loop bucla
endm

;var 1- x 
;var2 - y
descoperire proc ;trebuie sa trimit eax si edx ca argumente?
	push ebp
	mov ebp, esp ; pregatim stack frame-ul
	mov EBX, [EBP+8]
	mov x_temp, EBX
	mov EBX, [EBP+12]
	mov y_temp, EBX
	
	dec nr_tile_apasate
	
	mov EBX, 0
colt_sus_st:
	cmp [EAX-72], EBX
	je verificare_zero_0
deasupra:
	cmp [EAX-68], EBX
	je verificare_zero_1
colt_sus_dr:
	cmp [EAX-64], EBX
	je verificare_zero_2
stanga:
	cmp [EAX-4], EBX
	je verificare_zero_3
dreapta:
	cmp [EAX+4], EBX
	je verificare_zero_4
colt_jos_st:
	cmp [EAX+64], EBX
	je verificare_zero_5
dedesubt:
	cmp [EAX+68], EBX
	je verificare_zero_6
colt_jos_dr:
	cmp [EAX+72], EBX
	je verificare_zero_7
jmp outside
	
verificare_zero_0:
	cmp [EDX-72], EBX
	jne deasupra
	push x_temp
	push y_temp
	sub x_temp, 16
	sub Y_temp, 16
	make_zero_macro area, x_temp, y_temp
	
	mov EBX, 1
	mov [EDX-72], EBX
	push EDX
	push EAX
	sub EDX, 72
	sub EAX, 72
	push y_temp
	push x_temp
	call descoperire
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp deasupra
verificare_zero_1:
	cmp [EDX-68], EBX
	jne colt_sus_dr
	push x_temp
	push y_temp
	sub y_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX-68], EBX
	push EDX
	push EAX
	sub EDX, 68
	sub EAX, 68
	push y_temp
	push x_temp
	call descoperire
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp colt_sus_dr
verificare_zero_2:
	cmp [EDX-64], EBX
	jne stanga
	push x_temp
	push y_temp	
	add x_temp, 16
	sub y_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX-64], EBX
	push EDX
	push EAX
	sub EDX, 64
	sub EAX, 64
	push y_temp
	push x_temp
	call descoperire	
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp stanga
verificare_zero_3:
	cmp [EDX-4], EBX
	jne dreapta

	push x_temp
	push y_temp	
	sub x_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX-4], EBX
	push EDX
	push EAX
	sub EDX, 4
	sub EAX, 4
	push y_temp
	push x_temp
	call descoperire
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp dreapta
verificare_zero_4:
	cmp [EDX+4], EBX
	jne colt_jos_st

	push x_temp
	push y_temp	
	add x_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX+4], EBX
	push EDX
	push EAX
	add EDX, 4
	add EAX, 4
	push y_temp
	push x_temp
	call descoperire
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp colt_jos_st
verificare_zero_5:
	cmp [EDX+64], EBX
	jne dedesubt

	push x_temp
	push y_temp	
	sub x_temp, 16
	add y_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX+64], EBX
	push EDX
	push EAX
	add EDX, 64
	add EAX, 64
	push y_temp
	push x_temp
	call descoperire
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp dedesubt
verificare_zero_6:
	cmp [EDX+68], EBX
	jne colt_jos_dr

	push x_temp
	push y_temp	
	add y_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX+68], EBX
	push EDX
	push EAX
	add EDX, 68
	add EAX, 68
	push y_temp
	push x_temp
	call descoperire	
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
	jmp colt_jos_dr
verificare_zero_7:
	cmp [EDX+72], EBX
	jne outside

	push x_temp
	push y_temp	
	add x_temp, 16
	add y_temp, 16
	make_zero_macro area, x_temp, y_temp
	mov EBX, 1
	mov [EDX+72], EBX
	push EDX
	push EAX
	add EDX, 72
	add EAX, 72
	push y_temp
	push x_temp
	call descoperire	
	
	pop EAX
	pop EDX
	pop y_temp
	pop x_temp
outside:	
	
	mov esp, ebp
	pop ebp
	ret 8
descoperire endp

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
first:
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	initializare_matr_stare
	mov EBX, 0
	mov bomba_apasata, EBX
	mov nr_tile_apasate, 210 
	mov nrbombe, 15
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	tile_map area, x_first_tile, y_first_tile ;afisez tile urile
	jmp afisare_litere
	
evt_click:
	mov EBX, 0
	cmp bomba_apasata, EBX
	je bomba_neapasata
	mov [EBP+arg1], EBX
	mov counter0, 0
;	mov nrbombe, 15
	popa
	pop EBP
	jmp first
	
bomba_neapasata:
;verific daca am apasat pe butonul de block
	mov EAX, [EBP+arg2]; x
	cmp EAX, point_block_x
	jl apasare_empty_tile
	cmp EAX, point_block_x+50
	jg apasare_empty_tile
	mov EAX, [EBP+arg3]
	cmp EAX, point_block_y
	jl apasare_empty_tile
	cmp EAX, point_block_Y+30
	jg apasare_empty_tile
	mov flag_tile_block, 2
	jmp evt_timer
;verific daca am apasat pe butonul de tile
apasare_empty_tile:
	mov EAX, [EBP+arg2]; x
	cmp EAX, point_tile_x
	jl apasare_flag
	cmp EAX, point_tile_x+50
	jg apasare_flag
	mov EAX, [EBP+arg3]
	cmp EAX, point_tile_y
	jl apasare_flag
	cmp EAX, point_tile_Y+30
	jg apasare_flag
	mov flag_tile_block, 0
	jmp evt_timer
	
;verific daca am apasat pe butonul de flag
apasare_flag:
	mov EAX, [EBP+arg2]; x
	cmp EAX, point_flag_x
	jl click_pe_harta
	cmp EAX, point_flag_x+50
	jg click_pe_harta
	mov EAX, [EBP+arg3]
	cmp EAX, point_flag_y
	jl click_pe_harta
	cmp EAX, point_flag_Y+30
	jg click_pe_harta
	mov flag_tile_block, 1
	jmp evt_timer

click_pe_harta:
	mov EAX, [EBP+arg2]; x
	cmp EAX, x_first_tile
	jl button_fail
	cmp EAX, x_first_tile+240
	jg button_fail
	mov EAX, [EBP+arg3]
	cmp EAX, y_first_tile
	jl button_fail
	cmp EAX, y_first_tile+240
	jg button_fail
	;s a dat click in matricea cu tile-uri
	mov EAX, [EBP+arg2]; x
	mov ECX, EAX ;  pastrez temporar
	mov EDX, 0
	div sixteen ;impart cu lungimea/latimea imaginii pt a afla restul
	mov EAX, ECX
	sub EAX, EDX
	mov current_tile_x, EAX ; salvez pozitia lui x
	;y 
	mov EAX, [EBP+arg3]; y
	mov ECX, EAX ;  pastrez temporar
	mov EDX, 0
	div sixteen ;impart cu lungimea/latimea imaginii pt a afla restul
	mov EAX, ECX
	sub EAX, EDX
	mov current_tile_y, EAX ; salvez pozitia lui y
	
	;scad din poz curent pe poz initial si impart la 16 pt ca o imagine are 16 pixeli
	mov EAX, current_tile_x
	sub EAX, x_first_tile
	mov EDX, 0
	div sixteen
	mov current_x_vec, EAX
	mov EAX, current_tile_y
	sub EAX, y_first_tile
	mov EDX, 0
	div sixteen
	mov current_y_vec, EAX
	
	mov EAX, current_y_vec
	mul doi
	mul patru
	mov EBX, EAX; pastram in EBX temporar nr de -1 peste care sa sarim
	mov EAX, current_y_vec
	mul seventeen
	mul patru
	add EBX, EAX; adaugam nr de elem pe toate liniile 
	mov EAX, current_x_vec
	mul patru
	add EBX, EAX
	lea EAX, vector_logic
	add EAX, 72 ;incepem verificarea de la primul element diferit de -1
	
	lea EDX, vector_stare
	add EDX, 72
	add EDX, EBX 
	
	add EAX, EBX
	
	cmp flag_tile_block, 0
	je empty_tile
	cmp flag_tile_block, 1
	je put_flag
	jmp put_block
	
empty_tile: ;empty tile
	afisare_matrice_stare
	mov EBX, 2
	cmp [EDX], EBX
	je put_block  ;daca s a pus flag in locul ala putem pune doar block
	
	mov EBX, 1
	cmp [EDX], EBX
	je evt_timer
	mov [EDX], EBX
	
	mov EBX, 0
	cmp [EAX], EBX
	je nr_zero
	mov EBX, 1
	cmp [EAX], EBX
	je nr_unu
	mov EBX, 2
	cmp [EAX], EBX
	je nr_doi
	mov EBX, 3
	cmp [EAX], EBX
	je nr_trei
	mov EBX, 4
	cmp [EAX], EBX
	je nr_patru
	mov EBX, 5
	cmp [EAX], EBX
	je nr_cinci
	mov EBX, 6
	cmp [EAX], EBX
	je nr_sase
	mov EBX, 100
	cmp [EAX], EBX
	je is_bomb
	jmp evt_timer
nr_zero:
	make_zero_macro area, current_tile_x, current_tile_y
	push current_tile_y
	push current_tile_x
	call descoperire
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
nr_unu:
	make_one_macro area, current_tile_x, current_tile_y
	dec nr_tile_apasate
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
nr_doi:
	make_two_macro area, current_tile_x, current_tile_y
	dec nr_tile_apasate
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
nr_trei:
	make_three_macro area, current_tile_x, current_tile_y
	dec nr_tile_apasate
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
nr_patru:
	make_four_macro area, current_tile_x, current_tile_y
	dec nr_tile_apasate
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
nr_cinci:
	make_five_macro area, current_tile_x, current_tile_y
	dec nr_tile_apasate
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
nr_sase:
	make_six_macro area, current_tile_x, current_tile_y
	dec nr_tile_apasate
	cmp nr_tile_apasate, 0
	je win
	jmp evt_timer
is_bomb:
	make_bomb_macro area, current_tile_x, current_tile_y
	make_text_macro 'G', area, 230, 115
	make_text_macro 'A', area, 240, 115
	make_text_macro 'M', area, 250, 115
	make_text_macro 'E', area, 260, 115
	
	make_text_macro 'O', area, 280, 115
	make_text_macro 'V', area, 290, 115
	make_text_macro 'E', area, 300, 115
	make_text_macro 'R', area, 310, 115
	mov bomba_apasata, 1
	jmp final_draw
win:
	make_text_macro 'Y', area, 240, 115
	make_text_macro 'O', area, 250, 115
	make_text_macro 'U', area, 260, 115
	
	make_text_macro 'W', area, 280, 115
	make_text_macro 'O', area, 290, 115
	make_text_macro 'N', area, 300, 115
	mov bomba_apasata, 1
	jmp final_draw
put_flag:
	mov EBX, 1
	cmp [EDX], EBX
	je evt_timer
	mov EBX, 2
	cmp [EDX], EBX
	je evt_timer
	mov EBX, 2
	mov [EDX], EBX
	dec nrbombe
	make_flag_macro area, current_tile_x, current_tile_y
	jmp evt_timer
	
put_block:
	mov EBX, 0
	cmp [EDX], EBX
	je evt_timer ;daca e gol nu putem pune blocl =)
	mov EBX, 1 ; daca e descoperit nu mai punem
	cmp [EDX], EBX
	je evt_timer
	mov EBX, 3
	cmp [EDX], EBX
	je evt_timer
	mov [EDX], EBX
	inc nrbombe
	make_tile_macro area, current_tile_x, current_tile_y
	jmp evt_timer
	
button_fail:
	jmp evt_timer
	
evt_timer:
	inc counter0
	
afisare_litere:
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov EDX, 0
	mov EAX, counter0
	div cinci
	mov counter1, EAX
	
	mov ebx, 10
	mov eax, counter1
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 600, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 590, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 580, 10
	
	;scriem un mesaj
	make_text_macro 'B', area, 540, 400
	make_text_macro 'A', area, 550, 400
	make_text_macro 'L', area, 560, 400
	make_text_macro 'A', area, 570, 400
	make_text_macro 'N', area, 580, 400
	
	make_text_macro 'S', area, 500, 420
	make_text_macro 'I', area, 510, 420
	make_text_macro 'L', area, 520, 420
	make_text_macro 'V', area, 530, 420
	make_text_macro 'I', area, 540, 420
	make_text_macro 'U', area, 550, 420
	make_text_macro 'S', area, 570, 420
	make_text_macro 'T', area, 580, 420
	make_text_macro 'E', area, 590, 420
	make_text_macro 'F', area, 600, 420
	make_text_macro 'A', area, 610, 420
	make_text_macro 'N', area, 620, 420
	
	;cutia in care tinem nr de bombe
	line_horizontal bombe_x, bombe_y, bombe_size, 0
	line_horizontal bombe_x, bombe_y+bombe_size/2, bombe_size, 0
	line_vertical bombe_x, bombe_y, bombe_size/2, 0
	line_vertical bombe_x+bombe_size, bombe_y, bombe_size/2, 0
	
	;cutia in care tinem nr de tile uri apasate
	line_horizontal 430, bombe_y, bombe_size, 0
	line_horizontal 430, bombe_y+bombe_size/2, bombe_size, 0
	line_vertical 430, bombe_y, bombe_size/2, 0
	line_vertical 430+bombe_size, bombe_y, bombe_size/2, 0
	;afisam nr tile_uri ramase nedescoperite
	mov ebx, 10
	mov eax, nr_tile_apasate
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 475, bombe_y+10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 465, bombe_y+10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 455, bombe_y+10
	;text nr tile_uri nedescoperite
	make_text_macro 'B', area, 430, 45
	make_text_macro 'L', area, 440, 45
	make_text_macro 'O', area, 450, 45
	make_text_macro 'C', area, 460, 45
	make_text_macro 'U', area, 470, 45
	make_text_macro 'R', area, 480, 45
	make_text_macro 'I', area, 490, 45
	
	make_text_macro 'N', area, 430, 65
	make_text_macro 'E', area, 440, 65
	make_text_macro 'A', area, 450, 65
	make_text_macro 'P', area, 460, 65
	make_text_macro 'A', area, 470, 65
	make_text_macro 'S', area, 480, 65
	make_text_macro 'A', area, 490, 65
	make_text_macro 'T', area, 500, 65
	make_text_macro 'E', area, 510, 65
	
	; afisam nr bombe
	mov ebx, 10
	mov eax, nrbombe
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 55, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 45, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 35, 10
	
	
	;cutia in care tinem timerul de la inceperea jocului
	line_horizontal timer_x, timer_y, timer_size, 0
	line_horizontal timer_x, timer_y+timer_size/2, timer_size, 0
	line_vertical timer_x, timer_y, timer_size/2, 0
	line_vertical timer_x+timer_size, timer_y, timer_size/2, 0
	
	;text cate bombe au ramas
	make_text_macro 'N', area, 10, 45
	make_text_macro 'R', area, 20, 45
	
	make_text_macro 'B', area, 40, 45
	make_text_macro 'O', area, 50, 45
	make_text_macro 'M', area, 60, 45
	make_text_macro 'B', area, 70, 45
	make_text_macro 'E', area, 80, 45
	
	make_text_macro 'R', area, 20, 65
	make_text_macro 'A', area, 30, 65
	make_text_macro 'M', area, 40, 65
	make_text_macro 'A', area, 50, 65
	make_text_macro 'S', area, 60, 65
	make_text_macro 'E', area, 70, 65

final_draw:
	;cutia in care tinem butonul pt descoperire tile
	line_horizontal point_tile_x, point_tile_y, point_tile_size, 0
	line_horizontal point_tile_x, point_tile_y+point_tile_size/2, point_tile_size, 0
	line_vertical point_tile_x, point_tile_y, point_tile_size/2, 0
	line_vertical point_tile_x+point_tile_size, point_tile_y, point_tile_size/2, 0
	
	;cutia in care tinem butonul pt apasare flag
	line_horizontal point_flag_x, point_flag_y, point_flag_size, 0
	line_horizontal point_flag_x, point_flag_y+point_flag_size/2, point_flag_size, 0
	line_vertical point_flag_x, point_flag_y, point_flag_size/2, 0
	line_vertical point_flag_x+point_flag_size, point_flag_y, point_flag_size/2, 0
	
	;cutia in care tinem butonul pt punere tile
	line_horizontal point_block_x, point_block_y, point_block_size, 0
	line_horizontal point_block_x, point_block_y+point_block_size/2, point_block_size, 0
	line_vertical point_block_x, point_block_y, point_block_size/2, 0
	line_vertical point_block_x+point_block_size, point_block_y, point_block_size/2, 0
	
	;rombul
	lat_sus_st 550, 300, 20, 255
	lat_sus_dr 550, 300, 20, 255
	lat_jos_st 550, 260, 20, 255
	lat_jos_dr 550, 260, 20, 255
	
	make_bomb_macro area, 520, 403
	make_bomb_macro area, 595, 403

	make_point_flag_macro area, point_flag_x+15, point_flag_y+4
	make_empty_tile_macro area, point_tile_x+18, point_tile_y+5
	make_tile_macro area, point_block_x+18, point_block_y+5
	
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	bordare
	inserare_bombe
	inserare_nr_bombe
	afisare_matrice_logica
	
	bordare_stare
	bordare_lat_stare
	afisare_matrice_stare
		
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start

    
