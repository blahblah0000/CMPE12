/* Lynne Diep
   lytdiep
   TA: Chandaras
   Lab Section 1: T/Thurs @ 2PM
   Due Date: December 2, 2016
   Lab 6
*/
#include <WProgram.h>

#include <xc.h>
/* define all global symbols here */
.global main
.global read
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

    
    
    LA $a0,WelcomeMessage
    JAL puts
    NOP
    
    
    /* your code goes underneath this */
    li $t3, 0					/* int = 0 */
    li $t6, 0					/* flag = 0 */
    
    la $t0, inNumericString			/* load inNumericString to $t0*/
    
loop:
    lb $t1, 0($t0)				/* load first byte */
    addi $t0, $t0, 1				/* increment pointer by 1 */
    beq $t1, $zero, zero			/* if char is 0 */
    nop
    li $t2, 45					/* load "-"*/
    beq $t1, $t2, neg_sign			/* if char is negative*/
    nop
    sub $t2, $t1,48				/* digit = char-48 */
    li $t4, 10
    mult $t3,$t4				/* int=int(10)*/
    mflo $t3
    add $t3, $t3, $t2				/* int = int(10) + digit */
    b loop
    nop
     

neg_sign:
    add $t6, $t6, 1				/* flag = 1 */
    b loop
    nop
    
zero:
    la $t5, outBinaryString
    bne $t6, $zero, invert			/* if flag not equal to 0, go to invert */
    nop
    li $t4, 0x80000000				/* bit mask */
    li $t1, 32					/* counter*/
    b count
    nop
    
invert:
    nor $t3, $t3, $zero				/* invert int */
    add $t3, $t3, 1				/* add 1 for 2sc */
    li $t4, 0x80000000				/* bit mask */
    li $t1, 32					/* counter*/
    b count
    nop
    
print:
    and $t6, $t4, $t3				/* digit = int and mask */
    beqz $t6, print_0				/* if equal 0, put 0*/
    nop
    b print_1					/* else go to put1 */
    nop
    
print_0:
    li $a0, 48					/* load 0 */
    sb $a0, 0($t5)				/* store to outBinaryString */
    b printc
    nop
print_1:
    li $a0, 49					/* load 1 */
    sb $a0, 0($t5)				/* store to outBinaryString */
    b printc
    nop
    
printc:
    srl $t4, $t4, 1				/* shift bit mask right by 1 */
    add $t1, $t1, -1				/* count -- */
    add $t5, $t5, 1				/* address ++ */
    b count
    nop
 
 count:
    bgtz $t1, print				/* if counter > 0 */
    nop    

    
    
    /* your code goes above this */
    
    LA $a0,DecimalMessage
    JAL puts
    NOP
    LA $a0,inNumericString
    JAL puts
    NOP
    
    LA $a0,BinaryMessage
    JAL puts
    NOP
    LA $a0,outBinaryString
    JAL puts
    NOP
    
    

    
    

endProgram:
    J endProgram
    NOP
.end main




.data
WelcomeMessage: .asciiz "Welcome to the converter\n"
DecimalMessage: .asciiz "The decimal number is: "
BinaryMessage: .asciiz "The decimal number is: "
    
inNumericString: .asciiz "-0" 
outBinaryString: .asciiz "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"


