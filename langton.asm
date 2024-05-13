%include "common"

;Langton's Ant on R216K2A and RTerm P2
;I probably messed the label names up but no matter


;This part is me figuring out the big terminal
;0001 00yy yyyx xxxx
;0001 0001 1001 0000


init:
	mov r1, 0x1190		;r1  - Position
	mov r10, 0		;r10 - Terminal port
	bump r10
	send r10, 0x200F	;Set terminal colors
	jmp left


left:
	cmp [r1+0x0100], 0x0001	;Check if current cell is on
	je .off			;If it is...
	mov [r1+0x0100], 0x0001	;If not, turn it on,
	send r10, r1		;Set cursor position,
	send r10, 0x007F	;And write on character
	jmp .end;
.off:
	mov [r1+0x0100], 0x0000	;...turn it off,
	send r10, r1		;Set cursor position,
	send r10, '.'		;And write off character
.end:

	sub r1, 1		;Then change ant position
	cmp [r1+0x0100], 0x0001	;If current cell is on, turn
	je up			;If not, turn the other way
				;And so on






down:
	cmp [r1+0x0100], 0x0001
	je .off
	mov [r1+0x0100], 0x0001
	send r10, r1
	send r10, 0x007F
	jmp .end;
.off:
	mov [r1+0x0100], 0x0000
	send r10, r1
	send r10, '.'
.end:

	add r1, 0x0020
	cmp [r1+0x0100], 0x0001
	je left





right:
	cmp [r1+0x0100], 0x0001
	je .off
	mov [r1+0x0100], 0x0001
	send r10, r1
	send r10, 0x007F
	jmp .end;
.off:
	mov [r1+0x0100], 0x0000
	send r10, r1
	send r10, '.'
.end:

	add r1, 1
	cmp [r1+0x0100], 0x0001
	je down




up:
	cmp [r1+0x0100], 0x0001
	je .off
	mov [r1+0x0100], 0x0001
	send r10, 0x007F	;No need to set cursor position here
	jmp .end;
.off:
	mov [r1+0x0100], 0x0000
	send r10, r1
	send r10, '.'
.end:

	sub r1, 0x0020
	cmp [r1+0x0100], 0x0001
	je right
	jmp left