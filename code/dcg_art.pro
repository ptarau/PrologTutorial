dall_e(Ws):-about(Ws,[]),interesting(Ws).

interesting(_).

about-->[a],painter_name,[painting,of],actors,location.
about-->painter_name,[painting,of],event,location.
about-->style,[painting],actors,location.
about-->actors,action,location,style,[style].
about-->actors,action,instrument,location.
about-->actors,[having],event,style,[style].


painter_name-->['Salvador','Dali'].
painter_name-->['Hieronymus','Bosch'].
painter_name-->['Russeau'].
painter_name-->['Van','Gogh'].


event-->[dinner,party].
style-->[surrealist];[impressionist].

location-->[on,the,moon];[at,the,zoo];[in,a,mirror];[in,a,lagoon].
instrument-->[with,a,violin].

plurality-->[cars];[twin,primes];[chickens].


action-->[playing].
action-->[looking,at,each,other].

actors-->actor(Xs),[and],actor(Ys),different(Xs,Ys).
actors-->plurality.

actor([A,X])-->attribute(A),noun(X).
actor([X])-->noun(X).

noun(cat)-->[cat].
noun(elephant)-->[elephant].
noun(ghost)-->[ghost].
noun(orchid)-->[orchid].

attribute(blue)-->[blue].
attribute(golden)-->[golden].


different(Xs,Ys,Ws,Ws):- not((member(X,Xs),member(X,Ys))).

show(Ws):-member(W,Ws),write(W),write(' '),fail;nl.

go:-dall_e(Words),show(Words),fail;nl.

/*
?- go.

TODO:
  pick any of the generated sentences and paste it to:
  https://www.craiyon.com/
  where the Dalle-mini program will paint it

*/
