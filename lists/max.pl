max([X], X).
max([X|XS], X) :- max(XS, Y), X >= Y.
max([X|XS], N) :- max(XS, N), N > X.
