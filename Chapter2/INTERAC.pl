% File INTERACT.PL
% Simple interactive program

capital_of(georgia,atlanta).
capital_of(florida,tallahassee).

go:- write('What state do you want to know about?'),nl,
	 write('Type its name, all lower case, followed by a period.'),nl,
	 read(State),
	 capital_of(State,City),
	 write('Its capital is: '), write(City),nl.
