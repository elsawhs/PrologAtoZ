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
				
							 
