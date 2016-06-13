% duplicates an element n times
times(_, 0, []).
times(H, N, [H|T]) :- N > 0, N1 is N - 1, times(H, N1, T).
