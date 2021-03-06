% duplicates in packs
dupl_in_packs([], _, []).
dupl_in_packs([H|T], N, [H1|T1]) :- ns(H, N, H1), dupl_in_packs(T, N, T1).

% just duplicates the first element a given amount of times
dupl([], _, []).
dupl([H|T], N, R) :- append(X, Y, R), ns(H, N, X),
  dupl(T, N, Y).
