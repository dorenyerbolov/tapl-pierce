/* Examples for testing */

  
 lambda x:<a:Bool,b:Bool>. x;
 

"hello";

unit;

lambda x:A. x;

let x=true in x;

timesfloat 2.0 3.14159;

{x=true, y=false}; 
{x=true, y=false}.x;
{true, false}; 
{true, false}.1; 


lambda x:Bool. x;
(lambda x:Bool->Bool. if x false then true else false) 
  (lambda x:Bool. if x then false else true); 

lambda x:Nat. succ x;
(lambda x:Nat. succ (succ x)) (succ 0); 

T = Nat->Nat;
lambda f:T. lambda x:Nat. f (f x);

/* Sum types */  
PhysicalAddr = {firstLast: String, addr: String};
VirtualAddr = {name:String, email: String};
IpAddr = {ip:String, mac: String};
TestAddress = {test1: String, test2: String};

/* PhysicalAddr + VirtualAddr (variant) */
Addr = <phys: PhysicalAddr, virt: VirtualAddr, ipadr: IpAddr>;

getName = lambda a:Addr.
    case a of
        <phys=x> ==> x.firstLast
        | <virt=x> ==> x.name
        | <ipadr=x> ==> x.mac;

  
pa = {firstLast="dyerbolov", addr="kbtu"} as PhysicalAddr;
va = {name="dadazs", email="dadazs@kbtu.kz"} as VirtualAddr;

addr1 = <phys=pa> as Addr; /* <phys=pa> ~ inl pa */
addr2 = <virt=va> as Addr; /* uniqueness of types */

getName addr1;
getName addr2;

OptionalNat = <none:Unit, some:Nat>;
noneNat = <none=unit> as OptionalNat;

plusOpt = fix (
    lambda f:OptionalNat->Nat->Nat.
        lambda n: OptionalNat. lambda m: Nat.
            case n of
                <none=x> ==> m
                | <some=x> ==> plus x m
);

plusOpt <some=3> as OptionalNat 5;

NatList = <nil:Unit, cons:{Nat,NatList}>;
nil = <nil=unit> as NatList;
cons = lambda n:Nat. lambda l:NatList. <cons={n,l}> as NatList; 
