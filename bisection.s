// Elizabeth Bruski
// I pledge my honor that I have abided by the Stevens Honor System.
// halloween

.text
.global _start
.extern printf
/*
x0: a
x1: b
x2: n
x3: t
d25: 2.

d19 a
d20 b
d21 1.
d22 2. 
d23 a + b then a+b/2
d24
d25 tolerance
 */

midpointUpper: // reset b to be c
    FMOV D20, D23 // b = c
    FADD D23, D19, D20 // a + b in D23
    FDIV D23, D23, D22 // c
    RET

midpointLower: // reset a to c
    FMOV D19, D23 // a = c
    FADD D23, D19, D20 // a + b in D23
    FDIV D23, D23, D22 // c
    RET


 compute: // finds the value of a function at a particular x, given x in x0
 /*
 d0: x, should be given
 d1: sum, most important for return
 d2: the value of x^whatever power * coeff
 x3: counter
 x4: offset for current coeff
 d5: coeff value
 d6: x^power of the counter
 d7: coefficients

 x18: n
  */
    SUB SP, SP, 8 // allocate space on stack
    STR LR, [SP] // store LR in SP
    ADR X17, one
    LDR D17, [X17] // loads the double 1.
    ADR X7, coeff // x7: address of coefficients
    MOVi D1, 0 // sum starts at 0
    FMOV D2, D21
    //FMOV D2, 1.0 // x2 = double x^power, starting w 1
    MOV X3, 0 // counter starts at 0
    MOV X4, 0 // offset starts at 0
    LDR D5, [X7, X4] // load the first coefficient, put in S bc double?
    FMOV D6, D21 // x^power of counter

    CMP X3, 0 // counter to 0
        B.EQ opower // if 0 then no powers

    nextnum: // computes the next number
    CMP X3, X19 // compare counter and n, degree of polynomial
    B.LE continue // theoretically return sum, its in x1 rn
        LDR LR, [SP] // reallocate stack space
        ADD SP, SP, 8// add it back?
        RET
    continue: // else basically
    LDR D5, [X7, X4] // x5 = coeff[offset]
    FMUL D2, D6, D5 // x2 = x^power * coeff 
    FADD D1, D1, D2 // sum = sum + x^power * coeff

    opower: // increases everything accordingly
     FMUL D6, D6, D0 // x^power * x (basically increases power)
     LDR D2, one // reset D2 = 1.
     ADD X3, X3, 1 // counter++
     ADD X4, X4, 8 // offset + 8
     BL nextnum // compute the next number

bisection:  //
    /*
    find f(midpoint)
    see if f(a)-f(midpoint) has the root
    or f(midpoint)-f(b)
    //like make a = midpoint, b = b
    or a = a, b = midpoint
    compare the interval size (|a-b|) with the tolerance,
        if less than tolerance then RET
     */
    FADD D23, D19, D20 // a + b in D23
    FDIV D23, D23, D22 // c

    FMOV D1, D23 // put c in D0 
    FMUL D27, D0, D0 //squared value of the function

    FCMP D27, D25 // compare squared value of function to squared tolerance
    B.LT goprint // the interval is smalller than the tolerance
    FCMP D1, 0.0 // is D1 < 0
    B.LT midpointUpper
    B midpointLower

/* 
    FSUB X20, X19 // a - b
    FCMP X20, X25 // see if a-b is near tolerance
    B.LE RET // if interval is smaller than tolerance
    //check the other side
    FMUL X24, X25, X17 // neg interval
    B.LE X20, X24 RET // c
    */


goprint:  // print function
    ADR X0, funcVal // loads the address of the function call
    FMOV D0, D1 // stick the result in D0
    BL printf // print
    ADR X0, root // the root
    FMOV D0, D23 // move the root to D0
    BL printf // print
    MOV X0, 0 //ecit
    MOV X8, 93
    SVC 0


_start: // beginning
ADR X19, a // address of a to X
ADR X20, b // address b 
LDR D20, [X20] // load value b
LDR D19, [X19] // load value a 
ADR X21, one 
LDR D21, [X21] // loads double 1.0
ADR X22, two // 2.
LDR D22, [X22] // loads double 2.0

ADR X25, t // load tolerance to X25
LDR D25, [X25] // D25 = tolerance
FMUL D25, D25, D25

ADR X18, n // address of x19
LDR X18, [X18, 0] // value of n
CMP X18, 0 // if degree is 0
B.EQ print0 // if the degree is 0 then just print 0
BL bisection // bisect otherwise

print0: ADR X0, funcVal // loads the address of the function call
    MOV X0, 0 // stick the result in D0
    BL printf // print
    ADR X0, root // the root
    MOV X0, 0 // move the root to D0
    BL printf // print
    MOV X0, 0 //exit
    MOV X8, 93
    SVC 0


//BL midpoint // branch and link to the midpoint function


.data
 coeff: .double 5.3, 0.0, 2.9, -3.1 // coefficients of the polynomial function 
    // formatted like: a + bx + cx^2 + ... zx^n
 n: .dword 3 // the degree of the polynomial
 t: .double .01 // the user-specified tolerance
 a: .double -1.0 // user-specified a
 b: .double 1.0 // user-specified b
 one: .double 1.0 // only way things work
 two: .double 2.0
 negOne: .double -1.0

 root: .string "The root is: %d"
 funcVal: .string "The value of the function is: %d"

