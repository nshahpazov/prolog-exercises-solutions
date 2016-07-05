get_at([X|_], 1, X).
get_at([_|Xs], N, R) :- N > 1,
                  N1 is N - 1,
                  get_at(Xs, N1, R).
