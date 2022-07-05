% color vertices with given colors Cs
color_graph([],_).
color_graph([e(CI,CJ)|Es],Cs):-
  take_one_color(CI,Cs,OtherCs),
  take_one_color(CJ,OtherCs,_), % CJ is anything except CI
  color_graph(Es,Cs).
 
take_one_color(C,[C|Cs],Cs).
take_one_color(C,[Other|Cs1],[Other|Cs2]):-take_one_color(C,Cs1,Cs2).

% test data: undirected graph  as list of edges
go:-Edges=[
      e(V1,V2),e(V2,V3),e(V1,V3),e(V3,V4),e(V4,V5),
      e(V5,V6),e(V4,V6),e(V2,V5),e(V1,V6)
    ],
    Colors=[r,g,b],
    color_graph(Edges,Colors),
      writeln(Edges),
    fail
;   writeln(done).
    
/*
?- go.
[e(r,g),e(g,b),e(r,b),e(b,r),e(r,b),e(b,g),e(r,g),e(g,b),e(r,g)]
[e(r,g),e(g,b),e(r,b),e(b,g),e(g,r),e(r,b),e(g,b),e(g,r),e(r,b)]
[e(r,b),e(b,g),e(r,g),e(g,r),e(r,g),e(g,b),e(r,b),e(b,g),e(r,b)]
[e(r,b),e(b,g),e(r,g),e(g,b),e(b,r),e(r,g),e(b,g),e(b,r),e(r,g)]
[e(g,r),e(r,b),e(g,b),e(b,r),e(r,g),e(g,b),e(r,b),e(r,g),e(g,b)]
[e(g,r),e(r,b),e(g,b),e(b,g),e(g,b),e(b,r),e(g,r),e(r,b),e(g,r)]
[e(g,b),e(b,r),e(g,r),e(r,g),e(g,r),e(r,b),e(g,b),e(b,r),e(g,b)]
[e(g,b),e(b,r),e(g,r),e(r,b),e(b,g),e(g,r),e(b,r),e(b,g),e(g,r)]
[e(b,r),e(r,g),e(b,g),e(g,r),e(r,b),e(b,g),e(r,g),e(r,b),e(b,g)]
[e(b,r),e(r,g),e(b,g),e(g,b),e(b,g),e(g,r),e(b,r),e(r,g),e(b,r)]
[e(b,g),e(g,r),e(b,r),e(r,g),e(g,b),e(b,r),e(g,r),e(g,b),e(b,r)]
[e(b,g),e(g,r),e(b,r),e(r,b),e(b,r),e(r,g),e(b,g),e(g,r),e(b,g)]
done
true.
*/