prime(1).
prime(2).
prime(3).
prime(N) :- integer(N), N > 3, N mod 2 =\= 0, not(has_factor(N, 3)).

has_factor(N, L) :- N mod L =:= 0.
has_factor(N, L) :- L * L < N, L2 is L + 2, has_factor(N, L2).
