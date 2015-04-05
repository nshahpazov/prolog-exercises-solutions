% minimum element in a list
list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).

list_min([], Min, Min).
list_min([H|Ls], Min0, Min) :-
    Min1 is min(H, Min0), list_min(Ls, Min1, Min).

% remove
% remove(X, L, R).
remove(_, [], []).
remove(X, [X|L], L).

remove(X, [X|L], [X|L1]) :- remove(X, )


% Selection Sort

ssort([], []).
ssort([M|S], L) :- list_min(M, L), remove(M, L, L1), ssort(S, L1).
