%%%%%%%%%%% Write a clause to define the predicate aunt.
%aunt(X,Y):-
%	parent(A,Y),
%	sister(X,A).

% Write last_elt that extracts the last element of a list.
last_elt([X],X).
last_elt([_|L1],X):-
	last_elt(L1,X).

% Write attach that joins two lists.
attach([],L2,L2).
attach([X|L],L2,[X|R]):-	
	attach(L,L2,R).
	
% Use attach (previously written) to design assemble that joins three lists.
assemble(L1,L2,L3,R):-
	attach(L1,L2,R1),
	attach(R1,L3,R).
%% Not revertible, end in an infinite recursion.

% Use attach to write sub_list
sub_list(L1,[X|L]):-
	attach(L1,_,[X|L]);
	sub_list(L1,L).

% Writing remove, that removes all occurrences of an element in a list
remove(_,[],[]).
remove(X,[X|L],R):-
	remove(X,L,R),
	!.
remove(X,[Y|L],[Y|R]):-
	remove(X,L,R).
	
removea(X, [X|L], L1) :-
	!,
    removea(X, L, L1).
removea(X, [Y|L], [Y|L1]) :-
    removea(X, L, L1).
removea(_, [ ], [ ]).
	
% Write duplicate to duplicate each element in a list
duplicate([],[]).
duplicate([X|L],[X,X|R]):-
	duplicate(L,R).