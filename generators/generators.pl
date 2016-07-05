% generate x =  x1^2 + x2^2 + x3^2 + x4^2
p(X) :-
        between(X1, 0, 32),
        between(X2, 0, 32),
        between(X3, 0, 32),
        between(X4, 0, 32),
        X is X1 + X2 + X3 + X4,
        X < 1000.

% generate the diffenent sums of a number
sums_(0, []).
sums_(N, [H|T]) :- betw(H, 1, N),
    M is N - H, sums_(M, T).

% all sublists
r([], []).
r(L, [H|T]) :- append(H, L, L1),
    H \= [], r(L1, T).


% generate all sublists of a list
subl([], []).

subl([First|Rest], [First|Sub]) :-
    subl(Rest, Sub).

subl([_|Rest], Sub) :-
    subl(Rest, Sub).
