truthTable(F):-
  term_variables(F,Vs),
  eval(F,R),writeln(Vs:R),
  fail
; true.

sat(X):-eval(X,1),!.

taut(X):- not(eval(X,0)).

taut0(X):-term_variables(X,Vs),
  writeln(X:Vs),
  eval(X,R),writeln(X:Vs=R),fail;true.

eval(X,X):-var(X),!,bit(X).
eval(X,R):-integer(X),!,R=X.
eval((-A),R):-
  eval(A,X),
  neg(X,R).  
eval((A->B),R):-
  eval(A,X),
  eval(B,Y),
  impl(X,Y,R).
eval((A*B),R):-
  eval(A,X),
  eval(B,Y),
  conj(X,Y,R).  
eval((A+B),R):-
  eval(A,X),
  eval(B,Y),
  disj(X,Y,R).  
eval((A=B),R):-
  eval(A,X),
  eval(B,Y),
  eq(X,Y,R).  
  
impl(0,0,1).
impl(0,1,1).
impl(1,0,0).
impl(1,1,1).

conj(0,0,0).
conj(0,1,0).
conj(1,0,0).
conj(1,1,1).

disj(0,0,0).
disj(0,1,1).
disj(1,0,1).
disj(1,1,1).

eq(0,0,1).
eq(0,1,0).
eq(1,0,0).
eq(1,1,1).

neg(0,1).
neg(1,0).

bit(0).
bit(1).


test1:-
  X= -(A*B),
  Y=(-A) + (-B),
  F = (X=Y),
  truthTable(F),
  taut(F).
  
/* usage:

?- sat(A*B+ -A).
A = B, B = 0.

?- taut(A*B+ -A).
false.

?- taut(A->B->A).
true.

?- truthTable(A*B+B*C+C*A).
[0,0,0]:0
[0,0,1]:0
[0,1,0]:0
[0,1,1]:1
[1,0,0]:0
[1,0,1]:1
[1,1,0]:1
[1,1,1]:1

?- eval(eq(A,B),R).
false.

?- eval((A=B),R).
A = B, B = 0,
R = 1 ;
A = R, R = 0,
B = 1 ;
A = 1,
B = R, R = 0 ;
A = B, B = R, R = 1.

?- test1.
[0,0]:1
[0,1]:1
[1,0]:1
[1,1]:1
true.

?- make.
% Updating index for library /usr/local/lib/swipl/library/
% /Users/tarau/Desktop/www/teaching/GPL/LP/bool.pro compiled 0.00 sec, 0 clauses
true.

?- test1.
[0,0]:1
[0,1]:1
[1,0]:1
[1,1]:1
true.

?- sat(A * -B + B * -C + C * -A).
A = B, B = 0,
C = 1.


% Peirce's law
?- taut(((X -> Y) -> X) -> X).
true.


*/


