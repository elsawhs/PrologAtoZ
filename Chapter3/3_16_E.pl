% Exercise 3.16.2.
:- consult('capitals.pl').



apply(Functor,Arglist) :- Query=.. [Functor|Arglist],
						  call(Query).

% map(Functor,List,Result).
map(Functor,[],[]).
map(Functor,[Hs|Ts],Result) :- apply(Functor,[Hs,T1]),
							   map(Functor,Ts,T2),
							   append([T1],T2,Result).
							  
