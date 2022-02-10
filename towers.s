	.arch armv8-a
	.text

@ print function is complete, no modifications needed
    .global	print
print:
      stp    x29, x30, [sp, -16]! //Store FP, LR.
      add    x29, sp, 0
      mov    x3, x0
      mov    x2, x1
      ldr    w0, startstring
      mov    x1, x3
      bl     printf
      ldp    x29, x30, [sp], 16
      ret

startstring:
	.word	string0

    .global	towers
towers:
   /* Save calllee-saved registers to stack */
   
   /* Save a copy of all 3 incoming parameters to callee-saved registers */

if:
   /* Compare numDisks with 2 or (numDisks - 2)*/
   /* Check if less than, else branch to else */
   
   /* set print function's start to incoming start */
   /* set print function's end to goal */
   /* call print function */
   /* Set return register to 1 */
   /* branch to endif */
else:
   /* Use a callee-saved varable for temp and set it to 6 */
   /* Subract start from temp and store to itself */
   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/

   /* subtract 1 from original numDisks and store it to numDisks parameter */

   /* Set end parameter as temp */
   /* Call towers function */
   /* Save result to callee-saved register for total steps */
   /* Set numDiscs parameter to 1 */
   /* Set start parameter to original start */
   /* Set goal parameter to original goal */
   /* Call towers function */
   /* Add result to total steps so far */
   
   /* Set numDisks parameter to original numDisks - 1 */
   /* set start parameter to temp */
   /* set goal parameter to original goal */
   /* Call towers function */
   /* Add result to total steps so far and save it to return register */

endif:
   /* Restore Registers */
   /* Return from towers function */

@ Function main is complete, no modifications needed
    .global	main
main:
      stp    x29, x30, [sp, -32]!
      add    x29, sp, 0
      ldr    w0, printdata 
      bl     printf
      ldr    w0, printdata + 4
      add    x1, x29, 28
      bl     scanf
      ldr    w0, [x29, 28] /* numDisks */
      mov    x1, #1 /* Start */
      mov    x2, #3 /* Goal */
      bl     towers
      mov    w4, w0
      ldr    w0, printdata + 8
      ldr    w1, [x29, 28]
      mov    w2, #1
      mov    w3, #3
      bl     printf
      mov    x0, #0
      ldp    x29, x30, [sp], 16
      ret
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"
