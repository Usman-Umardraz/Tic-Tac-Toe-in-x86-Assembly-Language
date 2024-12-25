.MODEL SMALL
.STACK 100H
.DATA

grid db 31h,32h,33h,34h,35h,36h,37h,38h,39h
player db 0
win db 0
welcome db " Welcome to `Tic-Tac-Toe' Game !!$"
separator db " |-----------------+-----------------+-----------------|$"

tieMessage db "The Game Tied Between The Two Players!$"
winMessage db "Congratulations!! The Winner is player $"
inDigitError db " ERROR!, this place is taken$"
inputError db " ERROR!, input is not a valid digit for the game$" 
line db "  -----------------------------------------------------$"      
space db " $"
ExitMSG    db "Press any key to Exit....$"
FError db " ERROR!, input is not a valid digit for the game$"

 
     
GameName  db "                     ****   Tic-Tac-Toe   ****$",0
devName db "     Developed by  ------------->   Usman & Junaid Zaffar$",0
coursTitle db "     Course       -------------->   Computer Organization & Assembly Language$",0
department db "     Department   -------------->   Computer Science$",0
semester db "     Semester     -------------->   4th$",0
uniName db "     GCUF ( Chiniot Campus)$",0
pressKeyMsg db "     Press any key to continue....$",0
Formate   db  " ===========================================================$",0                                                                            
goodbyeMsg  db "   BYE BYE (*!*)$",0


              ; --------------------- CODE Segment START-------------------------
			  
.CODE 

printString proc 

	MOV ah, 09 
	int 21h
	RET 
 endp
 
 
    ;COLORLASTDIGIT
 
 
 printCharCOLOR PROC 
 	
	MOV BP, BX
 	mov di, cx 
 	MOV AL,DL
	CMP AL,'X'
	JE L1 
	CMP AL,'O'
	JE L2     
	jmp L3
	
	
L1:
	
    MOV AH, 9  	
	MOV BL, 10       ; For green colour
	MOV CX,1
	INT 10H  
	mov dl,al   
	mov ah,2   
	int 21h
	JMP EXIT2
	
L2:
	
	MOV AH, 9 
	MOV BL, 12      ; For red colour
	MOV CX,1
	INT 10H  
	mov dl,al   
	mov ah,2   
	int 21h
	JMP EXIT2
	
L3:
	
	MOV AH, 9 
	MOV BL, 14    ; For yellow colour
	MOV CX,1
	INT 10H 
	mov dl,al   
	mov ah,2   
	int 21h
	JMP EXIT2

EXIT2:
 	MOV BX, BP
 	mov cx, di
 	RET
	endp
	
printStringP proc

    MOV BP,BX 
    mov di, cx
    MOV BL,0Ch        ; Set BL to 0Ch for purple color

    MOV ah, 09h       ; Function 09h - Display string
    MOV AL, 0         ; Display string from DS:DX
    MOV CX, 90h       ; Length of the string
    INT 10H           ; Video BIOS - Display string

    int 21h           
   
    MOV CX, di        ; Restore CX with its original value
    MOV BX,BP         ; Restore BX with its original value
    RET           
endp

	
printString1 proc

	MOV BP,BX 
	MOV DI, cx
	MOV BL,14

	MOV ah, 09 
	MOV AL,0
	MOV CX,90h
	INT 10H

	 
	int 21h
	MOV CX, di 
	MOV BX,BP 
	ret
endp
   
printStringB proc

    MOV BP,BX 
    MOV DI, CX
    MOV BL,09h           ; Set BL to 09h for blue color
    MOV ah, 09h       
    MOV AL, 0            ; Display string from DS:DX
    MOV CX, 90h         
    INT 10H           

    int 21h     

    MOV CX, DI           ; Restore CX with its original value
    MOV BX,BP            ; Restore BX with its original value
    RET                  ; Return from procedure       
endp

printStringR proc

    MOV BP,BX 
    MOV DI, cx
    MOV BL,04h          ; Set BL to 04h for red color

    MOV ah, 09h 
    MOV AL, 0         
    MOV CX, 90h 
    INT 10H     

    int 21h     
    MOV CX, DI       
    MOV BX,BP   
    RET         
endp

printStringG proc

    MOV BP,BX 
    MOV DI, CX
    MOV BL,02h         ; Set BL to 04h for Green color

    MOV ah, 09h 
    MOV AL, 0   
    MOV CX, 90h 
    INT 10H     

    int 21h          

    MOV CX, DI  
    MOV BX,BP   
    RET        
endp

newLine proc

	MOV DL,0DH        
	MOV AH,2
	INT 21H
	MOV DL,0AH         
	MOV AH,2
	INT 21H
	ret
endp

waitForKeypress proc

    MOV AH,00h
	int 16h
	RET
 endp
 
 clearScreen proc
 
    MOV AH, 06h                  ; Set function to scroll up
    MOV AL, 0                    ; Clear entire screen
    MOV BH, 07h                  ; Set attribute for blank lines
    MOV CX, 0                    ; Set upper-left corner
    mov DX, 184Fh                ; Set lower-right corner
    int 10h
    RET 
  endp

printChar proc
	
	MOV ah, 02
	int 21h
	RET
endp

print12 proc

    MOV DI, CX
	MOV CX,8
lp1:
	call printChar
	Loop lp1
	MOV CX,DI
	RET
endp
print4 proc

    MOV DI, CX
	MOV CX,4
lp2:
	call printChar
	Loop lp2
	MOV CX,DI
	RET
endp

print17 proc

    MOV DI, CX
	MOV CX,17
lp3:
	call printChar
	Loop lp3
	MOV CX,DI
	RET
endp

print_pool proc

     MOV DL, ' '
	call print17
	MOV DL, '|'
	call printChar

RET
endp



;////////////////////////////////////////////////////////////////////
printGrid proc
   
	LEA DX, line
	call printString
	

	LEA BX, grid
	MOV DX,[bx]
	call printRow

	LEA DX, separator
	call printString
	

	call printRow
	LEA DX, separator
	call printString
	

	call printRow
	LEA DX, line
	call printString

	RET
endp


printRow proc

	
	call newLine
	MOV DL, ' '
	call printChar
	MOV DL, '|'
	call printChar
	call print_pool
	call print_pool
	call print_pool
	
	call newLine
	MOV DL, ' '
	call printChar
	MOV DL, '|'
	call printChar
	
	
	MOV DL, ' '
	call print12
	MOV DL, [BX]
	call printCharCOLOR

	
	MOV DL, ' '
	call print12
	
	MOV DL, '|'
	call printChar
	inc BX

	
	MOV DL, ' '
    call print12
	MOV DL, [BX]
	call printCharCOLOR
	MOV DL, ' '
	call print12
	
	MOV DL, '|'
	call printChar
	inc BX

	
	MOV DL, ' '
	call print12
	MOV DL, [bx]
	call printCharCOLOR
	MOV DL, ' '
	call print12
	MOV DL, '|'
	call printChar
	inc BX
	CALL newLine
	RET
endp

;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

getMOVe proc

	MOV AH, 01
	int 21h
	call checkValidDigit
	cmp AH, 1
	je contCheckTaken
	MOV DL, 0dh
	call printChar
	LEA DX, inputError
	call printString
	RET
	
endp

contCheckTaken proc 
	
	LEA BX, grid
	sub AL, 31h
	MOV AH, 0
	add BX, AX
	MOV AL, [BX]
	cmp AL, 39h
	jng finishGetMOVe
	MOV DL, 0dh
	call printChar
	LEA dx, inDigitError
	call printString
	CALL newLine

	jmp getMOVe
finishGetMOVe:

	CALL newLine
	CALL newLine
	RET
endp

checkValidDigit proc
	MOV ah, 0
	cmp al, '1'
	jl NvalidDigit
	cmp al, '9'
	jg NvalidDigit
	MOV ah, 1
NvalidDigit:
	RET
endp

;////////////////////////////////// Winning Check /////////////////////

checkWin proc

	LEA si, grid
	call checkDiagonal
	cmp win, 1
	je endCheckWin
	call checkRows
	cmp win, 1
	je endCheckWin
	call CheckColumns
endCheckWin:
	RET
endp
;-------------------------------------------;

checkDiagonal proc
    ;DiagonalLtR
	MOV bx, si
	MOV al, [bx]
	add bx, 4             ;grid[0] ---> grid[4]
	cmp al, [bx]
	jne diagonalRtL
	add bx, 4            ;grid[4] ---> grid[8]
	cmp al, [bx]
	jne diagonalRtL
	MOV win, 1
	RET
endp

diagonalRtL proc
	MOV bx, si
	add bx, 2          ;grid[0] ---> grid[2]
	MOV al, [bx]
	add bx, 2          ;grid[2] ---> grid[4]
	cmp al, [bx]
	jne endCheckDiagonal
	add bx, 2          ;grid[4] ---> grid[6]
	cmp al, [bx]
	jne endCheckDiagonal
	MOV win, 1
endCheckDiagonal:
	RET
endp

;-------------------------------------------;
checkRows proc
   ;firstRow
	MOV bx, si                ; --->grid[0]
	MOV al, [bx]
	inc bx                   ;grid[0] ---> grid[1]
	cmp al, [bx]
	jne secondRow
	inc bx                  ;grid[1] ---> grid[2]
	cmp al, [bx]
	jne secondRow
	MOV win, 1
	RET
endp

secondRow proc

	MOV bx, si            ; --->grid[0]
	add bx, 3             ;grid[0] ---> grid[3]
	MOV al, [bx]
	inc bx                ;grid[3] ---> grid[4]
	cmp al, [bx]
	jne thirdRow
	inc bx                ;grid[4] ---> grid[5]
	cmp al, [bx]
	jne thirdRow
	MOV win, 1
    RET
endp

thirdRow proc
	MOV bx, si                  ; --->grid[0]
	add bx, 6                   ;grid[0] ---> grid[6]
	MOV al, [bx ]
	inc bx                      ;grid[6] ---> grid[7]
	cmp al, [bx]
	jne endCheckRows
	inc bx                      ;grid[7] ---> grid[8]
	cmp al, [bx]
	jne endCheckRows
	MOV win, 1
	endCheckRows:
	RET
ENDP

;-------------------------------------------;
 ;firstColumn
CheckColumns proc
                              
	MOV bx, si                 ; --->grid[0]
	MOV al, [bx]
	add bx, 3                  ;grid[0] ---> grid[3]
	cmp al, [bx]
	jne secondColumn
	add bx, 3                 ;grid[3] ---> grid[6]
	cmp al, [bx]
	jne secondColumn
	MOV win, 1
	RET
endp

secondColumn proc

	MOV bx, si      ; --->grid[0]
	inc bx          ;grid[0] ---> grid[1]
	MOV al, [bx]
	add bx, 3       ;grid[1] ---> grid[4]
	cmp al, [bx]
	jne thirdColumn
	add bx, 3       ;grid[4] ---> grid[7]
	cmp al, [bx]
	jne thirdColumn
	MOV win, 1
ret
endp

thirdColumn proc

	MOV bx, si    
	add bx, 2     
	MOV al, [bx]
	add bx, 3     
	cmp al, [bx]
	jne endCheckColumns
	add bx, 3    
	cmp al, [bx]
	jne endCheckColumns
	MOV win, 1
	
endCheckColumns:
ret    
endp        


printRow1 proc

	;First Cell
	MOV dl, ' '
	call printChar
	MOV dl, '|'
	call printChar
	MOV dl, ' '
	call printChar
	MOV dl, [bx]
	call printCharCOLOR
	MOV dl, ' '
	call printChar

	MOV dl, '|'
	call printChar
	inc bx

	;Second Cell
	MOV dl, ' '
	call printChar
	MOV dl, [bx]
	call printCharCOLOR
	MOV dl, ' '
	call printChar
	MOV dl, '|'
	call printChar
	inc bx

	;Third Cell
	MOV DL, ' '
	call printChar
	MOV DL, [BX]
	call printCharCOLOR
	MOV DL, ' '
	call printChar
	MOV DL, '|'
	call printChar
	inc BX

	CALL newLine
RET
endp

EGame proc
    LEA dx, ExitMSG
    call printString
    CALL waitForKeypress
	CALL clearScreen
    LEA dx, goodbyeMsg
    call printString
	JMP EXIT
endp







;//////////////////////////////////////////////////////////////////
MAIN PROC

	call clearScreen
	MOV ax, @data
	MOV ds, ax
	MOV es, ax
	LEA dx, GameName
	call printString 
	CALL newLine
	CALL newLine

	LEA dx, devName
	call printString 
	CALL newLine

	LEA dx,coursTitle
	call printString
	CALL newLine

	LEA dx,department
	call printString
	CALL newLine

	LEA dx,semester
	call printString
	CALL newLine

	LEA dx,uniName
	call printString
	CALL newLine
	LEA dx,[Formate]
	call printString
	call newLine
	call newLine
	call newLine
	call newLine
	call newLine
	call newLine

	LEA dx, pressKeyMsg
	call printString

	CALL waitForKeypress


	call clearScreen
	 JMP startGame

		
startGame:
	MOV CX,9
	LEA dx, welcome
	call printString 
	CALL newLine
	call newLine

gameLoop:

	call printGrid
	MOV al, player
	cmp al, 1
	CALL newLine
	je p2turn
	
	MOV player, 1
   jmp endPlayerSwitch
   
p2turn:
	MOV player, 2; 
	


endPlayerSwitch:

	call getMOVe              
	MOV dl, player
	cmp dl, 1
	jne p2MOVe
	MOV dl, 'X'
	jmp contMOVes
	p2MOVe:
	MOV dl, 'O'
	
contMOVes:
	MOV [bx], dl
	cmp cx, 5 
	jg noWinCheck
	call checkWin
	cmp win, 1
	je won
	
noWinCheck:
	loop gameLoop

	

	CALL newLine
	call printGrid
	CALL newLine

	LEA dx, tieMessage
	call printStringR
	CALL newLine
	call EGame


won:
	CALL newLine
	call printGrid
	CALL newLine
	LEA dx, winMessage
	call printStringG
	MOV dl, player
	add dl, 30H
	call printChar
	CALL newLine
	CALL newLine

	call EGame

EXIT:

MOV AH,4ch
INT 21h

MAIN ENDP
END MAIN