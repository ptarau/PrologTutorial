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
TODO:
  pick any of the generated sentences and paste it to:
  https://www.craiyon.com/
  where the Dalle-mini program will paint it

*/
