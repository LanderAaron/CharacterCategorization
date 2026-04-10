; CSC 221 Project 01
; Description: A project that prints out the first 8 Fibonacci numbers using assembly without
; using loops and jumps while also utilizing two registers and "xchg."
; Author: Lander Aaron Villafania
; Creation Date: 27 February 2026

include irvine32.inc
.code
fibNum PROC
	mov eax, 0          ; First Fibonacci number F(0)
    mov ebx, 1          ; Second Fibonacci number F(1)

    ; 0
    call WriteDec       ; Writes first number, 0
    call Crlf           ; New line
    add  ebx, eax       ; Calculate next Fibonacci number F(0) = F(0) + F(1)
    xchg eax, ebx       ; Swap EAX and EBX to prepare for the next iteration

    ; 1
    call WriteDec       ; Writes second number, 1
    call Crlf
    add  ebx, eax       ; Calculate next Fibonacci number F(1) = F(1) + F(0)
    xchg eax, ebx

    ; 1
    call WriteDec       ; Writes third number, 1
    call Crlf
    add  ebx, eax       ; Calculate next Fibonacci number F(4) = F(2) + F(3)
    xchg eax, ebx

    ; 2
    call WriteDec       ; Writes fourth number, 2
    call Crlf
    add  ebx, eax       ; Calculate next Fibonacci number F(5) = F(3) + F(4)
    xchg eax, ebx

    ; 3
    call WriteDec       ; Writes fifth number, 3
    call Crlf
    add  ebx, eax
    xchg eax, ebx

    ; 5
    call WriteDec 	    ; Writes sixth number, 5
    call Crlf
    add  ebx, eax
    xchg eax, ebx

    ; 8
    call WriteDec       ; Writes seventh number, 8
    call Crlf
    add  ebx, eax
    xchg eax, ebx

    ; 13
    call WriteDec       ; Writes eighth number, 13
    call Crlf
    add  ebx, eax
    xchg eax, ebx

	exit	            ; Exit the program
fibNum ENDP
END fibNum