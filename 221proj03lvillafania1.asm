; CSC 221 Project 03 RevStr
; Description: Reverse a user-given string using the runtime stack and a procedure.
; Author: Lander Aaron Villafania
; Revisions: 0.01
; Creation Date: 23 March 2026

include irvine32.inc

.data
	MAX_SIZE = 255
	theKey BYTE 0DEh
	s BYTE MAX_SIZE DUP(?), 0
	d BYTE MAX_SIZE DUP(0), 0
	prompt BYTE "Enter a short string: ", 0
	len DWORD ?

.code
	main PROC

	; Prompts the user for string
	mov edx, OFFSET prompt
	call WriteString

	; Read in the string
	mov edx, OFFSET s

	; Leave space for null terminator/Read in string
	mov ecx, MAX_SIZE - 1	
	call ReadString

	; Copy the length of the string into EAX and then into len
	mov len, eax

	; Setup registers for RevStr call
	mov esi, OFFSET s
	mov edi, OFFSET d
	mov ecx, len

	call RevStr

	; Prints out the reversed string
	mov edx, OFFSET d
	call WriteString
	call Crlf

	exit
main ENDP

; Description: Reverse a string using the system stack.
; Receives: ESI = Address of source
;			EDI = Address of destination
;			ECX = Length (bytes to reverse, not buffer size)
; Returns: Destination contains the reversed bytes followed by a null
; Requires: The caller must set up ESI, EDI, and ECX before calling this procedure.

	RevStr PROC USES eax ecx esi edi

	; Check if the source pointer is null without using cmp



	PushLoop:
		mov al, [esi]	; Load the byte at ESI into AL
		push eax		; Push the value of EAX onto the stack to save it
		inc esi			; Move to the next byte in the source string
		loop PushLoop	; Loop until ECX is zero

	mov ecx, len		; Restore the original length of the string into ECX

	PopLoop:
		pop eax			; Pop the top value from the stack into EAX
		mov [edi], al	; Store the byte in AL into the destination string at EDI
		inc edi			; Move to the next byte in the destination string
		loop PopLoop	; Loop until ECX is zero

	; Null-terminate the destination string
		mov BYTE PTR [edi], 0
		ret
	
	RevStr ENDP
END main