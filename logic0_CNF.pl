/*---------------------------------------------------------------*/
/* Telecom Paristech - J-L. Dessalles 2020                       */
/* LOGIC AND KNOWLEDGE REPRESENTATION                            */
/*            http://teaching.dessalles.fr/LKR                   */
/*---------------------------------------------------------------*/



:-op(140, fy, -).        
:-op(160,xfy, [and, or, imp, impinv, nand, nor, nonimp, equiv, nonimpinv]).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Conjunctive normal form %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%


/* table for unary, alpha and beta formulas */

components(- -X, X, _, unary).
components(X and Y, X, Y, alpha).
components(-(X or Y), -X, -Y, alpha).
components(X or Y, X, Y, beta).
components(-(X and Y), -X, -Y, beta).
components(X imp Y, -X, Y, beta).
components(-(X imp Y), X, -Y, alpha).
components(X impinv Y, X, -Y, beta).
components(-(X impinv Y), -X, Y, alpha).
components(X nand Y, -X, -Y, beta).
components(-(X nand Y), X, Y, alpha).
components(X nor Y, -X, -Y, alpha).
components(-(X nor Y), X, Y, beta).
components(X nonimp Y, X, -Y, alpha).
components(-(X nonimp Y), -X, Y, beta).
components(X nonimpinv Y, -X, Y, alpha).
components(-(X nonimpinv Y), X, -Y, beta).


% Predicate cnf puts more elementary processing together
cnf(Conjunction, NewConjunction) :-
	oneStep(Conjunction, C1),
	cnf(C1, NewConjunction).
cnf(C, C).

% Predicate oneStep performs one elementary processing
oneStep([Clause | Rest_Conjonction], [ [F1, F2 | Rest_Clause] | Rest_Conjonction]) :-
	% looking for a beta formula in the clause
	%%% member(Beta_form,Clause),
	%%% components(Beta_form,F1,F2,beta).
	%%% remove(Beta_form, Clause, Rest_Clause),
	
	remove(Beta_form, Clause, Rest_Clause),
	components(Beta_form,F1,F2,beta).
oneStep([Clause | Rest_Conjonction], [ [F1 | Rest_Clause],[F2 | Rest_Clause] | Rest_Conjonction]) :-
	% looking for an alpha formula in the clause
	%%% member(Alpha_form,Clause),
	%%% components(Alpha_form,F1,F2,beta).
	%%% remove(Alpha_form, Clause, Rest_Clause),
	
	remove(Alpha_form, Clause, Rest_Clause),
	components(Alpha_form,F1,F2,alpha).
oneStep([Clause | Rest_Conjonction], [ [F1 | Rest_Clause] | Rest_Conjonction]) :-
	% looking for a double negative formula in the clause
	%%% member(Unary_form,Clause),
	%%% components(Unary_form,F1,F2,beta).
	%%% remove(Unary_form, Clause, Rest_Clause),
	
	remove(Unary_form, Clause, Rest_Clause),
	components(Unary_form,F1,_,unary).
oneStep([ F | Rest], [ F | New_Rest ]) :-
	% nothing left to do on F
	oneStep(Rest, New_Rest).

%Prove based on resolution
prove(F) :-
    cnf([[ -F ]], CNF),
    write('CNF of -'), write(F), write(' = '),
    write(CNF), nl,
    resolve(CNF).



/*------------------------------------------------*/
/* Auxiliary predicates                           */
/*------------------------------------------------*/

/* remove does as select, but removes all occurrences of X */
remove(X, L, NL) :-
    member(X,L),	% so that remove fails if X absent from L
    remove1(X, L, NL).
remove1(X, L, L) :-
    not(member(X,L)).
remove1(X, L, NL) :-
	select(X, L, L1),   % available in SWI-Prolog
	remove1(X, L1, NL).
	
resolve(CNF) :-
    member([ ], CNF),
	write('Examining '), write(CNF), nl,
    write('This is a true formula'), nl,
	!.
resolve(CNF) :-
    write('Examining '), write(CNF), nl,
    get0(_),    % waits for user action
    select(C1, CNF, _),            % forgetting this parent clause
    select(C2, CNF, RCNF),    % keeping this parent clause
	%write(C1),nl,
	%write(C2),nl,
	%write(RCNF),nl.
	append(C1,C2,Result),
	remove(P,Result,Rest),
	remove(-P,Rest,RRest),
	resolve([RRest | RCNF]).
	%remove(P,C1,RC1),
	%remove(-P,C2,RC2),
	%append(RC1,RC2,RC),
	%resolve([RC|RCNF]).

go :-
    prove( ((a imp (b imp c)) imp ((a imp b) imp (a imp c))) ).