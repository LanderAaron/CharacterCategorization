include irvine32.inc
.code
	main PROC
	mov eax, 0
	mov ebx, 1
	
	call WriteDec
	call Crlf
	add ebx, eax
	xchg eax, ebx

	call WriteDec
	call Crlf
	add ebx, eax
	xchg eax, ebx

	call WriteDec
	call Crlf
	add ebx, eax
	xchg eax, ebx

	call WriteDec
	call Crlf
	add ebx, eax
	xchg eax, ebx

	call WriteDec
	call Crlf
	add ebx, eax
	xchg eax, ebx

	call WriteDec
	call Crlf
	add ebx, eax
	xchg eax, ebx

	exit
main ENDP
END main