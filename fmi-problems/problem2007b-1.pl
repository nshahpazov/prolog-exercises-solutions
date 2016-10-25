table(A, B, []) :- A >= B.
table(A, B, X) :- X = [A | X1], A1 is A + 1, table(A1, B, X1).

specialproduct([], 1).
specialproduct([H | Q], P) :- specialproduct(Q, P1), append([F | _], [PU, L], H),
    (PU < F, PU > L, P is P1 * PU; P is P1).

p(X, Y) :- specialproduct(X, P), table(0, P, Y).
