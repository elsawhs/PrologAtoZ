% Facts
male(xincheng).
male(shiliang).
male(zhiyi).
male(yulu).
male(yuren).
male(chuan).
male(lund).

female(gma).
female(wuqian).
female(yunqiu).
female(qin).
female(hong).
female(zhongyi).
female(youyi).
female(na).
female(sha).

parent(gma,qin).
parent(gma,hong).
parent(shiliang,qin).
parent(shiliang,hong).
parent(shiliang,shengting).
parent(wuqian,shengting).
parent(xincheng,zhongyi).
parent(xincheng,youyi).
parent(xincheng,zhiyi).
parent(yunqiu,zhongyi).
parent(yunqiu,youyi).
parent(yunqiu,zhiyi).
parent(zhongyi,chuan).
parent(yulu,chuan).
parent(youyi,lund).
parent(yuren,lund).
parent(zhiyi,sha).
parent(qin,sha).

married(shiliang,wuqian).
married(xincheng,yunqiu).
married(zhiyi,qin).
married(zhongyi,yulu).
married(youyi,yuren).
married(chuan,na).

% Exercise1.8.2
mother(M,X) :- female(M), parent(M,X).
father(F,X) :- male(F), parent(F,X).

% Exercise 1.9.1
grandparent(G,X) :- parent(G,Y), parent(Y,X).

grandfather(Gf,X) :- male(Gf), grandparent(Gf,X).
grandmother(Gm,X) :- female(Gm), grandparent(Gm,X).

% Exercise 1.10.1
:- GEO.pl
eastern(X) :- located_in(X,georgia).
eastern(X) :- located_in(X,ontario).

% Exercise 1.10.2
f(X) :- a(X), b(X).
f(X) :- c(X), d(X).

% Exercise 1.11.1
non_grandparent(G,X) :- \+ non_parent(G,Y), parent(Y,X).
non_grandparent(G,X) :- parent(G,Y), \+ parent(Y,X).
non_grandparent(G,X) :- \+ parent(G,Y), \+ parent(Y,X).
			
			
non_grandparent1(G,X) :- \+ grandparent(G,X).

non_grandparent2(G,X) :- \+ grandfather(G,X),  \+ grandmother(G,X).
						 
						 
% Exercise 1.11.2
young_parent(X) :- parent(X,C), \+ grandparent(X,Gc).
				   
% Chapter 1.12
sibling(X,Y) :- parent(P,X), parent(P,Y), \+ X==Y.

only_child(X) :- mother(M,X), \+ (mother(M,Y), \+ X==Y).

% Exercise 1.12.4
brother(B,X) :- male(B), sibling(B,X).
sister(S,X) :- female(S), sibling(S,X).
uncle(U,X) :- male(U), parent(P,X),sibling(U,P).
uncle(U,X) :- aunt(A,X),married(A,U), male(U).
aunt(A,X) :- female(A), parent(P,X), sibling(A,P).
aunt(A,X) :- uncle(U,X),married(U,A), female(A).


% Exercise 1.16
info(sha,'C10, 101 Davis St').
info(qin,'4-3-804,Jianshe Nan Rd').
info(eli,'Sha heart').

% ounsin
cousin(C,X) :- parent(Px,X), parent(Pc,C), sibling(Px,Pc).

