% sublists of duplicates
pack([], []).
pack([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z),
  pack(Ys, Zs).

% length encoding
% encode([a, a, a, a, b, c, c, c], X)
% X = [[4, a], [1, b], [3, c]].

% encode([], []).
encode(L1, L2) :- pack(L1, L), encounters(L, L2).

% takes the head of a list
single([], []).
single([H|_], H).

% encounters how many times a sublist has its duplicates
% for example [[a, a], [b ,b, b], X].
% X = [2, a], [3, b].
encounters([], []).
encounters([H1|T1], [[H2, Y]|T2]) :- length(H1, H2),
  single(H1, Y), encounters(T1, T2).

encode_modified(L1, L2) :- encode(L1, L), strip(L, L2).

% strips singles from lists of encounters
strip([], []).
strip([[1, X]|Ys], [X|Zs]) :- strip(Ys, Zs). % recursive
strip([[N, X]|Ys], [[N, X]| Zs]) :- N > 1, strip(Ys, Zs).

% decode run-length-encoding
% [[2, a], [1, z], [2, foo]]] -> [a, a, z, foo, foo]
decode([], []).
decode([[N, X]|Xs], Ys) :- ns(X, N, Y),
  append(Y, Gs, Ys), decode(Xs, Gs).
