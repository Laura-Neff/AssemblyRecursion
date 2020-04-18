//THIS CODE IS MY OWN WORK, IT WAS WRITTEN WITHOUT CONSULTING A TUTOR OR CODE WRITTEN BY OTHER STUDENTS - LAURA NEFF

// ====================================================================
// Do not edit the ".global F" line
// ====================================================================
        .global F
	.global if, elseIf, for, else, forEnd


// **************************************************************************
// You can add more xdef directives above if you need more external labels
//
// - Remember that you can only add a label as a break point (stop location) 
//   in EGTAPI if the label has been xdef'ed !!!
//
// - And I am pretty sure you will need to use break point for debugging 
// - in this project... So add more xdef above to export your breakpoints
// **************************************************************************


/* ************************************************************
   This label marks the address of the recursive function F
   ************************************************************ */
F:

// ********************************************************************
// Put your (recursive) function F here below
//
// F receives the parameters i, j, k on the stack
// F returns the function value in register d0
//
// Make sure you use the "pop {pc}" instruction to return to the caller
//
// Also: Make sure you DE-ALLOCATE the local variables and restore fp
//       BEFORE you return to the caller !!!
// ********************************************************************

 // Write your recursive function here


/* int F(int i, int j, int k)
  {
     int s, t;

     if ( i <= 0 || j <= 0 )
        return(-1);
     else if ( i + j < k )
        return (i+j);
     else
     {
        s = 0;
        for (t = 1; t < k; t++)
        {
           s = s + F(i-t, j-t, k-1) + 1;               
        }
        return(s);
     }
  }
*/



	push    {lr}            // Save LR (return address)
        push    {fp}            // Save FP (used by caller)
        mov     fp, sp          // Mark the stack top location before
                                // allocating any local variables
        sub     sp, sp, #0      // Allocate 0 int variables on the stack because we're gonna use registers
                                

/* else */	
	ldr 	r1, [fp, #8]	//this is i
	ldr 	r2, [fp, #12]	//this is j
	ldr 	r3, [fp, #16]	//this is k

	add	r4, r1, r2	//this is i + j = r4


	cmp 	r1, #0		//i <= 0
	ble	if 

	cmp 	r2, #0		//j <= 0
	ble	if 

	cmp 	r4, r3
	blt	elseIf

else: 	
	 mov    r5, #0		//r5 = s = 0


	 mov    r6, #1		//r6 = t = 1 initially



for:
	 cmp 	r6, r3		//if t >= k, leave loop
	 bge	forEnd


	 sub 	r7, r1, r6	//F(i-t, j - t, k-1)

	 sub 	r9, r2, r6

	 sub 	r10, r3, #1


	 push 	{r1,r2,r3,r5,r6}	// save locals i,j,k,s,t to stack
	 push 	{r7, r9, r10}		// save recursive fn parameters (i-t, j-t, k-1) to stack
	
	 bl      F             		// Calls:  F(i, j, k) with parameters (i-t, j-t, k-1) !!!               
         
	add     sp, sp, #12      	// Clean up recursive fn parameters (i,j,k) from stack
	
	pop	{r1,r2,r3,r5,r6} 	// Restore locals i,j,k,s,t from stack
	

	 /* correction */


	 add	 r5, r5, r0		//r5 = r5+r0 (return value from recursive fn)
	 add	 r5, r5, #1		//r5 = r5+1   


 	 add	r6, r6, #1	//iterate! t++

	 b 	for


forEnd:
 

	mov     r0, r5		//return s to r0
	mov     sp, fp          // De-allocate local variables
        pop     {fp}            // Restore fp
        pop     {pc}            // Return to the caller
	



elseIf:

 	mov     r0, r4

	mov     sp, fp          // De-allocate local variables
        pop     {fp}            // Restore fp
        pop     {pc}            // Return to the caller

if:

	mov     r0, #-1

	mov     sp, fp          // De-allocate local variables
        pop     {fp}            // Restore fp
        pop     {pc}            // Return to the caller







//====================================================================
// Don't add anything below this line...
// ====================================================================
        .end



