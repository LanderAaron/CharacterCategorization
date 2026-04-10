include irvine32.inc
include macros.inc

.code

bar PROC
	mwriteln <"hello from bar">
	mwriteln <"goodbye from bar">
	ret
bar ENDP

main PROC
	mwriteln <"hello from main">
	call foo
	L1:
	mwriteln <"goodbye from main">
	G1::
	exit
main ENDP

foo PROC
	mwriteln <"hello from foo">
	call bar
	mwriteln <"goodbye from foo">
	ret
foo ENDP
END main
END foo