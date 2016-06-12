min([L|Ls], Min) :-
    min(Ls, L, Min).

% private procedure with argument passing
min([], Min, Min).
min([H|Ls], Min0, Min) :-
    Min1 is min(H, Min0), min(Ls, Min1, Min).
