% finds the kth element of a list
kth(H, [H|_], 1).
kth(X, [_|T], K) :- K > 0,
  K1 is K - 1, kth(X, T, K1).

