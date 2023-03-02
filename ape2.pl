%action(state(middle,onbox, X,not_holding), state(middle,onbox,X,holding), grab).
%action(state(X,floor,X,Y), state(X,onbox, X, Y), climb).
%action(state(X,floor,X,Z), state(Y,floor,Y,Z), push(X, Y)).
%action(state(X, floor, T, Z), state(Y,floor, T,Z), walk(X,Y)).

action(state(middle,on_box,X,not_holding), grasp, state(middle,on_box,X,holding)).
action(state(X,floor,X,Y), climb, state(X,on_box,X,Y)).
action(state(X,floor,X,Z), push(X,Y), state(Y,floor,Y,Z)).
action(state(X,floor,T,Z), walk(X,Y), state(Y,floor,T,Z)).


success1( state(_,_, _, holding), [ ]).
success1( State1, [Act | Plan]) :-
    action(State1, Act,State2),
    success1(State2,Plan).

ape :-
    success1(state(door,floor, window,not_holding), Plan),
    write(Plan).