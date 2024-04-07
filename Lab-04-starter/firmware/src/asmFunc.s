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
    /*set r4 to 0, use r5 to store memory address of the variable, then set it to 0 with r4*/
    MOV r4, 0
    STR r4, [r5]
    LDR r5, = eat_out
    STR r4, [r5]
    LDR r5, = stay_in
    STR r4, [r5]
    LDR r5, = we_have_a_problem
    STR r4, [r5]
 
    
    CMP r0, 1000 /* Check if r0(transaction) > 1000*/
    BGT invalid /*check flags. Transaction greater than 1000. not valid according to fllow chart*/
    CMP r0, -1000 /*Transaction less than -1000. Check if r0 (transaction) < -1000*/
    BLT invalid /*check flags. Transaction less than than -1000. not valid according to fllow chart*/
    
    /*We will use r10 for tmpBalance*/

    LDR r1, = balance /*grab memory location of balance, put it in r1*/
    LDR r2, [r1] /*set r2 to the value located at the memory address in r1*/ 
    LDR r3, = transaction /*grab memory location of transaction and put it in r3*/
    LDR r4, [r3] /*load the value in memory address stored in r3 to r4*/
    ADDS r10, r2, r0 /* add Bal + Tranaction then store in tempBal which I decided is r10*/
    BVS invalid /*check overflow flag*/

    LDR r1, = balance /* Balance valid, load temp balance into main balance*/
    STR r10, [r1]
    LDR r3, [r1]
    CMP r3, 0 /*compare r3 with 0 then check condition flags*/
    BGT eatout /*check if bal > 0*/
    BLT stayin /* check if bal < 0 */
    B eatcream /*was not geater or less than so must be 0*/
    eatout: /*eatout label which is branched too when balance > 0*/
	MOV r4, 1 /*setting eat_out to 1*/
	LDR r1, = eat_out
	STR r4, [r1]
	B cleanup /*go to final step in the flowchart, branch to skip next instructions*/
    stayin:/*stayin label which is branched too when balance < 0*/
	MOV r4, 1 /*set stay_in to 1*/
	LDR r1, = stay_in
	STR r4, [r1]
	B cleanup/*go to final step in the flowchart*/

    eatcream: /*eat cream label triggered when bal is 0*/
	MOV r4, 1
	LDR r1, = eat_ice_cream
	STR r4, [r1] /*no need to branch because cleanup comes right after*/
    /*set the balance like the flowchart says*/
    cleanup: 
	LDR r4, = balance
	LDR r0, [r4]
	B done
    /*Transaction invalid, set condition and variables based off the flowchart*/
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
           




