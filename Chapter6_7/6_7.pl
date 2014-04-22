% Nov.27 2012
% PPID 6.2~6.5

% Chapter 6.2 Collecting Alternative Solutions Into a List
employee('John Finnegan', 'secretary', 9500.00).
employee('Robert Marks', 'administrative assistant', 12000.00).
employee('Bill Knudsen', 'clerk-typist', 8250.00).
employee('Mary Jones', 'section manager', 32000.00).
employee('Alice Brewster', 'c.e.o', 1250000.00).

% Exercise 6.2.1
% 1 ?- findall(X,employee(X,_,_),L).
% L = ['John Finnegan', 'Robert Marks', 'Bill Knudsen', 'Mary Jones', 'Alice Brewster'].

% Exercise 6.2.2
sum([],0).
sum([X],X).
sum([H|T],Sum) :- sum(T,Sum1),
				  Sum is Sum1 + H, !.

count([],0).
count([_|T],Count) :- count(T,Count1),
					  Count is Count1 + 1.


average_salary(X) :- findall(S,employee(_,_,S),L),
					 sum(L,Sum),
					 count(L,Count),
					 X is Sum / Count.
% 5 ?- average_salary(X).
% X = 262350.0.					 

% Exercise 6.2.3
% 6 ?- findall([Name,Salary],employee(Name,_,Salary),L).
% L = [['John Finnegan', 9500.0], ['Robert Marks', 12000.0], ['Bill Knudsen', 8250.0], ['Mary Jones', 32000.0], ['Alice Brewster', 1250000.0]].

% Exercise 6.2.4
% 13 ?- findall([N,S],(employee(N,_,S),S > 10000),L).
% L = [['Robert Marks', 12000.0], ['Mary Jones', 32000.0], ['Alice Brewster', 1250000.0]].

% Section 6.3 using bagof AND setof
% bagof creates a bag in the form of a list containning all the solutions to a query
% setof does the same thing except that the list is sorted into alphabeical order and dupilicates are removed

% 19 ?- bagof(X,employee(X,Y,Z),L).
% Y = 'administrative assistant',
% Z = 12000.0,
% L = ['Robert Marks'] .

% 20 ?- bagof(X,Y^employee(X,Y,Z),L).
% Z = 12000.0,
% L = ['Robert Marks'] .					

% Exercise 6.3.1
% 22 ?- bagof(X,ancestor(X,cathy),L).
% L = [michael, melody, charles_gordon, charles, jim, elmo, hazel, eleanor].

% 23 ?- setof(X,ancestor(X,cathy),L).
% L = [charles, charles_gordon, eleanor, elmo, hazel, jim, melody, michael].

write_anc :- bagof((ancestor(X,Y)),ancestor(X,Y),L), write(L).

%  27 ?- write_ance.
% [ancestor(michael,cathy),ancestor(michael,sharon),ancestor(charles_gordon,michael),ancestor(charles_gordon,julie),ancestor(charles,charles_gordon),ancestor(
% jim,melody),ancestor(jim,crystal),ancestor(elmo,jim),ancestor(greg,stephanie),ancestor(greg,danielle),ancestor(melody,cathy),ancestor(melody,sharon),ancestor(
% hazel,michael),ancestor(hazel,julie),ancestor(eleanor,melody),ancestor(eleanor,crystal),ancestor(crystal,stephanie),ancestor(crystal,danielle),ancestor(
% charles_gordon,cathy),ancestor(charles_gordon,sharon),ancestor(charles,michael),ancestor(charles,julie),ancestor(charles,cathy),ancestor(charles,sharon)
% ,ancestor(jim,cathy),ancestor(jim,sharon),ancestor(jim,stephanie),ancestor(jim,danielle),ancestor(elmo,melody),ancestor(elmo,crystal),ancestor(elmo,cathy)
% ,ancestor(elmo,sharon),ancestor(elmo,stephanie),ancestor(elmo,danielle),ancestor(hazel,cathy),ancestor(hazel,sharon),ancestor(eleanor,cathy),ancestor(
% eleanor,sharon),ancestor(eleanor,stephanie),ancestor(eleanor,danielle)]
% true.


% 28 ?- setof(X,ancestor(X,_),L).
% L = [charles, charles_gordon, eleanor, elmo, hazel, jim, melody, michael] ;
% L = [charles] ;
% L = [eleanor, elmo, jim] ;
% L = [crystal, eleanor, elmo, greg, jim] ;
% L = [elmo] ;
% L = [charles, charles_gordon, hazel] ;
% L = [eleanor, elmo, jim] ;
% L = [charles, charles_gordon, hazel] ;
% L = [charles, charles_gordon, eleanor, elmo, hazel, jim, melody, michael] ;
% L = [crystal, eleanor, elmo, greg, jim].

% 30 ?- setof(X,ancestor(X,_),L),!.
% L = [charles, charles_gordon, eleanor, elmo, hazel, jim, melody, michael].

% Section 6.4 Finding the Smallest, Largest, or "Best" solution
age(cathy,8).
age(sharon,4).
age(aaron,3).
age(stephanie,7).
age(danielle,4).

% 37 ?- setof(A,N^age(N,A),L).
% L = [3, 4, 7, 8].

% 38 ?- setof(A,N^age(N,A),[Youngest|_]).
% Youngest = 3.

% 36 ?- age(Youngest,Age1),\+ (age(_,Age2),Age2 < Age1).
% Youngest = aaron,
% Age1 = 3 ;

% Exercise 6.4.1
% 39 ?- setof(N,A^age(N,A),[First|_]).
% First = aaron.

% Exercise 6.4.2
last_elt([],_).
last_elt([X],X).
last_elt([_|T],X) :- last_elt(T,X).

% 42 ?- setof(N,A^age(N,A),L),last_elt(L,X).
% L = [aaron, cathy, danielle, sharon, stephanie],
% X = stephanie ;
% L = [aaron, cathy, danielle, sharon, stephanie].

write_last(X) :- setof(N,A^age(N,A),L),
				 last_elt(L,X).
				 
% Exercise 6.4.3
% 45 ?- setof(N+A,N^age(N,A),L).
% L = [aaron+3, cathy+8, danielle+4, sharon+4, stephanie+7].

% 46 ?- setof(N+A,age(N,A),L).
% L = [aaron+3, cathy+8, danielle+4, sharon+4, stephanie+7].

% 47 ?- setof(N+A,A^age(N,A),L).
% L = [aaron+3, cathy+8, danielle+4, sharon+4, stephanie+7].		

% Exercise 6.4.4
find_six(H):- setof([N,A],(age(N,A), Diff is abs(6-A)),[H|_]),!.
% 51 ?- setof([N,A],(age(N,A),Diff is abs(6-A)),L).
% Diff = 1,
% L = [[stephanie, 7]] ;
% Diff = 2,
% L = [[cathy, 8], [danielle, 4], [sharon, 4]] ;
% Diff = 3,
% L = [[aaron, 3]].

% Exercise 6.4.5
logical_find_six(X) :- age(X,Age1), 
					   \+ (age(_,Age2),
					   Diff1 is abs(6-Age1), Diff2 is abs(6-Age2), 
					   Diff1 < Diff2).
% Exercise 6.4.6
logical_find_six_test(X) :- age(X,Age1), 
							\+ (age(_,Age2),
							Diff1 is abs(6-Age1), Diff2 is abs(6-Age2), 
							Diff1 < Diff2),
							statistics.
find_six_test(H):- setof([N,A],(age(N,A), Diff is abs(6-A)),[H|_]),!, statistics.						

% Pretty much the same on this KB

% Exercise 6.5 Intensional and Extensional Queries

% for_all(GoalA,GoalB).
for_all(GoalA,GoalB) :- \+ (call(GoalA), \+ call(GoalB)),
						call(GoalA),
						!.

dog(fido).
dog(rover).
dog(X):- bulldog(X).

bulldog(bucephalus).
animal(X) :- dog(X).
animal(felix).


% 68 ?- for_all(dog(X),animal(X)).
% X = fido.
% 69 ?- for_all(dog(X),animal(X)).
% X = fido.
% 70 ?- for_all(animal(X),dog(X)).
% false.
% 71 ?- for_all(bulldog(X),animal(X)).
% X = bucephalus.
% 72 ?- for_all(dog(X),bulldog(X)).
% false.

% Section 7.1 Structures as trees
% Section 7.2 Lists as structures
% Every list consists of an element plus another list or [].

% Section 7.3 How to search or process any structure
 :- consult('rewrite.pl').

 % Exercise 7.3.1
 
