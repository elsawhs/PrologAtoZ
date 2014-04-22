gensym(What) :- retract(count_aux1(N)),
			 X is N + 1,
			 X =< 122,
			 asserta(count_aux1(X)),
			 name(What,[X]).
			 
:- dynamic(count_aux1/1).
count_aux1(96).


gensym1(What) :- gensym1_aux(N,X),
					name(What,[X]).
					   
gensym1_aux(N,X) :- step(N,X),
					X <= 100,
					asserta(count_aux(X)).
gensym1_aux(N,X) :- step(N,X),
					X > 100,
					retract(count_aux(X)),
					gensym1_aux(R,R1),
					asserta(count_aux([100,R1])).
					
step1(N,X) :- retract(count_aux(N)),
			  X is N + 1.
count_aux(96).