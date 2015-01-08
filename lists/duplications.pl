% transfer(X, Xs, Ys, Z)
transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- X \= Y.
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).

% duplicates an element k times
ns(_, 0, []).
ns(H, K, [H|T]) :- K > 0, K1 is K - 1, ns(H, K1, T).

% duplicates in packs
dupl_in_packs([], _, []).
dupl_in_packs([H|T], N, [H1|T1]) :- ns(H, N, H1), dupl_in_packs(T, N, T1).

% just duplicates the first element a given amount of times
dupl([], _, []).
dupl([H|T], N, R) :- append(X, Y, R), ns(H, N, X),
  dupl(T, N, Y).
