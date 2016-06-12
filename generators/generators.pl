% generate natular numbers
e(0).
e(N) :- e(M), N is M + 1.

% generate real numbers
z(X) :- e(E), member(Z, [-1, 1]),
  X is E * Z.

% generate a subsequence
betw(A, A, B) :- A =< B.
betw(X, A, B) :- A < B,
    A1 is A + 1, betw(X, A1, B).

/* between_(I,J,K) is true if K is an integer between I and J inclusive.    */
between_(I,J,I) :- I =< J.
between_(I,J,K) :- I < J, I1 is I+1, between_(I1,J,K).

fib(X) :- fib(X, _).
fib(0, 1).
fib(F2, F3) :- fib(F1, F2),
    F3 is F1 + F2.

% generate x =  x1^2 + x2^2 + x3^2 + x4^2
p(X) :-
        between(X1, 0, 32),
        between(X2, 0, 32),
        between(X3, 0, 32),
        between(X4, 0, 32),
        X is X1 + X2 + X3 + X4,
        X < 1000.

% generate the diffenent sums of a number
sums_(0, []).
sums_(N, [H|T]) :- betw(H, 1, N),
    M is N - H, sums_(M, T).

% all sublists
r([], []).
r(L, [H|T]) :- append(H, L, L1),
    H \= [], r(L1, T).


% generate all sublists of a list
subl([], []).

subl([First|Rest], [First|Sub]) :-
    subl(Rest, Sub).

subl([_|Rest], Sub) :-
    subl(Rest, Sub).




