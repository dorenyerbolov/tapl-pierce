/* PROBLEM 2 (GCD) */

plus = fix (
    lambda f:Nat->Nat->Nat.
      lambda n:Nat. lambda m:Nat.
        if (iszero n) then m
        else succ (f (pred n) m)
);

mult = fix (
    lambda f:Nat->Nat->Nat.
      lambda n:Nat. lambda m:Nat.
       if (iszero n) then 0
       else plus m (f (pred n) m)
);

minus = fix (
    lambda f:Nat->Nat->Nat.
      lambda n:Nat. lambda m:Nat.
        if (iszero m) then n
        else pred (f n (pred m))
);

fact = fix (
    lambda f:Nat->Nat.
      lambda n:Nat.
        if (iszero n) then 1
        else mult n (f (pred n))
);

pow = fix (
    lambda f:Nat->Nat->Nat.
      lambda n:Nat. lambda m:Nat.
        if (iszero m) then 1
        else mult n (f n (pred m))
);
/* Optional naturals (variant type) */
OptionalNat = <none:Unit, some:Nat>;

/* Logical NOT */
not = lambda b:Bool. 
      if b then false else true;

/* ">" sign implementation, that is used in div_rec implementation */
greater = lambda n:Nat. lambda m:Nat.
      not (iszero (minus n m));

/* actual division is here */
div_rec = fix (
    lambda f:Nat->Nat->Nat.
      lambda n:Nat. lambda m:Nat.
        if (greater m n) then 0
        else plus 1 (f (minus n m) m)
);

/* div function that handles division by zero */
div = lambda n:Nat. lambda m:Nat.
    if (iszero m) then <none=unit> as OptionalNat
    else <some=(div_rec n m)> as OptionalNat;

/* modulo operand implementation */
mod = lambda n:Nat. lambda m:Nat. 
    case (div n m) of <none=x> ==> div n m
                    | <some=p> ==> <some=minus n (mult m p)> as OptionalNat;

/* GCD with mod [OptionalNat is used to handle division by zero]*/
gcd = fix (
    lambda f:Nat->Nat->Nat.
        lambda n:Nat. lambda m:Nat.
            if (iszero m) then n
            else case (mod n m) of <some=x> ==> f m x
);

/* used in equal implementation */
abs_diff = lambda n:Nat. lambda m:Nat. plus (minus n m) (minus m n);

equal = lambda n:Nat. lambda m:Nat. iszero (abs_diff n m);

/* GCD without mod, but with minus */
gcd2 = fix (
    lambda f:Nat->Nat->Nat.
        lambda n:Nat. lambda m:Nat.
            if (iszero n) then m
            else if (iszero m) then n
            else if (equal n m) then n
            else if (greater n m) then f (minus n m) m
            else f n (minus m n)
);
/* both gcd and gcd2 are working fine */
div 0 12;
mod 24 12;
gcd 0 0; 
gcd 0 12; 
gcd 18 42;
gcd 16 24;
gcd2 0 0;
gcd2 0 12;
gcd2 18 42;
gcd2 16 24;

/* 
   gcd(0,0) = 0
   gcd(0,n) = gcd(n,0) = n 
*/

