% generic square Sudoku solver and generator

/* 
    solves or generates all possible
    square sudoku problems of specified by a grid
    input: grid as  alist lists with _ marking free spots
    yield: one or more filled out grids as answers
    
    tested for sizes 4,9,16
    it might also work on size 25, given enough time
*/
       
% main logic

go:-solve(hard_problem).

gox:-
   solve(empty_problem(2)).

solve(Problem):-
  call(Problem,Board), % state problem
  show(Board),
  sudoku(Board), % solve it
  show(Board), nl,% show a solution
  fail.

empty_problem(M,B):-
  empty_board(M,B).

hard_problem(Board):-
  escargot(Rows),
  lists2board(Rows,Board).

escargot([
      [1, _, _, _, _, 7, _, 9, _],
      [_, 3, _, _, 2, _, _, _, 8],
      [_, _, 9, 6, _, _, 5, _, _],
      [_, _, 5, 3, _, _, 9, _, _],
      [_, 1, _, _, 8, _, _, _, 2],
      [6, _, _, _, _, 4, _, _, _],
      [3, _, _, _, _, _, _, 1, _],
      [_, 4, _, _, _, _, _, _, 7],
      [_, _, 7, _, _, _, 3, _, _]
  ]).

sudoku(B):-
  functor(B,_,N),
  to_dif_graph(B,Difs),  % builds dif graph
  mpp(Difs),nl,
  maplist(pick(N),Difs). % constrains graph

% build dif graph
to_dif_graph(B,Difs):-
   functor(B,_,N),
   bagof(XDif,
     I^J^(
         index_pairs(N,I-J),
         to_a_dif_graph(N,B,I,J,XDif)
       ),
     Difs
     ).

% collects all difs for var at I,J in board
to_a_dif_graph(N,B,I,J,X-Difs):-
   at(B,I-J,X),
   difs(row_dif,N,B,I,J,RowDifs),
   difs(col_dif,N,B,I,J,ColDifs),
   difs(bloc_dif,N,B,I,J,[BlocDifs]),
   app([RowDifs,ColDifs,BlocDifs],Difs).

% collects difs of a row, col or bloc generator
difs(Generator,N,B,I,J,Difs):-
  bagof(V,
     call(Generator,N,B,I,J,V),
     Difs
  ).

row_dif(N,B,I,J,V):-
  index_pairs(N,I-AltJ),
  J=\=AltJ,
  at(B,I-AltJ,V).

col_dif(N,B,I,J,V):-
  index_pairs(N,AltI-J),
  I=\=AltI,
  at(B,AltI-J,V).

bloc_dif(N,B,I,J,Xs):-
  M is round(sqrt(N)),
  blocs(M,Bs),
  sel(I-J,Bs,Cs),
  maplist(at(B),Cs,Xs).

blocs(M,Bloc):-
   bloc_ranges(M,L1H1),
   bloc_ranges(M,L2H2),
   bagof(IJ,bloc(L1H1,L2H2,IJ),Bloc).

bloc_ranges(M,Low-High):-
  between(1,M,K),
  Low is  1+(K-1)*M,
  High is K*M.

bloc(L1-H1,L2-H2,I-J):-
  between(L1,H1,I),
    between(L2,H2,J).

% logic helpers

sel(X,[X|Xs],Xs).
sel(X,[Y|Xs],[Y|Ys]):-sel(X,Xs,Ys).


app([], []).
app([L|Ls], As) :- append(L, Ws, As), app(Ls, Ws).


at(B,I-J,V):-arg(I,B,Vs),arg(J,Vs,V).

index_pairs(N,I-J):-
  between(1,N,I),
  between(1,N,J).

% constrains dif graph
pick(N,X-Xs):- between(1,N,X), \+ member_const(X,Xs).

member_const(X,[Y|_]):-nonvar(Y),X=:=Y,!.
member_const(X,[_|Xs]):-member_const(X,Xs).

% IO helpers

empty_board(M,B):-
  N is M*M,
  length(Rs,N),
  maplist(empty_row(N),Rs),
  B=..[board|Rs].

empty_row(N,R):-functor(R,row,N).


lists2board(Rows,Board):-
  maplist(list2row,Rows,Lines),
  Board=..[board|Lines].

list2row(Xs,Row):-
  Row=..[row|Xs].

ppp(X):-portray_clause(X).

mpp(Xs):-numbervars(Xs,0,_),member(X,Xs),write(X),nl,fail;true.

show(B):-
  functor(B,_,N),
  ( numbervars(B,0,_),
    between(1,N,I),
     (between(1,N,J),
        at(B,I-J,X),
        write(X),write(' '),
        fail
     ; nl
     ),
    fail
  ; nl
  ).

% tests

t0:-
  M=2,N=4,
  empty_board(M,B),
  bloc_dif(N,B,I,J,Xs),
  ppp((I-J):(Xs:-B)),
  fail.

t1:-
  M=2,
  empty_board(M,B),
  to_dif_graph(B,Difs),
  ppp((B:-Difs)),
  fail.

t2:-
  M=2,N is M*M,I=2,J=3,
  empty_board(M,B),
  show(B),

  difs(row_dif,N,B,I,J,Difs),
  ppp((B:-Difs)),
  fail.

t3:-
  M=2,N is M*M,I=2,J=3,
  empty_board(M,B),
  show(B),
  difs(col_dif,N,B,I,J,Difs),
  ppp((B:-Difs)),
  fail.

t4:-
  M=2,N is M*M,I=2,J=3,
  empty_board(M,B),
  show(B),
  difs(bloc_dif,N,B,I,J,[Difs]),
  ppp((B:-Difs)),
  fail.

