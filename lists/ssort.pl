% minimum element in a list
list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).

% private procedure with argument passing
list_min([], Min, Min).
list_min([H|Ls], Min0, Min) :-
    Min1 is min(H, Min0), list_min(Ls, Min1, Min).

% removes element from a list
% remove(X, L, R).
remove(_, [], []).
remove(X, [X|L], L).
remove(Y, [X|L], [X|L1]) :- Y \= X, remove(Y, L, L1).


% Selection Sort
ssort([], []).
ssort([M|S], L) :- list_min(L, M), remove(M, L, L1), ssort(S, L1).
