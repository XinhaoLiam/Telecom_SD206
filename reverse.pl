reversel([],A,A).
reversel([X|L1],A,R):-
	reversel(L1,[X|A],R).
reversel(L,R):-
	reversel(L,[],R).

insert(X,L,R,N):-
	insert(X,L,[],R,N).
insert(X,L,A,R,0):-
	reversel(A,A1),
	append(A1,[X|L],R).
insert(X,[Y|L1],A,R,N):-
	N1 is N-1,
	insert(X,L1,[Y|A],R,N1).