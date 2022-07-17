dalle-->subject,verb,object.

subject-->[a,cat];[a,dog].

verb-->[sitting].

adjective-->[golden];[shiny].

object-->[on,the],adjective,location,[with,a],instrument.

location-->[moon].

instrument-->[violin];[trumpet].

go:-
  dalle(Words,[]),
  nl,
  member(W,Words),
  write(W),write(' '),
  fail.
go.

/*
?- go.

a cat sitting on the golden moon with a violin
a cat sitting on the golden moon with a trumpet
a cat sitting on the shiny moon with a violin
a cat sitting on the shiny moon with a trumpet
a dog sitting on the golden moon with a violin
a dog sitting on the golden moon with a trumpet
a dog sitting on the shiny moon with a violin
a dog sitting on the shiny moon with a trumpet
true.


TODO:
  pick any of the generated sentences and paste it to:
  https://www.craiyon.com/
  where the Dalle-mini program will paint it

*/
