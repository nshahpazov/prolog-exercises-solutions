est(0).
est(X):- est(X1), X is X1 + 1.

between(S, S, E):- S =< E.
between(X, S, E):- S1 is S + 1,
                   S < E,
                   between(X, S1, E).

accum([], _, 0).
accum([H|T], N, L):- L > 0,
                     between(H, 0, N),
                     L1 is L - 1,
                     accum(T, N, L1).

alllists([]).
alllists([])
alllists(X) :- est(N),
               between(L, 1, N),
               accum(X, N, L).