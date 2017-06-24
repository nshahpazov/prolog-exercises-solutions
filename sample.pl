append([], Ys, Ys).
append([X|Xs], Ys, [X|R]) :- append(Xs, Ys, R).
subset([], _).
subset(X, Y) :- not((member(Z, X), not(member(Z, Y)))).