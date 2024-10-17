ids(Limit, Plan) :-
    start(Start0),
    goal(Goal0),
    list_to_ord_set(Start0, Start),
    list_to_ord_set(Goal0, Goal),
    between(0, Limit, Len),
    length(Plan, Len),
    dfs(Start, Goal, [Start], Plan).

dfs(State, State, _Visited, Plan):-
    !,
    Plan = [].

dfs(State, Goal, Visited, [Action|Actions]):-
    action(Action, State, Next),
    not(member(Next, Visited)),
    dfs(Next, Goal, [Next|Visited], Actions).

block(X) :-
    member(X, [a, b, c, d]).


start([on(d, t),
       on(c, d),
       on(a, c),
       on(b, t),
       clear(a),
       clear(b)]).

goal([on(d, t),
      on(c, t),
      on(a, b),
      on(b, t),
      clear(a),
      clear(c),
      clear(d)]).

action(move(X,Y,Z), S1, S3):-
    member(clear(X), S1),
    member(on(X,Y), S1),
    block(Y),
    member(clear(Z), S1),
    X \= Z,
    ord_subtract(S1, [clear(Z), on(X,Y)], S2),
    ord_union([clear(Y), on(X,Z)], S2, S3).

action(move_onto_table(X,Y), S1, S3):-
    member(clear(X), S1),
    member(on(X,Y), S1),
    block(Y),
    ord_subtract(S1, [on(X,Y)], S2),
    ord_union([clear(Y), on(X,t)], S2, S3).

action(move_onto_block(X,Y), S1, S3):-
    member(clear(X), S1),
    member(clear(Y), S1),
    member(on(X,t), S1),
    X \= Y,
    ord_subtract(S1, [clear(Y), on(X,t)], S2),
    ord_union([on(X,Y)], S2, S3).