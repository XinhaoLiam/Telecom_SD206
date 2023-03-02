/*---------------------------------------------------------------*/
/* Telecom Paristech - J-L. Dessalles 2020                       */
/* LOGIC AND KNOWLEDGE REPRESENTATION                            */
/*            http://teaching.dessalles.fr/LKR                   */
/*---------------------------------------------------------------*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% explanation_based generalization %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



/*-----------------------*/
/*  Background knowledge */
/*-----------------------*/
telephone(T) :- connected(T), partOf(T, D), dialingDevice(D), emitsSound(T).
connected(X) :- hasWire(X, W), attached(W, wall).
connected(X) :- features(X, bluetooth).
connected(X) :- features(X, wifi).
connected(X) :- partOf(X, A), antenna(A), hasProtocol(X, gsm).
dialingDevice(DD) :- rotaryDial(DD). 
dialingDevice(DD) :- frequencyDial(DD).
dialingDevice(DD) :- touchScreen(DD), hasSoftware(DD, DS), dialingSoftware(DS).
emitsSound(P) :-    hasHP(P).
emitsSound(P) :-    features(P, bluetooth).

/*---------*/
/* Example */
/*---------*/
example(myphone, Features) :-
    Features = [silver(myphone), belongs(myphone, jld), partOf(myphone, tc),
                touchScreen(tc), partOf(myphone, a), antenna(a),
                hasSoftware(tc, s1), game(s1),
                hasSoftware(tc, s2), dialingSoftware(s2),
                features(myphone,wifi), features(myphone,bluetooth),
                hasProtocol(myphone, gsm), beautiful(myphone)].


/*-------------------*/
/* Prover without trace */
/*-------------------*/
prove((G,Q),Trace) :-		% forms like (H,T) are returned by 'clause' (see below)
    !,
    prove(G,T1),
    prove(Q,T2),
	append(T1,T2,Trace).
	%Trace = NTrace.
prove(true,_) :-
    !.
prove(G,[G]) :-
    known(G),
    write('\t'), write(G), write(' is known'), nl.
prove(G,Trace) :-
    write('attempting to prove '),write(G),nl,
    clause(G,Q),	% Q may have the following form: (H,T) (where T may be also like Q)
    prove(Q,Trace),
    write(G), write(' has been proven'), nl.


/*------*/
/* Test */
/*------*/
ebgTest :-
    retractall(known(_)),
    example(M, F),
    assertL(F),
    prove(telephone(M),Trace),
	write(Trace).

assertL([F|Fs]) :-
    assert(known(F)),
    assertL(Fs).
assertL([]).

