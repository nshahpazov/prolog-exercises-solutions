% natular numbers generators
natural(0).
natural(N) :- natural(M), N is M + 1.
