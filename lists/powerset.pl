sub([], []).
sub([_|Xs], R) :- sub(Xs, R).
sub([X|Xs], [X|R]) :- sub(Xs, R).

prof(_, [], []).
prof(X, [L|Ls], [[X|L]|R]) :- prof(X, Ls, R).

ps([], [[]]).
ps([X|Xs], P) :- ps(Xs, P1), prof(X, P1, P2), append(P1, P2, P).