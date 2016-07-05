% Ще казваме, че списък oт цифри [а1, а2, ..., аn] представлява числото, което е записано в десетична бройна система ижглежда така а1а2...аn. Например списъкът [1, 2, 3] представлява числото 123. Без да се използва аритметика на Пролог за числа по големи от 20, да се дефинира на пролог триместен предикат p(X, Y, Z), който по дадени списъци от цифри X и Y намира в Z представяне на сбора на числата, представени със списъците X и Y.

% reverses a digit into a list
reverseDigit(0, []).
reverseDigit(N, [H | Q]) :-
        N > 0,
        H is N mod 10,
        N1 is N div 10,
        reverseDigit(N1, Q).

addDigits(D1, D2, SD, SC) :-
    S is D1 + D2,
    (
      S >= 10, SD is S - 10, SC is 1;
      SD is S, SC is 0
    ).

sumDigits([], [], _, _).
sumDigits([H1|Q1], [H2|Q2], S, C) :-
    addDigits(H1, H2, SD, SC),
    sumDigits(Q1, Q2, S1, SC),
    S is SD + C + 10 * S1.

p(X, Y, Z) :- reverseDigit(X, X1),
              reverseDigit(Y, Y1),
              sumDigits(X1, Y1, Z, 0).