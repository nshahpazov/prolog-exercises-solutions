% generate the fibonacci sequence
fibonacci(X) :- fibonacci(X, _).
fibonacci(0, 1).
fibonacci(F2, F3) :- fibonacci(F1, F2),
    F3 is F1 + F2.
