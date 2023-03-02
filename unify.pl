s--> np(FS1),vp([subj:FS2|_]),{unify(FS1,FS2)}.
np(FS) --> det(FS), n(FS).
vp(FS) --> v(FS).

n([number:sing, person:3, gender:feminine, sentience:true]) --> [mary].
n([number:sing, person:3, gender:_, sentience:true]) --> [dog].
n([number:plur, person:3, gender:neutral, sentience:false]) --> [apples].

det([number:_, person:3, gender:_, sentience:_]) --> [the].

v([subj:[number:sing, person:3, gender:_, sentience:true], event:false]) --> [thinks].
v([subj:[number:sing, person:3, gender:_, sentience:_], event:true]) --> [falls].

unify(FS, FS) :- !. % Let Prolog do the job if it can

unify([ Feature | R1 ], FS) :-
    select(Feature, FS, FS1), % checks whether the Feature is in the list
    !, % the feature has been found
    unify(R1, FS1).
	
go :-
	A = [sentience:true, number:sing, person:3, gender:feminine |_],
	B = [person:3, number:sing | _],
	unify(A,B).