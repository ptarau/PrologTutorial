% subset of coroutining Prolog engine operations

new_engine(X,G,E):-engine_create(X,G,E).
stop(E):-engine_destroy(E).
ask(E,A):-engine_next_reified(E,A).
yield(A):-engine_yield(A).

% source-level emulation of Prolog built-ins with engines

if(Cond,Then,Else):-
   new_engine(Cond,Cond,Engine),
   ask(Engine,Answer),
   stop(Engine),
   process_answer(Answer,Cond,Then,Else).


process_answer(the(Cond),Cond,Then,_):-call(Then).
process_answer(no,_,_,Else):-call(Else).

not_(G) :- if(G,fail,true).

once_(G) :- if(G,true,fail).

var_(X):-not_(not_(X=1)),not_(not_(X=2)).

nonvar_(X):-not_(var_(X)).

copy_term_(T,CT) :- new_engine(T,true,E), ask(E,the(CT)), stop(E).

findall_(X,G,Xs) :- new_engine(X,G,E), ask(E,Y), collect(E,Y,Xs).

collect(_,no,[]).
collect(E,the(X),[X|Xs]) :- ask(E,Y), collect(E,Y,Xs).
