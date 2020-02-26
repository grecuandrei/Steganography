%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax
    
    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done
    
    ;==============================TASK 1===============================
solve_task1:
    ; TODO Task1
    xor eax, eax
    mov eax, [img]
    push eax
    call bruteforce_singlebyte_xor
    add esp, 4
    
    push edx ; key
    push eax ; line
       
    xor ebx, ebx
    mov ebx, 4
    xor edx, edx
    mul dword [img_width]
    xor edx, edx
    mul ebx
    mov edx, [img]
    xor [edx+eax], ecx
    
printString: ; printarea stringului
    xor [edx+eax], ecx
    xor [edx+eax], ecx
    PRINT_CHAR [edx+eax]
    add eax, ebx
    xor [edx+eax], ecx
    cmp dword[edx+eax], 0
    jne printString
    NEWLINE
    ; printarea cheii si a liniei
    pop eax
    pop edx
    PRINT_UDEC 4, edx
    NEWLINE
    PRINT_UDEC 4, eax
    NEWLINE
    jmp done
    
bruteforce_singlebyte_xor:
    enter 0,0
    xor eax, eax
    xor ecx, ecx
    mov eax, [img_width]
    mov ecx, [img_height]
    mul ecx
    xchg ecx, eax ; dimensiunea maxima a vectorului
                  ; unde e tinuta matricea
    xor edx, edx
    xor ebx, ebx
    
search:
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4] ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x72 ; compar cu r
    jz n1 ; daca e, ma duc la urmatorul si verific
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
n1:
    inc ebx
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4] ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x65 ; compar cu e
    jz n2 ; daca e, ma duc la urmatorul si verific
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
n2:
    inc ebx
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4]  ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x76 ; compar cu v
    jz n3 ; daca e, ma duc la urmatorul si verific
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
n3:
    inc ebx
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4]  ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x69 ; compar cu i
    jz n4 ; daca e, ma duc la urmatorul si verific
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
n4:
    inc ebx
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4]  ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x65 ; compar cu e
    jz n5 ; daca e, ma duc la urmatorul si verific
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
n5:
    inc ebx
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4]  ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x6E ; compar cu n
    jz n6 ; daca e, ma duc la urmatorul si verific
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
n6:
    inc ebx
    mov eax, [ebp+8]
    mov eax, [eax+ebx*4]  ; se ia fiecare valoare
    xor eax, edx ; se aplica cheia
    cmp eax, 0x74 ; compar cu t
    jz exitloop ; daca e, ies din verificare
    inc ebx
    cmp ebx, ecx
    je redoforkey
    jmp search
    
redoforkey: ; daca nu, reincerc cu alta cheie
    xor ebx, ebx
    inc edx
    jmp search
    
exitloop:
    push edx ; key
    ; procesarea liniei
    mov ecx, edx
    xor eax, eax
    xor edx, edx
    mov eax, [img_width]
    xchg eax, ebx
    div ebx
    ; restaurarea cheii
    pop edx
    leave
    ret
    
    ;==============================TASK 2===============================
solve_task2:
    ; TODO Task2
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    xor ebx, ebx
    mov eax, [img_width]
    mov ecx, [img_height]
    mul ecx
    xchg ecx, eax ; salvarea dimensiunii matricii
    push ecx
    inc ecx
    push ecx
    
    ; preluam linia si cheia de la taskul aterior
    xor eax, eax
    mov eax, [img]
    push eax
    call bruteforce_singlebyte_xor
    add esp, 4
    
    pop ecx
    xor ebx, ebx
    push eax
    push edx
    
xormap: ; decriptam harta
    pop edx
    mov eax, [img]
    mov eax, [eax+ebx*4]
    push edx
    xor edx, eax
    
    mov eax, [img]
    mov [eax+ebx*4], edx
    inc ebx
    cmp ebx, ecx
    je down
    jmp xormap
    
down:
    pop edx ; cheia criptata de la 1
    pop eax ; linia decriptata la 1
    push edx
    inc eax
    xor edx, edx
    mul dword[img_width]
    xor ebx, ebx
    xor edx, edx
    mov ebx, 4
    mul ebx
    ; impingerea textului de criptat pe stiva
    ; pentru a-l copia mai tarziu la locul unde este necesar
    push 0
    push 46
    push 115
    push 105
    push 97
    push 99
    push 110
    push 97
    push 114
    push 102
    push 32
    push 101
    push 98
    push 114
    push 101
    push 118
    push 111
    push 114
    push 112
    push 32
    push 110
    push 117
    push 32
    push 116
    push 115
    push 101
    push 39
    push 67
    mov edx, [img]
    
copymsg: ; punem mesajul la locul lui
    pop ecx
    mov [edx+eax], ecx
    add eax, ebx
    cmp ecx, 0
    je final
    jmp copymsg
    
final: ; calculam noua cheie
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    pop eax
    mov ebx, 2
    mul ebx
    add eax, 3
    mov ebx, 5
    div ebx
    sub eax, 4
    pop ecx
    push eax
    xor ebx, ebx
xormapp: ; si o aplicam pe matrice
    mov edx, [ebp-4]
    mov eax, [img]
    mov eax, [eax+ebx*4]
    xor edx, eax
    mov eax, [img]
    mov [eax+ebx*4], edx
    inc ebx
    cmp ebx, ecx
    je exitthis
    jmp xormapp
    
exitthis: ; printam matricea si iesim din functie  
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    add esp, 12
    jmp done
    
    ;==============================TASK 3===============================
solve_task3:
    ; TODO Task3
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    mov eax, [ebp+12] ; argumentele
    mov ebx, [eax+12] ; stringul in ebx
    mov ecx, [eax+16] ; offset-ul
    ; transformam stringul in int
    push ecx
    call atoi
    add esp, 4
    mov ecx, 4
    mul ecx
    xchg ecx, eax ; in ecx e offsetul
    
    push ecx
    push ebx
    push dword[img]
    call morse_encrypt
    add esp, 12
    jmp done
    
morse_encrypt:
    enter 0,0
    xor eax, eax
    mov eax, [ebp+8]
    mov ebx, [ebp+12]
    mov ecx, [ebp+16]
    add eax, ecx ; aici e adresa de inceput pe cara trb sa o rescriem
    mov ecx, 0
    push eax
    push ebx
    xor edx, edx
    
copymorse:
    mov ebx, [ebp-8]
    mov eax, [ebp-4]
    mov ebx, [ebx+ecx]
    ; comparam fiecare caracter pentru codul morse
    push eax
    push ebx
    call morse
    add esp, 8
    inc ecx
    mov ebx, [ebp-8]
    mov ebx, [ebx+ecx]
    ; verificam daca enuntul s-a terminat
    cmp bl, 0
    je leavetask
    jmp copymorse
    
leavetask:
    pop ebx
    pop eax
    ; modificarea ultimului spatiu adaugat dupa transformarea
    ; caracterului in terminator de sir
    sub edx, 4
    mov dword[eax+edx], 0
    ; printarea matricei
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    add esp, 12
    leave
    ret

morse: ; functia ce compara fiecare caracter
    enter 0,0
    mov ebx, [ebp+8]
    mov eax, [ebp+12]
    cmp bl, 'A'
    je A
    cmp bl, 'B'
    je B
    cmp bl, 'C'
    je C
    cmp bl, 'D'
    je D
    cmp bl, 'E'
    je E
    cmp bl, 'F'
    je F
    cmp bl, 'G'
    je G
    cmp bl, 'H'
    je H
    cmp bl, 'I'
    je I
    cmp bl, 'J'
    je J
    cmp bl, 'K'
    je K
    cmp bl, 'L'
    je L
    cmp bl, 'M'
    je M
    cmp bl, 'N'
    je N
    cmp bl, 'O'
    je O
    cmp bl, 'P'
    je P
    cmp bl, 'Q'
    je Q
    cmp bl, 'R'
    je R
    cmp bl, 'S'
    je S
    cmp bl, 'T'
    je T
    cmp bl, 'U'
    je U
    cmp bl, 'V'
    je V
    cmp bl, 'W'
    je W
    cmp bl, 'X'
    je X
    cmp bl, 'Y'
    je Y
    cmp bl, 'Z'
    je Z
    cmp bl, '0'
    je zero
    cmp bl, '1'
    je one
    cmp bl, '2'
    je two
    cmp bl, '3'
    je three
    cmp bl, '4'
    je four
    cmp bl, '5'
    je five
    cmp bl, '6'
    je six
    cmp bl, '7'
    je seven
    cmp bl, '8'
    je eight
    cmp bl, '9'
    je nine
    cmp bl, ','
    je comma
; pentru fiecare litera s-a facuta schimbarea in codul ei morse
A:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
B:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
C:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
D:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
E:
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
F:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
G:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
H:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
I:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
J:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
K:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
L:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
M:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
N:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
O:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
P:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
Q:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
R:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis  
S:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis  
T:
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
U:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
V:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
W:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
X:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
Y:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
Z:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
one:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
two:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
three:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
four:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
five:
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
six:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
seven:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
eight:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
nine:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    jmp leavethis
zero:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
comma:
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 46
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    mov dword[eax+edx], 45
    add edx, 4
    jmp leavethis
leavethis:
    ; adaugarea unui spatiu dupa fiecare litera
    mov dword[eax+edx], 32
    add edx, 4
    leave
    ret

    ;==============================TASK 4===============================
solve_task4:
    ; TODO Task4
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    mov eax, [ebp+12] ; argumentele
    mov ebx, [eax+12] ; stringul in ebx
    ;PRINT_STRING [ebx]
    mov ecx, [eax+16] ; offset-ul
    push ecx
    call atoi
    add esp, 4
    
    mov ecx, 4
    mul ecx
    xchg ecx, eax ; in ecx e offsetul
    
    push ecx
    push ebx
    push dword[img]
    call lsb_encode
    add esp, 12
    
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    add esp, 12
    
    jmp done
    
lsb_encode:
    enter 0,0
    xor eax, eax
    mov eax, [ebp+8]
    mov ebx, [ebp+12] ; stringul
    mov ecx, [ebp+16] ; offset
    add eax, ecx ; aici e adresa de inceput pe care trb sa o rescriem
    sub eax, 4
    push ebx
    push eax
    xor edi, edi
    xor edx, edx
    
transf:
    xor esi, esi
    mov ebx, [ebp-4] ;string
    mov eax, [ebp-8] ;de aici incep sa scriu in matrice
    mov bl, byte[ebx+edi]
    
byte_rot:
    rol bl, 1 ; rotire la stanga pentru a verifica bitul
    xor ecx, ecx
    mov cl, bl
    and cl, 1
    cmp cl, 0
    je unsigned
    cmp cl, 1
    je signed

unsigned:
    and byte[eax+edx], 254 ; setez ultimul bit 0
    jmp check_rot
    
signed:
    or byte[eax+edx], 1 ; setez ultimul bit 1
    
check_rot:
    inc esi ;nr rotiri
    add edx, 4 ; trec la urmatorul int din matrice
    cmp esi, 8 ; daca s-au facut 8 rotiri trec la urmatorul caracter
               ; daca nu, continui sirul rotirilor
    je check_if_end
    jmp byte_rot
    
check_if_end:
    cmp dword[ebx+edi], 0 ; daca caracterul e null ies din functie
    je exittt
    inc edi ; trec la urmatorul caracter
    jmp transf

exittt: 
    pop ebx
    pop eax
    leave
    ret
    
    ;==============================TASK 5===============================
solve_task5:
    ; TODO Task5
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    mov eax, [ebp+12] ; argumentele
    mov ecx, [eax+12] ; byte_id
    ; il transformam in int
    push ecx
    call atoi
    add esp, 4
    dec eax
    mov ecx, 4
    mul ecx
    xchg ecx, eax ; in ecx e offsetul de unde trebuie sa adugam mesajul
    ; decodam enuntul
    push ecx
    push dword[img]
    call lsb_decode
    add esp, 12
    jmp done
       
lsb_decode:
    enter 0,0
    mov eax, [ebp+8]
    mov ecx, [ebp+12]
    add eax, ecx
    push eax
    xor ebx, ebx
    xor ecx, ecx
    xor edi, edi
    xor esi, esi
    mov edi, 8
    jmp print_msg
    
clear_char: ; daca caracterul nu e terminator de sir
            ; se reseteaza registrul
    xor ecx, ecx
    
print_msg:
    mov eax, [ebp-4] ; adresa imaginii
    mov esi, 1
    
    and esi, [eax+ebx*4] ; facem & pe valoarea din matrice cu 1
                         ; pentru a avea ultimul bit din numar
    add ecx, esi ; il adunam la valoarea caracterului final
    shl ecx, 1 ; si shiftam la stanga pentru a face loc unui alt bit 
    
    inc ebx
    xor edx, edx
    mov eax, ebx
    div edi
    ; daca nu s-a terminat de decodat caracterul
    cmp edx, 0
    jne print_msg
    
    shr ecx, 1 ; daca caracterul a fost decodat
               ; shiftam la dreapta pentru a sterge shiftarea data
               ; in avans la pasul anterior
    cmp ecx, 0
    jne print ; daca s-a terminat de creat caracterul se trece la afisarea lui
              ; altfel, daca e terminator de sir, se termina
    
go_back:
    ; daca caracterul e terminator de sir se iese din functie
    ; altfel se reseteaza ecx si se construieste alt caracter
    cmp ecx, 0
    jne clear_char
    leave
    ret
    
print: ; afisam caracter cu caracter din mesajul decodat
    PRINT_CHAR ecx 
    jmp go_back   
    
    ;==============================TASK 6===============================
solve_task6:
    ; TODO Task6
    push dword[img]
    call blur
    add esp, 4
    
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image   
     
    jmp done
    
blur:
    enter 0,0
    xor eax, eax
    xor ecx, ecx
    mov eax, [img_width]
    mov ecx, [img_height]
    mul ecx
    xchg ecx, eax ; in ecx e marimea matricii
    xor edx, edx
    xor ebx, ebx
    mov ebx, [img_width] ; incepem de la a 2-a linie
    sub ecx, [img_width] ; si neglijam ultima linie
    
cycle:
    push esi ; salvam pe stiva rezultatul mediei pentru a o folosi mai tariu
             ; cum mediile se calculeaza cu valorile din matricea originala

    xor edx, edx
    xor edi, edi
    mov edi, [img_width]
    mov eax, [ebp+8]
    xor esi, esi
    mov esi, [eax+ebx*4]
    
    mov eax, ebx ; impartim indicele valorii cu latimea matricii
    div edi
    
    cmp edx, 0 ; comparam ca restul sa nu fie 0
               ; adica sa nu fie pe prima coloana
    je redo
    
    ; comparam ca restul sa nu fie latimea - 1
    ; adica sa nu fie pe ultima coloana
    inc edx
    cmp edx, dword[img_width]
    je redo
    dec edx
    
    push ecx
    push ebx
    
    ; adunarea la valoarea din matrice (esi)
    ; valoarea de deasupra ei
    mov eax, [ebp+8]
    sub ebx, [img_width]
    add esi, [eax+ebx*4]
    
    ; adunarea la valoarea din matrice (esi)
    ; valoarea din urma ei
    mov eax, [ebp+8]
    pop ebx
    push ebx
    dec ebx
    add esi, [eax+ebx*4]
    
    ; adunarea la valoarea din matrice (esi)
    ; valoarea de dupa ea
    mov eax, [ebp+8]
    pop ebx
    push ebx
    inc ebx
    add esi, [eax+ebx*4]
    
    ; adunarea la valoarea din matrice (esi)
    ; valoarea de sub ea
    mov eax, [ebp+8]
    pop ebx
    push ebx
    add ebx, [img_width]
    add esi, [eax+ebx*4]
    
    ; si suma o impartim la 5
    xor edx, edx
    xchg eax, esi
    mov ecx, 5
    div ecx ; in eax se afla rezulatul
    xchg esi, eax ; in esi e finalul
    
    pop ebx
    pop ecx
    
redo: ; acum doar modificam matricea originala cu valorile de pe stiva
      ; deoarece mediile au fost calculate cu valorile
      ; din matricea initiala
    inc ebx
    cmp ebx, ecx
    jne cycle
    
    xor eax, eax
    xor ecx, ecx
    mov eax, [img_width]
    mov ecx, [img_height]
    mul ecx
    xchg ecx, eax ; in ecx e marimea matricii
    sub ecx, [img_width]
    dec ecx
    dec ecx
modify: ; doar copiem in matrice
        ; rezultatele
    mov eax, [ebp+8]
    pop edx
    mov [eax+ecx*4], edx
    dec ecx
    cmp ecx, [img_width]
    jne modify
    
    leave
    ret
    
    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    
