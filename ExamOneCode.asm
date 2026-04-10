;
;

include irvine32.inc
include macros.inc
.data
	bar BYTE 0,1,2,3,4,5

.code
main PROC
	mov esi, OFFSET bar
	mshow esi, hn
	mov eax, 0
	add al, [esi]
	add esi, TYPE bar
	mshow al, dn
	mshow esi, hn

	exit
main ENDP
END main
