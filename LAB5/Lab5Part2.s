/* Lynne Diep
   TA: Chandaras
   Lab Section 1: T/Thurs @ 2PM
   Due Date: November 20, 2016
   Lab 5 Part 2
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
    LA $a0,Greeting			/* Greeting Message */
    JAL puts
    NOP
    
    addi $t0, $zero, 0xF00		/*make switches inputs*/
    sw $t0, TRISDSET
    
    ori $t0,$zero,0xff			/* make LEDS outputs */		
    LA $t1, TRISECLR
    sw $t0,0($t1)
    addi $t0, $zero, 0x1
    
    
   
left:
    jal mydelay
    NOP
    LI $a0,0xFFFF			/* base delay */
    lw $t2, PORTD			/* read in 4 swtiches */
    srl $t2, 8				/* shift switches to lowest 4 bits*/
    andi $t2, $t2, 0xf			/* bit mask */
    addi $t2, $t2, 1			/* 0-15 to 1-16*/
    mult $t2,$a0			/* base delay times switches*/
    mflo $a0				/* put multiply in $a0*/
    li $t2,0x100			/* $t2 = 0001 0000 0000 */
    sw $t0,LATE
    sll $t0,$t0,1			/* shift left by 1 */
    bne $t0,$t2,left			/* keep going left if not on 8 bit */
    nop
    addi $t0, $zero, 0x80
    
	
   
right:
    LI $a0,0xFFFF			/* base delay */
    lw $t2, PORTD			/* read in 4 switches */
    srl $t2, 8				/* shift to last 4 bits */
    andi $t2, $t2, 0xf			/* bit mask */
    addi $t2, $t2, 1			/* 0-15 -> 1-16 */
    mult $t2,$a0			/* base delay times switches*/
    mflo $a0				/* put multiply in $a0*/
    jal mydelay
    NOP
    li $t3,0x01				/* $t3 = 0000 0001 */
    srl $t0,$t0,1			/* shift right by 1 */
    sw $t0,LATE
    bne $t0,$t3,right			/* keep going right if not 1 bit */
    NOP
    addi $t0, $zero, 0x1
    b left
    nop
    
   
mydelay:
    ADDI $a0,$a0,-1			/* count down until 0 */
    BGEZ $a0, mydelay
    NOP
    J $ra
    nop

        
   
    

    
    
    
   

    
    
    
    
    
hmm:    J hmm
    NOP
endProgram:
    J endProgram
    NOP
.end main



.data
Greeting: .asciiz "Welcome! Look at the LEDs! \n"


