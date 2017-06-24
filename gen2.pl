genAll([]).
genAll(L) :- nat(N),
             between(1, N, K),
             S is N - K,
             genS(K, S, L).

genS(1, S, [S]).
genS(K, S, [X|Xs]):- K > 1,
                     between(0, S, X),
                     S1 is S - X,
                     K1 is K - 1,
                     genS(K1, S1, Xs).

between(A, B, A) :- A =< B.
between(A, B, X):- A < B,
                   A1 is A + 1,
                   between(A1, B, X).

nat(0).
nat(X):- nat(Y), X is Y+1.