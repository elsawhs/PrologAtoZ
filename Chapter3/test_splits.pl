% Section 3.12 Character String
write_str([]).
write_str([H|T] :- put(H),write_str(T).

% Exercise 3.12.1
print_splits([H|T]) :- write(' '),write_str([H|T]),nl, print_splits1_aux(T,[H]),!.
% print_splits1([H|T]) :- write_str([H]), write(' '),write_str(T),nl, print_splits1_aux(T,[H]).

print_splits_aux([],String):- write_str(String),write(' ').
print_splits_aux([H|T], Result) :- write_str(Result), write(' '),write_str([H|T]),nl,
									append(Result,[H],X), print_splits_aux(T,X),!.
