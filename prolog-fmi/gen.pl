n(1).
n(N) :- n(N1), N is N1 + 1.

between(A, A, B) :- A =< B.
between(A, X, B) :- A < B, A1 is A + 1, between(A1, X, B).

pitagor(A, B, C) :- n(N), 
                    between(1, A, N),
                    between(A, B, N),
                    between(B, C, N),
                    C2 is C*C,
                    C2 is A*A + B*B.

fib(1, 1).
fib(1, 2).
fib(F, N) :- N > 2,
             N2 is N - 2,
             N1 is N - 1,
             fib(F2, N2),
             fib(F1, N1),
             F is F1 + F2.

fib(F) :- n(N), fib(F, N).

spl([], []).
spl(L, [A|R]) :- cnct(A, B, L), A \= [], spl(B, R).

list1([1]).
list1([1|L]) :- list1(L).

fib1(1, 1).
fib1(B, C) :- fib1(A, B), C is A + B.

fib1(F) :- fib1(F, _).

d(0, []).
d(N, [X|T]) :- between(1, X, N), N1 is N - X, d(N1, T).

