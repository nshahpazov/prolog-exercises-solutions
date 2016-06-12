% generates a list of numbers in range of M with length N
random_select(0, _, []).
random_select(N, M, [X|R]) :- N > 0, N1 is N - 1,
  random_between(1, M, X),
  random_select(N1, M, R).
