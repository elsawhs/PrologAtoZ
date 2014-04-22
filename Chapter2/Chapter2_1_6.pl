% Chapter2 Constructing Prolog Programs
% Procedural interpretation of Prolog

% 2.3 Computing Versus Printing
:- consult('family.pl').

% Exercise 2.3.1
cathys_father(X) :- father(X,cathy).
print_cathys_father :- cathys_father(X),
						write(X).

% 2.4 Forcing backtracking with fail

:- consult('CAPITALS.pl').

% Exercise 2.4.4
?- write('The ancestor of Cathy are: '), ancestor(C,cathy),write(C),write(' '), fail.

% Chapter 2.5
print_capitals1 :- capital_of(State,City),
				  write(City),
				  write(' is the capital of '),
				  write(State),
				  nl,
				  fail.

print_a_capital :- capital_of(State,City),
				   write(City),
				   write(' is the capital of '),
				   write(State),
				   nl.
print_capitals :- print_a_capital,
				  fail.

print_capitals.

% Exercise 2.5.2
print_an_ancestor_of(Y) :- write('The ancestor of '),						   
						   write(Y),
						   write(' is '),
						   ancestor(X,Y),						   						
						   write(X),
						   write(' ').
						
print_ancestors_of(Y) :- print_an_ancestor_of(Y),
						 fail. 
% Chapter 2.6
:- consult('INTERAC.pl').

% Exercise 2.6.1
% The result is always atlant. Cuz the program consider the input as a variable and instaniated it with the first arg. (georiga).

% Exercise 2.6.2
% south_carolina

% Exercise 2.6.3
find_mother :- read(C),
			   mother(M,C),
			   write(M).

% 1 ?- read(yes). |: yes. true.
% 2 ?- read(yes). |: no. false.
% 3 ?- read(yes). |: Yes. true.
% 4 ?- read(yes). |: No. true.
% 5 ?- read(yes). |: y. false.
% 6 ?- read(yes). |: n. false.
% 7 ?- read(yes). |: y e s. ERROR: Stream user_input:3:35 Syntax error: Operator expected

% Eercise 2.6.4  Yes. It ingores. 











