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

%%%%%%% Exercise 3.13.3
%%%%%%% Exercise 3.13.4

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
gensym(X) :- retract(count_aux1(X)),
			 X is N + 1,
			 X =< 122,
			 asserta(count_aux1(X)),
			 name(What,[X]).
:- dynamic(count_aux1/1).
count_aux1(0).
