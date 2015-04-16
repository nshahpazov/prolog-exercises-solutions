% prolog split program

split(L, 0, [], L).
split([H1|T1], N, [H1|S1], S2) :- N > 0,
  N1 is N - 1,
  split(T1, N1, S1, S2).