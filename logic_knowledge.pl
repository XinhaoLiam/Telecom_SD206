mirror2(Left, Right) :-
    invert(Left, [ ], Right).
invert([X|L1], L2, L3) :-    % the list is 'poured'
    invert(L1, [X|L2], L3).    % into the second argument
invert([ ], L, L).

palindrome(L1):-
	mirror2(L1,L1).

palindrome2(L1):-
	check(L1,[]).
check(L1,L1):-
	!.
check([_|L1],L1):-
	!.
check([X|L1],L2):-
	check(L1,[X|L2]).

empty(X):-
	retract(X),
	fail.
empty(_).

:- dynamic(found/1).
findany(Var,Pred,Results):-
	Pred,
	asserta(found(Var)),
	fail.
findany(_,_,Results):-
	collect_found(Results).
collect_found([X|Results]):-
	found(X),
	retract(found(X)),
	collect_found(Results),
	!.
collect_found([]).