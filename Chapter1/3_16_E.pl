% Exercise 3.16.2
:- ('family.pl').

answer_question :- write('Mother or father?'),
				   read_atom(X),
				   write('Of whom?'),
				   read_atom(Y),
				   Q =.. [X,Who,Y],
				   call(Q).
				   write(Who),
				   nl.
				   