% Nov.5 2012
% Chapter 4 Practice (Pre-Class)

% Section 4.1

% Section 4.2
% An important difference between Prolog and other programming languages is that Prolog procedures can have multiple definitions(Clauses),
% each applying under different conditions.
% For Prolog, condtional execution is normally expressed not with if or case statement but with alternative definitions of procudures
writename(1):- write('One').
writename(2):- write('Two').
writename(3):- write('Three').

% Key to make Prolog programming effective: Make each logical unit of program into a seperate procedure.
a(X):-	b,
		cd(X),
		e.
cd(0) :- c.
cd(X):- \+(X == 0),d.
%% Every time there is a decision to be made, Prolog calls a procedure and makes the decision by choosing the right clause.

% Exercise 4.2.1
% Define a predicate absval which, given a number, computes its absolute value. Do not use !.
% ?- absval(0,What). What = 0;; ?- absval(2.34,What). What = 2.34;; ?- absval(-34.5,What). What = 34.5.
absval(X,What):- \+ number(X),write('X has to be a number.').
absval(X,What) :- X < 0, What is 0-X.
absval(X,X).

%% Dr.Covington
absval(X,What) :- X < 0, What is 0-X.
absval(X,X) :- X >= 0.

%Exercise 4.2.2
% Define a predicate classify that takes one argument and prints odd, even, not an integer, or not a number at all, like this: (No cut.)
% ?- classify(3). odd;; ?-classify(4). even;; ?-classify(2.5). not an integer;; ?-classify(this(and,that)). not a number at all
classify(X) :- \+ number(X), write('Not a number').
classify(X) :- \+ integer(X), write('Not an integer').
classify(X) :- 0 is X mod 2, write('even').
classify(X) :- write('odd').

%% modified It has to be deterministic
classify_mod(X) :- \+ number(X), write('Not a number').
classify_mod(X) :- number(X),\+ integer(X), write('Not an integer').
classify_mod(X) :- integer(X), 0 is X mod 2, write('even').
classify_mod(X) :- integer(X), 1 is X mod 2, write('odd').

%Exercise 4.3 The "CUT" operation (!)
writename(1) :- write('One').
writename(2) :- write('Two').
writename(3) :- write('Three').
writename(X) :- X < 1, write('Out of range').
writename(X) :- X > 3, write('Out of range').

%% Unwanted alternatives are a common error in Prolog program. Make sure your procedure do the right thing,
%% not only on the first try but also upon backtracking
%% If former clauses sucessed, the program should not try the later clause. This could be done by put cut
%% At the moment the cut is executed, the computer forgets about any alternatives that were discovered upon, or after, entering the current clause.
% The effect of cut lasts only as long as the clause containning it is being executed.
writename(1) :- !, write('One').
writename(2) :- !, write('Two').
writename(3) :- !, write('Three').
writename(_) :- write('Out of range').

% Exercise 4.3.1
absval1(X,What):- \+ number(X),!,write('X has to be a number.').
absval1(X,What) :- X < 0, !,What is 0-X.
absval1(X,X).

%% Dr.Covington
absval_c(X,X) :- X >= 0,!.
absval_c(X,R) :- R is 0 - X.

absval_c1(X,X).
absval_c1(X,Y) :- X < 0, !,R is 0 - X.


% Exercise 4.3.2
classify1(X) :- \+ number(X),!, write('Not a number').
classify1(X) :- \+ integer(X), !,write('Not an integer').
classify1(X) :- 0 is X mod 2, !,write('even').
classify1(X) :- write('odd').

% Exercise 4.3.3
my_cut :- !.
fact(1).
fact(2).
cuttest0(X) :- fact(X),!.  %% Output: 1
cuttest1(X) :- fact(X), my_cut. %% Output: 12
%%


% Chapter 4.4 Red cut and greent cut
% Green cut makes program more efficient without affecting the set of solutions that the program generates
% Red cut prevents the program from generating solutions it would otherwise give.

%Chapter 4.5 Where not to put cut
% Not cut within the scope of negation
f(X) :- g(X), \+ (h(X),!).


% Chapter 4.6 Making a goal deterministic without cut
% once(Goal):- call(Goal),!.

% once servers as cut here. To make this predicate deterministics. 
f(x) :- g(X),once((h(X),i(X)),j(X).

absva46(X,What) :- once(absval46_aux(X,What)).
absva46_aux(X,What) :- X < 0, What is 0-X.
absva46_aux(X,X).

% Chapter 4.8 Making a goal always succeed or always fail
% An easy way to make any procedure succeed is to add an additional clause to it 
make_succeed(Goal) :- Goal, !.
make_succeed(_).
make_fail(Goal) :- call(Goal),!,fail.

% Exercise 4.8.1 
% Sha's solution
writename48(1) :- write('One'), !.
writename48(2):- write('Two'),!.
writename48(3):- write('Three'),!.
writename48(_).
% Other solution 
writename481(X) :- ( X = 1 -> write('one');
					 X = 2 -> write('two');
					 X = 3 ->  write('three');
					 true).

% Exercise 4.8.2
non_integer(X) :- integer(X),!,fail.
non_integer(_).

% Exercise 4.9 Repetition through backtracking
% built-in predicate repeat always succeeds.
typewriter:- repeat, get0(C), C = 13, !.
% Every repeat loop begins with a repeat goal and ends with a test that fails, followed by a cut

% Exercise 4.9.1
typewrite1 :- repeat, get0(C), (C = 13 ; C=10),!.
%% % Exercise 4.9.2
skip_until_blank :- repeat,get0(C),(C = 8 ; C = 46),!.
% Exercise 4.9.3
consult49(X) :- repeat, see(X), read(Y), assertz(Y), Y = 'end_of_file', write(Y), seen.

% 4.10 Recursion
print_square(I) :- I > 5, !.
print_square(I ):- S is I * I,
				   write(I), write(' '), write(S),nl,
				   NewI is I + 1,
				   print_square(NewI).
				   
% Exercisr 4.10.1
% count down
print_star(N) :- N = 0, !.
print_star(N) :- write('*'),				 
				 N1 is N - 1,
				 print_star(N1).

% Exercise 4.11 More about recursive loops
factorial(0,1) :- !.
factorial(N,R) :- N > 0,
				  N1 is N - 1,
				  factorial(N1,R1),
				  R is R1 * N.
% Tail Recursive
factorial(N,FactN) :- factorial_iter(N,FactN,0,1).
factorial_iter(N,FactN,N,FactN) :- !.
factorial_iter(N,FactN,I,J) :- I < N,
					          NewI is I + 1,
							  NewJ is J * New J,
							  factorial_iter(N,FactN,NewI,NewJ).
							  
% Exercise 4.11.1
% sum_iter/4, the last arg's initiaed value is J. Cuz J is the first num to be added.
sum(J,K,N) :- sum_iter(J,K,N,J).
sum_iter(J,J,N,N):- !.
sum_iter(J,K,N,N1) :- J < K,
					  NewJ is J + 1,
					  NewN1 is N1 + NewJ,
					  sum_iter(NewJ,K,N,NewN1).
					  
% Exercise 4.11.3
fib(1,1) :- !.
fib(2,1) : !.
fib(N,F) :- N > 2,
			N1 is N - 1, fib(N1,F1),
			N2 is N - 2, fib(N2,F2),
			F is F1 + F2.
			
fib2(N,F) :- N > 0, fib2_aux(N,F,0,1).
fib2_aux(1,F2,_,F2) :- !.
fib2_aux(N,F,F1,F2) :- NewF is F1 + F2,
					   NewN is N - 1,	
					   fib2_aux(NewN,F,F2,NewF).	

% Exercise 4.12 Organizing recursive code
% Step to write recursive code in Prolog
% 1. that it starts in the correct state;
% 2. that it finishes in the correct state;
% 3. it proceeds correctly from each state to the next
% It can terminate in two ways:
% 1. successfully execuing a nonrecursive clause
% 2. failing in the recursive clause prior to teh recursive call

% Exercise 4.12.1
even_length([]).
even_length([_,_|Rest]) :- even_length(Rest).

% Exercise 4.12.2
remove_duplicates([],[]):- !.
remove_duplicates([H|T],T1) :-  member(H,T),!,
								remove_duplicates(T,T1).
remove_duplicates([H|T],[H|T1]) :- remove_duplicates(T,T1).

% Exercise 4.12.3
member_in_common([],_,[]) :- !.
member_in_common([H|T],List2,[H|R1]) :- member(H,List2), !,
										member_in_common(T,List2,R1).
member_in_common([H|T],List2, R1)	 :- member_in_common(T,List2,R1).

%%% ?? Exercise 4.12.4
my_square_root(X,Y) :- 

%% Exercise 4.13 Why tail recursion is special
% A procedure that calls itself with an empty continuation and no backtrack points is described as Tail Recursive
