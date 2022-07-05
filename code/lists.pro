% concatenate to lists
append_([],Ys, Ys).
append_([X|Xs],Ys,[X|Zs]):-append_(Xs,Ys,Zs).

% explore elements of a list
member_(X,[X|_]).
member_(X,[_|Xs]):-member_(X,Xs).

% member in terms of append
member__(X,Xs):-append_(_,[X|_],Xs).

% generate subsets of a set
subset_of([],[]).
subset_of([_|Xs],Ys):-subset_of(Xs,Ys).
subset_of([X|Xs],[X|Ys]):-subset_of(Xs,Ys).

% subset + complement generator
subset_and_complement_of([],[],[]).
subset_and_complement_of([X|Xs],NewYs,NewZs):-
  subset_and_complement_of(Xs,Ys,Zs),
  place_element(X,Ys,Zs,NewYs,NewZs).

place_element(X,Ys,Zs,[X|Ys],Zs).
place_element(X,Ys,Zs,Ys,[X|Zs]).

% permutations of a list
perm_of([],[]).
perm_of([X|Xs],Zs):-
  perm_of(Xs,Ys), % handling the (shorter) tail of the list
  insert(X,Ys,Zs). % inductive step: insert X into Ys

insert(X,Xs,[X|Xs]).
insert(X,[Y|Xs], [Y|Ys]):-insert(X,Xs,Ys).

% some work with higher order predicates

sum_lists(Xs,Ys,Zs):-maplist(plus,Xs,Ys,Zs).

% all subsets, with findall
all_subsets_of(Xs,Yss):-
  findall(Ys,subset_of(Xs,Ys),Yss).
  
% a simple quicksort predicate
qsort([],[]).
qsort([X|Xs],Rs):-
  findall(Y,(member(Y,Xs),Y<X),LittleOnes),
  findall(Y,(member(Y,Xs),Y>=X),BigOnes),
  qsort(LittleOnes,Firsts),
  qsort(BigOnes,Lasts),
  append(Firsts,[X|Lasts],Rs).


