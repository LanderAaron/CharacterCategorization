;
;

include irvine32.inc
.data
	array1 WORD 0,1,2,3,4,5,6,7,8,9
	array2 WORD 0,10,20,30,40,50,60,70,80,90

.code
main PROC
	mov ecx, LENGTHOF array1
	mov esi, OFFSET array1
	mov eax, 0
	TOP:
		add ax, [esi]
		add esi, TYPE WORD
	loop TOP
	call WriteDec
	exit
main ENDP
END main