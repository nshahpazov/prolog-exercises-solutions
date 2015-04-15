% drop nth elements
% ?- drop([a, b, c, d, e, f, g, h, i, k], 3, X).
% X = [a, b, d, e, g, h, k]

drop_([], _, _, R).
drop_([H|T], N, K, [H|R]) :- K mod N =\= 0, K1 is K + 1,
  drop_(T, N, K1, R).
drop_([_|T], N, K, R) :- K mod N =:= 0, K1 is K + 1,
  drop_(T, N, K1, R).
drop(L, N, R) :- drop_(L, N, 1, R).
