revDigits(0, []).
revDigits(N, [H | Q]) :- N > 0, H is N mod 10, N1 is N div 10, revDigits(N1, Q).

addDigits(D1, D2, SD, SC) :-
    S is D1 + D2, (S >= 10, SD is S - 10, SC is 1; SD is S, SC is 0).

sumDigits([], [], C, C).
sumDigits([H1 | Q1], [H2 | Q2], S, C) :-
    addDigits(H1, H2, SD, SC), sumDigits(Q1, Q2, S1, SC), S is SD + C + 10 * S1.

p(X, Y, Z) :- revDigits(X, XL), revDigits(Y, YL), sumDigits(XL, YL, Z, 0).
