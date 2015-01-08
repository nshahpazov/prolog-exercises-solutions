% find the fibonnaci nth element
fibb(1, 0).
fibb(2, 1).

fibb(N, E) :- N >= 3,
  N1 is N - 1,
  N2 is N - 2,
  fibb(N1, E1), fibb(N2, E2),
  E is E1 + E2. % must be at the back because of the nesting  

% generate the fibonacci sequence
% not finished yet, not working right now
fib_seq(1, [0]).
fib_seq(2, [1, 0]).
fib_seq(N, [F2, F1, F0|L]) :-
  succ(N1, N),
  fib_seq(N1, [F1, F0|L]),
  plus(F0, F1, F2).

fib_sequence(N, R) :- 
  reverse(X, R),
  fib_seq(N, X).
