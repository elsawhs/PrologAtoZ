% File GEO.PL
% Sample geographical knowledge base

located_in(atlanta,georgia).
located_in(houston,texas).
located_in(austin,texas).
located_in(toronto,ontario).
loacted_in(X,usa) :- located_in(X,georgia).
located_in(X,usa) :- located_in(X,texas).
located_in(X,canada) :- located_in(X,ontario).
located_in(X,north_america) :- located_in(X,usa).
located_in(X,north_america) :- located_in(X,canada).


% File Family.PL
% Part of a family tree expressed in Prolog



% In father/2, mother/2 and parent/2.
% first arg. is parent and second arg. is child

father(michael, cathy).
father(michael,sharon).
father(charles_gordon,michael).
father(charles_gordon,julie).
father(charles,charles_gordon).
father(jim, melody).
father(jim, crystal).
father(elmo,jim).
father(greg,stephanie).
father(greg,danielle).

mother(melody,cathy).
mother(melody,sharon).
mother(hazel,michael).
mother(hazel,julie).
mother(eleanor,melody).
mother(eleanor,crystal).
mother(crystal,stephanie).
mother(crystal,danielle).

parent(X,Y) :- father(X,Y).
parent(X,Y) :- mother(X,Y).

blue_eyed(cathy).

blue_eyed_non_grandparent(X) :- blue_eyed(X),
								\+ parent(X,Y), parent(Y,Z)).

sibling(X,Y) :- mother(M,X),
				mother(M,Y),
				\+ X == Y.
				


% Exercise 1.8.1
% 
% 1 ?- parent(X,danielle).
% X = greg ;
% X = crystal.

% Exercise 1.8.2
% Modification of Family.pl


% Exercise 1.9.1
grandfather(X,Z) :- father(X,Y),
					father(Y,Z).
grandfather(X,Z) :- father(X,Y),
					mother(Y,Z).
grandparent(X,Z) :- parent(X,Y),
					parent(Y,Z).
					
% Exercise 1.10.1
eastern(X) :- located_in(X,georgia); located_in(X,ontario).
eastern(X) :- located_in(X,georgia).
eastern(X) :- located_in(X,ontario).

% Exercise 1.10.2
% f(X) :- (a(X),b(X)); (c(X),d(X)).
f(X) :- a(X),
		b(X).
f(X) :- c(X),
		d(X).


% Exercise 1.11.1
non_grandparent(X,Y) :- \+ grandparent(X,Y).

% Exercise 1.11.2
young_parent(X) :- parent(X,Y),
				   \+ parent(Y,_).


uncle(X,Y) :- sibling(X,M),
			  mother(M,Y),
			  male(X).
			 
ancestor(A,B) :- parent(A,B).
ancestor(A,C) :- parent(A,B),
				 ancestor(B,C).














