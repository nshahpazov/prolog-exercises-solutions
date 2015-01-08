% finds out whether an element is in a list
member(H, [H|T]). % bottom rule
member(X, [H|T]) :- member(X, T).

% removes duplicates from a list
% can be optimized with H|T and without append and without if
set([], []).
set([H|T], [H|R]) :- not(member(H, T)), set(T, R).
set([H|T], R) :- member(H, T), set(T, R).

% removes consequetive duplicates
compress([], []).
compress([X], [X]).
compress([X, X|Xs], Zs) :- compress([X|Xs], Zs).
compress([X, Y|Ys], [X|Zs]) :- X \= Y, compress([Y|Ys], Zs).
