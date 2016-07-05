% rotate a list to the left (uses split procedure)
% rotate([1, 2, 3, 4, 5], -2, R).
% R = [4, 5, 1, 2, 3].
rotate([], _, []).
rotate(L, N, R) :- length(L, N2), N1 is N2 + N,
  append(Y, X, R), split(L, N1, X, Y).

% another way of doing it is using split
rotate(Xs, N, Rs) :- split(Xs, N, Ys, Zs), append(Zs, Ys, Rs).