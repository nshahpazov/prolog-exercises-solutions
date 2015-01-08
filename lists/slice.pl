% slice a list
% slice(L, S, E, R).
% slice([a, b, c, d, e, f, g, h, i, k], 3, 7, L).
% X = [c, d, e, f, g]
slice([], _, _, []).
slice(_, 0, 0, []).
slice([H|T1], 0, E, [H|T]) :- E1 is E - 1, slice(T1, 0, E1, T).
slice([H|T1], N, E, T) :- N > 0, N1 is N - 1,
  E1 is E - 1, slice(T1, N1, E1, T).
