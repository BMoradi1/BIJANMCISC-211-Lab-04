/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
    
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    /*set up our words*/
    LDR r1, = transaction
    STR r0, [r1]
    /*zero everything*/
    LDR r5, = eat_ice_cream
    MOV r4, 0
    STR r4, [r5]
    LDR r5, = eat_out
    STR r4, [r5]
    LDR r5, = stay_in
    STR r4, [r5]
    LDR r5, = we_have_a_problem
    STR r4, [r5]
 
    
    CMP r0, 1000 /* Check if r0(transaction) > 1000*/
    BGT invalid /*not valid according to fllow chart*/
    CMP r0, -1000 /*Check if r0 (transaction) < -100*/
    BLT invalid
    
    /*We will use r10 for tmpBalance*/

    LDR r1, = balance
    LDR r2, [r1]
    LDR r3, = transaction
    LDR r4, [r3]
    ADDS r10, r2, r0 /* add Bal + Tranaction then store in tempBal which I decided is r10*/
    BVS invalid

    LDR r1, = balance
    STR r10, [r1]
    LDR r3, [r1]
    CMP r3, 0
    BGT eatout /*check if bal > 0*/
    BLT stayin
    B eatcream /*was not geater or less than so must be 0*/
    eatout:
	MOV r4, 1
	LDR r1, = eat_out
	STR r4, [r1]
	B cleanup
    stayin:
	MOV r4, 1
	LDR r1, = stay_in
	STR r4, [r1]
	B cleanup

    eatcream:
	MOV r4, 1
	LDR r1, = eat_ice_cream
	STR r4, [r1]
    /*set the balance like the flowchart says*/
    cleanup: 
	LDR r4, = balance
	LDR r0, [r4]
	B done
    invalid:
	LDR r3, = balance
	LDR r0, [r3]
	MOV r4, 0
	LDR r1, = transaction
	STR r4, [r1]
	MOV r4, 1
	LDR r1, = we_have_a_problem
	STR r4, [r1]
	B done
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




