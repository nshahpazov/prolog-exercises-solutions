% remove at index
% ?- remove_at(X,[a, b, c, d], 2, R).
% X = b
% R = [a, c, d]

% rem(L, K, R).
remove_at([], _, []).
remove_at([H|T1], 0, R) :- remove_at(T1, -1, R).
remove_at([H|T], N, [H|R]) :- N \= 0, N1 is N - 1,
  remove_at(T, N1, R).

% ?- insert_at(alfa,[a,b,c,d],2,L).
% L = [a, alfa, b, c, d]
% insert at a given position
insert_at([], X, _, [X]).
insert_at(T, H, 0, [H|T]).
insert_at([X|Xs], Y, N, [X|Zs]) :- N > 0, N1 is N - 1,
  insert_at(Xs, Y, N1, Zs).

