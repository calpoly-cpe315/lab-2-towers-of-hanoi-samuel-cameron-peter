	.arch armv8-a
	.text
#print function is complete, no modifications needed
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
   stp    x19, x20, [sp, -16]!
   stp    x21, x22, [sp, -16]!
   stp    x23, x24, [sp, -16]!
   stp    x25, x26, [sp, -16]!
   stp    x27, x28, [sp, -16]!
   stp    x29, x30, [sp, -16]! //Store FP, LR.

   /* Save a copy of all 3 incoming parameters to callee-saved registers */
   mov x19, x0 /* numDisks */
   mov x20, x1 /* start */
   mov x21, x2 /* goal */

if:
   /* Compare numDisks with 2 or (numDisks - 2)*/
   cmp x19, #2
   /* Check if less than, else branch to else */
   b.ge else

   /* set print function's start to incoming start */
   mov x0, x20
   /* set print function's end to goal */
   mov x1, x21
   /* call print function */
   bl print
   /* Set return register to 1 */
   mov x0, #1
   /* branch to endif */
   bl endif
else:
   /* Use a callee-saved varable for temp and set it to 6 */
   mov x22, #6
   /* Subract start from temp and store to itself */
   sub x22, x22, x20
   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/
   sub x22, x22, x21

   /* subtract 1 from original numDisks and store it to numDisks parameter */
   sub x0, x19, #1

   /* Call towers function */
   mov x1, x20 /* start */
   mov x2, x22 /* goal */
   bl towers
   /* Save result to callee-saved register for total steps */
   mov x23, x0

   /* Set numDiscs parameter to 1 */
   mov x0, #1
   /* Set start parameter to original start */
   mov x1, x20 /* start */
   /* Set goal parameter to original goal */
   mov x2, x21 /* goal */

   /* Call towers function */
   bl towers
   /* Add result to total steps so far */
   add x23, x23, x0

   /* Set numDisks parameter to original numDisks - 1 */
   sub x0, x19, #1 /* numDisks */
   /* set start parameter to temp */
   mov x1, x22 /* start */
   /* set goal parameter to original goal */
   mov x2, x21 /* goal */
   /* Call towers function */
   bl towers
   /* Add result to total steps so far and save it to return register */
   add x0, x23, x0

endif:
   /* Restore Registers */
   ldp    x29, x30, [sp], #16
   ldp    x27, x28, [sp], #16
   ldp    x25, x26, [sp], #16
   ldp    x23, x24, [sp], #16
   ldp    x21, x22, [sp], #16
   ldp    x19, x20, [sp], #16
   /* Return from towers function */
   ret

# Function main is complete, no modifications needed
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
