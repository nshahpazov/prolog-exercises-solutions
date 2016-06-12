% extract a given number of randomly selected elements
% for now its not a sublist of unique elements... must be :)
rand_sublist(_, 0, []).
rand_sublist(T, N, [X|M]) :- N > 0, N1 is N - 1,
  len(T, L),
  random_between(1, L, RAND),
  kth(X, T, RAND),
  rand_sublist(T, N1, M).
