%:-op(600,fy,s).
%:-op(500,fy,l).
%:-op(400,yfx,a).

% generate lambda terms in De Bruijn notation
% l = lambda
% a = application
% s = successor, counting from 0

/*

X=l(l(a(0,l(0))))
||
\/
\z.\y. (y (\x.x) )
\x.\y. (y (\z.z) )

exercise: convert a(a(l(l(s(0))),l(l(0))),l(0))

to standard lambda notation
*/

genLambda(s(S),X):-genLambda(X,S,0).

genLambda(X,N1,N2):-nth_elem(X,N1,N2).
genLambda(l(A),s(N1),N2):-genLambda(A,N1,N2).  
genLambda(a(A,B),s(s(N1)),N3):-
  genLambda(A,N1,N2),
  genLambda(B,N2,N3).

nth_elem(0,N,N).
nth_elem(s(X),s(N1),N2):-nth_elem(X,N1,N2).	

% generate closed lambda terms
genClosed(s(S),X):-genClosed(X,[],S,0).

genClosed(X,Vs,N1,N2):-nth_elem_on(X,Vs,N1,N2).
genClosed(l(A),Vs,s(N1),N2):-genClosed(A,[_|Vs],N1,N2).  
genClosed(a(A,B),Vs,s(s(N1)),N3):-
  genClosed(A,Vs,N1,N2),
  genClosed(B,Vs,N2,N3).

nth_elem_on(0,[_|_],N,N).
nth_elem_on(s(X),[_|Vs],s(N1),N2):-nth_elem_on(X,Vs,N1,N2).

% infer the type of a lambda term
% 1) in an application (a/2) node: X->Y and X reduce to Y
% 2) all variables of the lambda binder l/1 should have 
% the same type - we unify them, avoiding cycles

type_of(X,T):-type_of(X,T,[]).

type_of(I,V,Vs):- % 2
  nth_elem_of(I,Vs,V0),
  unify_with_occurs_check(V,V0).
type_of(l(A),(X->Y),Vs):- 
  type_of(A,Y,[X|Vs]). 
type_of(a(A,B),Y,Vs):- % 1
  type_of(A,(X->Y),Vs),
  type_of(B,X,Vs).

nth_elem_of(0,[X|_],X).
nth_elem_of(s(I),[_|Xs],X):-nth_elem_of(I,Xs,X).

% gnerate all simply typed terms of given size
genTypable(X,V,Vs,N1,N2):-genIndex(X,Vs,V,N1,N2).
genTypable(l(A),(X->Xs),Vs,s(N1),N2):-
  genTypable(A,Xs,[X|Vs],N1,N2).  
genTypable(a(A,B),Xs,Vs,s(s(N1)),N3):-
  genTypable(A,(X->Xs),Vs,N1,N2),
  genTypable(B,X,Vs,N2,N3).

genIndex(0,[V|_],V0,N,N):-unify_with_occurs_check(V0,V).
genIndex(s(X),[_|Vs],V,s(N1),N2):-genIndex(X,Vs,V,N1,N2).	

% enforcing or not terms to be closed
genPlainTypable(S,X,T):-genTypable(S,_,X,T).

genClosedTypable(S,X,T):-genTypable(S,[],X,T).

genTypable(s(S),Vs,X,T):-genTypable(X,T,Vs,S,0).

% tests

genLambda(N):-n2s(N,S),genLambda(s(S),X),write(X),nl,fail.

genClosed(N):-n2s(N,S),genClosed(s(S),X),write(X),nl,fail.

genTyped(N):-n2s(N,S),genClosed(s(S),X),type_of(X,T),
  write(X),nl,
  numbervars(T,0,_),
  write(T),nl,nl,
  fail.

n2s(0,0).
n2s(SN,s(X)):-SN>0,N is SN-1,n2s(N,X).
