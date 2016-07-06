% remove an element from a list
remove([], _, []).
remove([X|XS], X, XS).
remove([X|XS], Y, [X|KS]) :- Y \= X, remove(XS, Y, KS).

% not exactly what I had in mind
combination(_, 0, []).
combination(L, N, [R|Rs]) :- N > 0,
                             N1 is N - 1,
                             member(R, L),
                             remove(L, R, L2),
                             combination(L2, N1, Rs).
% p99 way
combination2(0, _, []).
combination2(K, L, [X|Xs]) :- K > 0,
                              el(X, L, R),
                              K1 is K - 1,
                              combination2(K1, R, Xs).

% Find out what the following predicate el/3 exactly does.
el(X, [X|L], L).
el(X, [_|L], R) :- el(X, L, R).