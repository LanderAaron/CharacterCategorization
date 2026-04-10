; CSC 221 Project 04
; Description: A project that reads a string from the user one character at a time,
; classifies each character based on its ASCII value, and displays info about the
; character while maintaining and displaying totals for each category
; Author: 
; Creation Date: 8 April 2026

include irvine32.inc
;----------------------------------------------------------------------------------------------------------------- Declarations
.data
	; General data declarations
	MAX = 128
	prompt BYTE "Enter a string of characters: ", 0
	buffer BYTE MAX DUP (0), 0
	separator BYTE " : ", 0
	separator2 BYTE "   ::= ", 0
	spaceCat BYTE "(Space)", 0
	tabCat BYTE "(Tab)", 0
	delCat BYTE "(Del)", 0

	; Category variables for display
	totalsTitle BYTE "Character Classification Totals: ", 0
	controlChar BYTE " Control", 0
	digChar BYTE " Digit", 0
	delChar BYTE " DEL", 0
	lowChar	BYTE " Lowercase", 0
	puncChar BYTE " Punctuation", 0
	upChar	BYTE " Uppercase", 0

	; Counters for each category
	ctrlCount DWORD 0
	digCount DWORD 0
	delCount DWORD 0
	lowCount DWORD 0
	puncCount DWORD 0
	upCount DWORD 0

	; Total Messages for each category
	msgControl BYTE "Control: ", 0
	msgDigit BYTE "Digits: ", 0
	msgDel BYTE "DEL: ", 0
	msgLower BYTE "Lowercase: ", 0
	msgPunc BYTE "Punctuation: ", 0
	msgUpper BYTE "Uppercase: ", 0

	; Special Character Labels
	spaceLabel BYTE "(Space)", 0
	tabLabel BYTE "(Tab)", 0
	delLabel BYTE "(Del)", 0

.code
;----------------------------------------------------------------------------------------------------------------- Main Procedure
; Main = control program flow

main PROC
	call GetInput

	; Move the length of the string into ECX for iteration
	mov ecx, eax				
	call LoopThrough

	; Display totals for each category
	call Crlf
	mov edx, OFFSET totalsTitle
	call WriteString
	call Crlf

	mov edx, OFFSET msgControl	
	call WriteString
	mov eax, ctrlCount
	call WriteDec
	call Crlf

	mov edx, OFFSET msgDigit
	call WriteString
	mov eax, digCount
	call WriteDec
	call Crlf

	mov edx, OFFSET msgDel
	call WriteString
	mov eax, delCount
	call WriteDec
	call Crlf

	mov edx, OFFSET msgLower
	call WriteString
	mov eax, lowCount
	call WriteDec
	call Crlf

	mov edx, OFFSET msgPunc
	call WriteString
	mov eax, puncCount
	call WriteDec
	call Crlf

	mov edx, OFFSET msgUpper
	call WriteString
	mov eax, upCount
	call WriteDec
	call Crlf
exit

main ENDP
;----------------------------------------------------------------------------------------------------------------- GetInput Procedure
; Description: The GetInput procedure prompts the user for input and reads a string into the buffer. It also 
; returns the length of the string in EAX for later use in iteration.
; Received: None
; Returns: EAX = length of the input string
; Requires: None

GetInput PROC
	mov edx, OFFSET prompt
	call WriteString
	mov edx, OFFSET buffer
	mov ecx, MAX - 1
	call ReadString

	; Testing Del key because ReadString does not capture it
	; mov BYTE PTR [buffer], 127

	ret
GetInput ENDP
;----------------------------------------------------------------------------------------------------------------- LoopThrough Procedure
; Description: LoopThrough procedure takes the length of the string in ECX and iterates through each character in 
; the buffer. It classifies each character, displays its ASCII value, and updates category totals.
; Received: ECX = length of the input string
; Returns: None
; Requires: EAX = current character, ESI = pointer to current character in buffer

LoopThrough PROC USES eax ecx edx esi
	cmp ecx, 0					; If the length of the string is zero, skip the loop
	je EndLoop
	mov esi, OFFSET buffer		; Load the address of the buffer into ESI for iteration

NextChar:
	mov eax, 0					; Clear EAX to use for character classification
	mov al, BYTE PTR [esi]		; Load the current character into AL

	; Handle special characters (space, tab, DEL) with specific labels
	cmp al, 32					; Check if the character is a space (ASCII 32)
	je PrintSpaceLabel

	cmp al, 9					; Check if the character is a tab (ASCII 9)
	je PrintTabLabel

	cmp al, 127					; Check if the character is a DEL (ASCII 127)
	je PrintDelLabel

	; For all other characters, proceed with normal classification and display
	call WriteChar
	jmp ContinueLoop

; Print labels for special characters
PrintSpaceLabel:
	mov edx, OFFSET spaceLabel
	call WriteString
	jmp ContinueLoop

PrintTabLabel:
	mov edx, OFFSET tabLabel
	call WriteString
	jmp ContinueLoop

PrintDelLabel:
	mov edx, OFFSET delLabel
	call WriteString

; Continues loop for normal characters
ContinueLoop:
	mov edx, OFFSET separator	; Display the separator
	call WriteString
	call WriteDec				; Display the ASCII value of the character
	mov edx, OFFSET separator2	; Display the second separator
	call WriteString
	call Categorize				; Call the Categorize procedure to classify the character and update totals
	call Crlf					
	inc esi						; Move to the next character
	loop NextChar				; Loop until ECX is zero
EndLoop:
	ret
LoopThrough ENDP
;----------------------------------------------------------------------------------------------------------------- Categorize Procedure
; Description: The Categorize procedure takes the current character in AL, classifies it based on its ASCII value, 
; updates the appropriate category total, and displays the category name.
; Received: AL = current character
; Returns: None
; Requires: EDX = pointer to category string for display

Categorize PROC USES edx
	cmp al, 31				; Check if the character is a control character (ASCII 0-31)
	jbe isControlChar

	cmp al, 47				; Check if the character is a punctuation (ASCII 32-47)
	jbe isPuncChar

	cmp al, 57				; Check if the character is a digit (ASCII 48-57)
	jbe isDigChar

	cmp al, 64				; Check if the character is a punctuation (ASCII 58-64)
	jbe isPuncChar

	cmp al, 90				; Check if the character is an uppercase letter (ASCII 65-90)
	jbe isUpChar

	cmp al, 96				; Check if the character is a punctuation (ASCII 91-96)
	jbe isPuncChar

	cmp al, 122				; Check if the character is a lowercase letter (ASCII 97-122)
	jbe isLowChar

	cmp al, 126				; Check if the character is a punctuation (ASCII 123-126)
	jbe isPuncChar

	cmp al, 127				; Check if the character is a DEL character (ASCII 127)
	je isDelChar

	jmp EndCategorize		; If the character does not fit any category, skip to the end

; Category Labels
; Each label moves the appropriate category string into EDX and jumps to PrintCategory to display it

isControlChar:
	inc ctrlCount						; Increment control character count
	mov edx, OFFSET controlChar			; Move the control character category string into EDX for display
	jmp PrintCategory					; Jump to PrintCategory to display the category name

isDigChar:								
	inc digCount						
	mov edx, OFFSET digChar
	jmp PrintCategory

isDelChar:
	inc delCount
	mov edx, OFFSET delChar
	jmp PrintCategory

isLowChar:
	inc lowCount
	mov edx, OFFSET lowChar
	jmp PrintCategory

isPuncChar:
	inc puncCount
	mov edx, OFFSET puncChar
	jmp PrintCategory

isUpChar:
	inc upCount
	mov edx, OFFSET upChar
	jmp PrintCategory

PrintCategory:
	call WriteString			

EndCategorize:
	ret
Categorize ENDP
;-----------------------------------------------------------------------------------------------------------------
END main

; AI Critique Review:
;  