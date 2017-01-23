.ORIG x3000
  	LEA R0, GREET
  	PUTS
  	GREET .STRINGZ "Hello! Welcome to the conversion program!"
  	LD R0 Newline
  	OUT

START
  	AND R1 R1 #0 		; clear R1
  	AND R5 R5 #0		; clear R5
  	LEA R0 HELLO
  	PUTS
  	LD R0 Newline
  	OUT

INPUT
  	AND R4 R4 #0		; clear R4
  	AND R0 R0 #0		; clear R0
  	AND R3 R3 #0		; clear R3
  	GETC			; store input to R0
  	LD R1, X		; press x to quit 
  	ADD R1 R1 R0
  	BRz EXIT
  	LD R1, NEGATIVE_SIGN	; load -45 into R1
  	ADD R1 R1 R0		; R1+R0 = R1
  	BRz NEG			; jump to Negative if 0
  	AND R1 R1 #0		; clear R1
  	ADD R1 R0 #-10		; if user presses 'enter', finish input
  	BRz DONE_1		; if 0 go to Done1
  	OUT			; display value 
  	AND R2 R2 #0		; clear R2
  	ADD R2 R2 R0		; R2 + R0 = R2
  	LEA R3 ENTER 		; load first address
  	ADD R3 R3 R5		; displace address on R5
  	ADD R4 R4 R2		; R4 +R2 = R4
  	STR R4 R3 #0		; store R4 to address
  	ADD R5, R5, #1
  	BR INPUT		; loop again, store value in memory location

NEG
 	OUT			; display '-'
 	AND R1 R1 #0		; clear R1
 	ADD R1 R1 #1		; flag R1 with '1'
 	LEA R2 NEGATIVE		; load first address of NEGATIVE to R2
 	STR R1 R2 #0		; store value of R1 to address
	BR INPUT		; jump to input for the next input

DONE_1
  	LD R0, Newline        	; 'enter' = new line
  	OUT
  	LEA R0 THANKS		; Thanks string
  	PUTS
  	LD R0 Newline
  	OUT

COUNTER
  	AND R1 R1 #0		; clear R1
  	LEA R3 ENTER		; load first address into R3
  	ADD R3 R3 R4		; R3 + R4 = R3
  	LDR R0 R3 #0		; load given address to R0
  	ADD R4 R4 #1		; add one to R4
  	AND R2 R2 #0		; clear R2

  	ADD R2 R5 #-5		
  	BRz MULTIPLIER10000
  	ADD R2 R5 #-4
 	BRz MULTIPLIER1000
  	ADD R2 R5 #-3
  	BRz MULTIPLIER100
  	ADD R2 R5 #-2
  	BRz MULTIPLIER10
  	ADD R2 R5 #-1
  	BRz MULTIPLIER1

  	AND R2 R2 #0		; clear R2

MULTIPLIER10000
  	ADD R6 R6 #1
  	NOT R3 R0		; make and move R3 into negative
  	LD R1, CONVERT		; load 48 into R1 - conversion from ASCII to decimal      
  	ADD R3 R3 #1          	; add 1 to R3
  	ADD R3 R3 R1		; convert to decimal!
	BRz SKIP1
  	LD R1, MULTI_10000
  	ADD R2 R2 R1         	; multiplication of 10000's
  	ADD R3 R3 R6          	; if negative, keep looping, else stop
	BRn MULTIPLIER10000

SKIP1
  	LEA R3 ASCII
  	STR R2 R3 #0		; store R3 value to R2
  	ADD R1 R4 #-5
  	AND R6 R6 #0		; clear R6
  	ADD R5 R5 #-1
  	BRp COUNTER
  	BR DONE

MULTIPLIER1000
  	ADD R6 R6 #1
  	NOT R3 R0		; make and move R3 into negative
  	LD R1, CONVERT		; load 48 into R1 - conversion from ASCII to decimal   
  	ADD R3 R3 #1          
  	ADD R3 R3 R1		; convert to decimal!
	BRz SKIP2
  	LD R1, MULTI_1000
  	ADD R2 R2 R1         	; multiplication of 1000's
  	ADD R3 R3 R6          	; if negative, keep looping, else stop
	BRn MULTIPLIER1000

SKIP2
  	LEA R3 ASCII
  	ADD R3 R3 #1
  	STR R2 R3 #0		; store R3 value to R2
  	ADD R1 R4 #-5
  	AND R6 R6 #0		; clear R6
  	ADD R5 R5 #-1
  	BRp COUNTER
  	BR DONE

MULTIPLIER100
  	ADD R6 R6 #1
  	NOT R3 R0		; make and move R3 into negative
  	LD R1, CONVERT		; load 48 into R1 - conversion from ASCII to decimal     
  	ADD R3 R3 #1          
  	ADD R3 R3 R1		; convert to decimal!
	BRz SKIP3
  	LD R1, MULTI_100
  	ADD R2 R2 R1         	; multiplication of 100's
  	ADD R3 R3 R6          	; if negative, keep looping, else stop
	BRn MULTIPLIER100

SKIP3
  	LEA R3 ASCII
  	ADD R3 R3 #2
  	STR R2 R3 #0		; store R3 value to R2
  	ADD R1 R4 #-5	
  	AND R6 R6 #0		; clear R6
  	ADD R5 R5 #-1
  	BRp COUNTER
  	BR DONE

MULTIPLIER10
  	ADD R6 R6 #1
  	NOT R3 R0		; make and move R3 into negative
  	LD R1, CONVERT		; load 48 into R1 - conversion from ASCII to decimal      
  	ADD R3 R3 #1          
  	ADD R3 R3 R1		; convert to decimal!
	BRz SKIP4
  	ADD R2 R2 #10         	; multiplication of 10's
  	ADD R3 R3 R6          	; if negative, keep looping, else stop
	BRn MULTIPLIER10

SKIP4
  	LEA R3 ASCII
  	ADD R3 R3 #3
  	STR R2 R3 #0		; store R3 value to R2
  	ADD R1 R4 #-5
  	AND R6 R6 #0		; clear R6
  	ADD R5 R5 #-1
  	BRp COUNTER
  	BR DONE

MULTIPLIER1
  	ADD R6 R6 #1
  	LD R1, CONVERT		; load 48 into R1 - conversion from ASCII to decimal
  	NOT R3 R0		; make and move R3 into negative     
  	ADD R3 R3 #1          
  	ADD R3 R3 R1		; convert to decimal!
	BRz SKIP5
  	ADD R2 R2 #1         	; multiplication of 1's
  	ADD R3 R3 R6          	; if negative, keep looping, else stop 
	BRn MULTIPLIER1

SKIP5
  	LEA R3 ASCII
  	ADD R3 R3 #4
  	STR R2 R3 #0		; store R3 value to R2
  	ADD R1 R4 #-5
  	AND R6 R6 #0		; clear R6
  	ADD R5 R5 #-1
  	BRp COUNTER
  	BR DONE

DONE
  	AND R1 R1 #0
  	AND R4 R4 #0
  	LEA R3 ASCII		; load first address into R3

LOOP
  	ADD R4 R4 #1
  	LDR R2 R3 #0		; load value of address into R2
  	ADD R1 R1 R2		; R1 + R2 = R1
  	ADD R3 R3 #1		; shift address by 1
  	ADD R5 R4 #-5		; loop 5 times, finish
	BRn LOOP
  	LEA R2 NEGATIVE
  	LDR R3 R2 #0
  	ADD R3 R3 #-1		; shift address by -1
	BRz Flip		; jump to flip if true
	BR POSITIVE

Flip				; 2's complement - add 1 and flip (NOT)
  	NOT R1 R1
  	ADD R1 R1 #1		; shift address by 1
	BR POSITIVE		; jump to positive if true
  
POSITIVE
  	AND R2, R2, #0
  	AND R3, R3, #0
  	LD R2, MASK_COUNT	; load mask

  
WHILE_LOOP
  	ADD R3 R2 R5		; R2 + R5 = R3
  	BRz LOOP_END
  	LEA R3, BINARY
  	ADD R3, R3, R5		; R3 + R5 = R3	
  	LDR R4, R3, #0
  	AND R4, R4, R1		; R4 +R1 = R4
  	BRz NONE_BIT
  	LD R0, ONE		; if results is 1
  	OUT                 
  	ADD R5, R5, #1      	; add one to loop counter
  	BR WHILE_LOOP    	; loop again

NONE_BIT			; if result is 0
  	LD R0, ZERO
  	OUT                 

  	ADD R5, R5, #1      	; add 1 to loop counter
  	BRnzp WHILE_LOOP    	; loop again

LOOP_END

  	LD R0, Newline
  	OUT                 
  	LEA R1 SUM
  	LEA R3 NEGATIVE		; load negative address to R3
  	AND R2 R2 #0		; clear R2
  	STR R2 R1 #0		; store R1 value to R2
  	STR R2 R3 #0		; store R3 value to R2
  	AND R1 R1 #0		; clear R1

CLEAR1				; clear memory for next users' input
  	LEA R2 ASCII
  	ADD R2 R2 R1		; R2 +r1 = R2
  	AND R3 R3 #0		; clear R3
  	STR R3 R2 #0		; store R2 to address

  	ADD R1 R1 #1		; add 1 to R1

  	AND R4 R4 #0		; clear R4
  	ADD R4 R1 #-5		
	BRn CLEAR1		; jump to clear1
  	AND R1 R1 #0		; clear R1

CLEAR2
  	LEA R2 ENTER
  	ADD R2 R2 R1		; R2 + R1 = R2
  	AND R3 R3 #0		; clear R3
  	STR R3 R2 #0 		; store R2 to address

    	ADD R1 R1 #1		; add 1 to R1

  	AND R4 R4 #0		; clear R4
  	ADD R4 R1 #-5
	BRn CLEAR2		; jump to clear2

  	LD R0 Newline
  	OUT
	BR START

EXIT
	LEA R0 BYE		; bye string
	PUTS
  	HALT

BINARY  .FILL   b1000000000000000	; masks 
        .FILL   b0100000000000000
        .FILL   b0010000000000000
        .FILL   b0001000000000000
        .FILL   b0000100000000000
        .FILL   b0000010000000000
        .FILL   b0000001000000000
        .FILL   b0000000100000000
        .FILL   b0000000010000000
        .FILL   b0000000001000000
        .FILL   b0000000000100000
        .FILL   b0000000000010000
        .FILL   b0000000000001000
        .FILL   b0000000000000100
        .FILL   b0000000000000010
        .FILL   b0000000000000001

X .FILL #-120
ONE .FILL x00031
NEGATIVE_SIGN .FILL #-45
NEGATIVE .BLKW 1
ZERO .FILL x00030
MASK_COUNT .FILL #-16
MULTI_10000 .FILL #10000
MULTI_1000 .FILL #1000
MULTI_100 .FILL #100
CONVERT .FILL #48
Newline .FILL #10
SUM   .BLKW 1
ASCII .BLKW 5
ENTER .BLKW 5
HELLO .STRINGZ "Please input a number! Or press x to quit."
THANKS .STRINGZ "Thanks, here it is in binary."
BYE .STRINGZ "See ya! Have a good one!."

.END