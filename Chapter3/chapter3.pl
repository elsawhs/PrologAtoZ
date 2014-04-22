% Chapter 3

% Section 3.1
% Exercise 3.1.2

% ?- X is 234+(567.8*3)-0.0001.
% X is 1937.3999.
% ?- X is abs(5-6).
% X is 1.
% ?- pow(9,3,A), X is A mod 12.
% A = 729,
% X = 9.

% Define a pre do power in Prolog
power(_,0,1).
power(X,Y,Z) :- Y1 is Y-1,
				power(X,Y1,Z1),
				Z is Z1 * X.
				
% Exercise 3.2.1
% ?- 5 = 2+3. False. Because = is unifies two terms. Before evaluated, 2+3 is a data structure which is not 5. 

% Exercise 3.2.2
% ?- 4 is sqrt(16). False. 4.0 is sqrt(16).

% Section 3.3 Practical Caculation
close_enough(X,Y) :- abs(X-Y) < 0.0001.

% Exercise 3.3.3
close_enough1(X,Y) :- X < Y,
					  D is Y - X,
					  D < 0.9 * Y.
close_enough1(X,Y) :- close_enough1(Y,X).

% Section 3.4
real_square_root(X, nonexistent) :- nonvar(X),
									X < 0.0.
real_square_root(X,Y) :- nonvar(X),
						 var(Y),
						 X >= 0.0,
						 R is sqrt(X),
						 close_enough(R,Y).

real_square_root(X,Y) :- nonvar(X),
						 var(Y),
						 X > 0.0,
						 R is -sqrt(X),
						 close_enough(R,Y).

real_square_root(X,Y) :- nonvar(Y),
						 var(X),
						 Ysquared is Y*Y,
						 close_enough(Ysquared,X).


% Exercise 3.4.3
sum(X,Y,Z) :- var(Z),
			  Z is X + Y.
sum(X,Y,Z) :- var(X),
			  X is Z - Y.
sum(X,Y,Z) :- var(Y),
			  Y is Z - X.

% Exercise 3.4.4
ohm(E,I,R) :- nonvar(I),
			  nonvar(R),
			  var(E),
			  E is I * R.
ohm(E,I,R) :- nonvar(E),
			  nonvar(R),
			  var(I),
			  I is E / R.
ohm(E,I,R) :- nonvar(I),
			  nonvar(E),
			  var(R),
			  R is E / I.

% Exercise 3.5
third_elt([_,_,X|_],X).

% Exercise 3.5.1
first_two_same([X,X|_]).

% Exercise 3.5.2
swap_first_two([X,Y|_],[Y,X|_]).

% Exercise 3.6
display_degrees([_,Degree|_],Degree).

% Section 3.7 Recursion
member(X,[X|_]).
member(X,[_|Ytail]) :- member(X,Ytail).

% Section 3.8 List Elements

% Count the element in the list
list_length([],0).
list_length([_|Tail],K) :- list(Tail,J),
						   K is J + 1.
						   
% Exercise 3.8.1
count_occ(_,[],0).
count_occ(X,[_|T],N) :- count_occ(X,T,K),
						N is K + 1.
						
% Solution with three predicates
count_occ3(_,[],0).
count_occ3(X,[X|T],N) :- count_occ3(X,T,K),
						N is K + 1.
count_occ3(X,[Y|T],N) :- \+ X = Y,
						count_occ3(X,T,N).

% Exercise 3.8.2
last_element([E],E).
last_element([_|T],E) :- last_element(T,E).

% Section 3.9 Append
append([],X,X).
append([X1|X2],Y,[X1|Z]) :- append(X2,Y,Z).

% Exercise 3.9.1
% 5 ?- append([J,b,K],[d,L,f],[a,M,c,N,e,P]).
% J = a, K = c, L = e, M = b, N = d, P = f

% Exercise 3.9.2
append3([],[],[],[]).
append3(L1,L2,L3,Result) :- append(L2,L3,TempResult),
						    append(L1,TempResult,Result).

% Exercise 3.9.3 Flatten/2
app([],X,X).
app([X1|X2],Y,[X1|Z]) :- append(X2,Y,Z).

% My solution for flatten a list
% Have problems when backtracking
flatt([H|T],Result) :- H = [_|_], flatt(H,H1),
						flatt(T,T1),
						app(H1,T1,Result).
flatt([H|T],[H|T1]) :- \+ H = [_|_],
						flatt(T,T1).
flatt([],[]).


flattenl([],[]).
flattenl(X,Z) :- atom(X), \+ X = [], Z = [X].
flattenl([Head|Tail],Z) :- flattenl(Tail,X1), flattenl(Head,X2), append(X2,X1,Z).


% Dr.Covington's solution
listp([]).
listp([_|_]).

% List is empty
flat([],[]).
% First elt is not a list. F is not a list.
flat([F|R],[F|FR]) :- \+ listp(F),
					  flat(R,FR).
% First elt is a list
flat([F|R],Result) :- listp(F), flat(F,FF),
					  flat(R,FR),
					  append(FF,FR,Result).
						     
% Section 3.10 Reversing a List recursively
% NREV 
reverse([],[]).
reverse([H|T],Result) :- reverse(T,R1),
						 append(R1,[H],Result).
% Exercise 3.10.1
reverse_print([],[]).
reverse_print([H|T],Result) :- reverse_print(T,R1),
							    write('The Reversed Tail is '), write(R1),nl,
								append(R1,[H],Result).
% Exercise 3.10.3
% 1. Dosen't backtracking
% 2. Is a Listp speed test
						
% Section 3.11 Fast Reverse
fast_reverse(List, Result) :- nonvar(List),
							  fast_reverse_aux(List,[],Result).
fast_reverse_aux([],Result,Result).
fast_reverse_aux([H|T],Temp,Result) :- fast_reverse_aux(T,[H|Temp],Result).

% Section 3.12 Character String

write_str([H|T]) :- put(H),
					write_str(T).
write_str([]).

% Exercise 3.12.1
print_splits([H|T]) :- write(' '),write_str([H|T]),nl, print_splits_aux(T,[H]),!.
print_splits_aux([],String):- write_str(String),write(' ').
print_splits_aux([H|T], Result) :- write_str(Result), write(' '),write_str([H|T]),nl,
									append(Result,[H],X), print_splits_aux(T,X),!.

%  Exercise 3.12.2
end_in_s(List) :- last_element(List,X), X==115.

% Chapter 3.13
% read_str(String).
% Accepts a whole line of input as a sting (list of ASCII codes).
% Assumes that the keyboard is buffered.
read_str(String) :- get0(Char),
					read_str_aux(Char,String).
read_str_aux(-1,[]) :- !.
read_str_aux(10,[]) :- !.
read_str_aux(13,[]) :- !.
read_str_aux(Char,[Char|Rest]) :- read_str(Rest).

% read_atom(Atom)
% Accepts a whole line of input as a single atom
read_atom(Atom) :- read(Atom), name(Atom,String).

% Exercise 3.13.2
%% ?- name(What, "3.1416").
%% It's a number, 3.1416.

% Exercise 3.13.3
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
% Exercise 3.13.4
read_str_no_blanks(String):- get0(Char), 
							 read_str_no_blanks_aux(Char,String).
							 
read_str_no_blanks_aux(-1,[]):- !.
read_str_no_blanks_aux(10,[]):- !.
read_str_no_blanks_aux(13,[]):- !.
read_str_no_blanks_aux(Char,[Char|Rest]) :- \+ Char == 32, read_str_no_blanks(Rest).
read_str_no_blanks_aux(Char,Rest) :- 	Char == 32,
										read_str_no_blanks(Rest).


% Chapter 3.14 Structure
% '=..' make list and strcture interconvertible

% Two built-in predicates
% functor(S,Functor,Arity) unifies F and A with the functor and arity,respectively, of structures S. Recall that the arity of a structure is its numbers of arguments
% ?-functor(a(b,c),X,Y).
% X = a,
% Y = 2.
% arg(N,S,X) unifies X with the Nth arguments of structure S.
% ?- arg(2,a(b,c,d),What).
% What = c.

% Exercise 3.14.1
reverse_arg(S,Result) :- S=..[H|T], reverse(T,RevT), Result=..[H|RevT].
% ?- rev_arg(x(y,z,w),X).
% X=x(w,z,y).

% Exercise 3.14.2
% Structure has to be instantiated

% Exercise 3.14.3
last_arg(S,A) :- S=..List, last_element(List,A).

% Chapter 3.15
% built-in predicate 
% unify_with_occurs_check(X,f(X)). no.
% unify_with_occurs_check(X,f(a)). X = f(a).

% Exercise 3.15.1
% 43 ?- X=Y,Y=X.
% X = Y.
% 44 ?- X=f(Y),Y=X.
% X = Y, Y = f(Y).
% 45 ?- X=f(Y),Y=f(X).
% X = Y, Y = f(f(Y)).
% 46 ?- X=f(Y),Y=f(Z),Z=a.
% X = f(f(a)),
% Y = f(a),
% Z = a.

% Exercise 3.16 Constructing Goals at Runtime
% built-in predicate call 
% apply(Functor,Arglist)
% Costructs and executes a query
apply(Functor,Arglist) :- Query =.. [Functor|Arglist],
						  call(Query).

% Exercise 3.16.2
answer_question1 :- write('Mother or Father? '),
				   read_atom(X),
				   write('Of whom? '),
				   read_atom(Y),
				   apply(X,[Who,Y]),
				   write(Who),
				   nl.

% Exercise 3.16.3
% Small Project
map(Functor,[],[]).
map(Functor,[Hs|Ts],Result) :- apply(Functor,[Hs,T1]),
							   map(Functor,Ts,T2),
							   append([T1],T2,Result).

% Exercise 3.17 
% count(X).
% Unifes X with the number of times count/1 has been called.
count(X) :- retract(count_aux(X)),
			X is N + 1,
			asserta(count_aux(X)).
:- dynamic(count_aux/1).
count_aux(0).

% Exercise 3.17.1
gensym(What) :- retract(count_aux1(N)),
				X is N + 1,
				X =< 122,		
				asserta(count_aux1(X)),
				name(What,[X]).
:- dynamic(count_aux1/1).
count_aux1(96).

%% 
