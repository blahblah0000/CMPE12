/* Lynne Diep
   TA: Chandaras
   Lab Section 1: T/Thurs @ 2PM
   Due Date: November 20, 2016
   Lab 5 Part 1
*/
#include <WProgram.h>
#include <xc.h>
/* define all global symbols here */
.global main
    

.text
.set noreorder

.ent main
main:
    /* this code blocks sets up the ability to print, do not alter it */
    ADDIU $v0,$zero,1
    LA $t0,__XC_UART
    SW $v0,0($t0)
    LA $t0,U1MODE
    LW $v0,0($t0)
    ORI $v0,$v0,0b1000
    SW $v0,0($t0)
    LA $t0,U1BRG
    ADDIU $v0,$zero,12
    SW $v0,0($t0)
    
    /* your code goes underneath this */
loop:
    LA $t0,PORTD		
    LW $t1,0($t0)			/* $t1 = PORTD */
    ANDI $t2,$t1,0xF00			/* $t2 = 0b xxxx 0000 0000 */
    SRL $t2,$t2,8			/* $t2 = 0b 0000 0000 xxxx */
    ANDI $t3,$t1,0xE0			/* $t3 = 0b xxx0 0000 */
    OR $t2,$t2,$t3			/* $t2 = 0b xxx0 xxxx */
    LA $t4,PORTF
    LW $t5,0($t4)			/* $t5 = PORTF */
    ANDI $t6,$t5,0x2			/* $t6 = 0b 0000 00x0 */
    SLL $t6,$t6,3			/* $t6 = 0b 000x 0000 */
    OR $t2,$t2,$t6			/* $t2 = 0b xxxx xxxx */
    LA $t0, TRISE			/*	    ^BTN  ^SW */
    SW $zero,0($t0)
    LA $t0,PORTE
    SW $t2,0($t0)
    B loop
    
    LA $a0,HelloWorld
    JAL puts
    NOP
    
hmm:    J hmm
    NOP
endProgram:
    J endProgram
    NOP
.end main



.data
HelloWorld: .asciiz "Assembly Hello World \n"


