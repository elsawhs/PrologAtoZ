% Chapter 2.7
% asserta: add clause to the begining
% assertz: add clause to the end
% retract: find the matching clause and remove it from the KB; it could either instantiated or uninstantiaed; If there is no match, it fails
% abolish: remove all the clauses for a particular predicate with a particular arity and succeeds whether or not any such clauses exist. 
% listing: see all the content in the knowledge base

% Exercise 2.7.2
:- dynamic(f/0).
test :- f, write('Not the first time').
test :- \+ f, asserta(f), write('The first time').
% If there is f clause in KB, do the first one, print out not the first time. If there is no, assert the f clause, but also print the first time