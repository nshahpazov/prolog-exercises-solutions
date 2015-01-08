% range(K, N, R)
% R = [K, K + 1, K + 2,..., N].
range(X, X, [X]).
range(S, E, [S|T]) :- S \= E,
  S1 is S + 1, range(S1, E, T).
