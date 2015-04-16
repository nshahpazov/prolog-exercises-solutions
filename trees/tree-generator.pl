% prolog tree generator
% t(X), write(X).

t(X) :- e(N), t(N, X).

t(0, []).

t(K, [A, B]) :- K1, K - 1, between(M, O, K1),
    N is K1 - M, t(M, A), t(N, B).
