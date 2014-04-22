%
%  Exercise 3.13.3
% 

read_str(String) :- get0(Char),
					read_str_aux(Char,String).
read_str_aux(-1,[]) :- !.
read_str_aux(10,[]) :- !.
read_str_aux(13,[]) :- !.
read_str_aux(Char,[Char|Rest]) :- read_str(Rest).

write_str([H|T]) :- put(H),
					write_str(T).
write_str([]).

read_charlist(Charlist) :- read_str(Input), write_str(Input),
						   switch(Charlist,Input).

read_str_no_blanks(String):- get0(Char), 
							 read_str_no_blanks_aux(Char,String).
read_str_no_blanks_aux(-1,[]):- !.
read_str_no_blanks_aux(10,[]):- !.
read_str_no_blanks_aux(13,[]):- !.

switch([],[]).
switch([X],[H]) :- char_code(X,H).
switch(Result,[H|T]) :- char_code(Hx,H),
						switch(Tx,T),
						append([Hx],Tx,Result).
				 






