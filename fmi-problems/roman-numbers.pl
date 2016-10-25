rom(1, i).
rom(5, v).
rom(10, x).
rom(50, l).
rom(100, c).
rom(500, d).
rom(1000, m).
rom(4, iv).
rom(9, ix).
rom(40, xl).
rom(90, xc).
rom(400, cd).
rom(900, cm).

maxr(X, R) :- rom(R, _), X >= R, not((rom(R1, _), X >= R1, R1 > R)).

rom(N) :- maxr(N, K), rom(K, R), write(R), NN is N - K, rom(NN).

lrom(1, [i]).
lrom(5, [v]).
lrom(10, [x]).
lrom(50, [l]).
lrom(100, [c]).
lrom(500, [d]).
lrom(1000, [m]).
lrom(4, [i, v]).
lrom(9, [i, x]).
lrom(40, [x, l]).
lrom(90, [x, c]).
lrom(400, [c, d]).
lrom(900, [c, m]).

maxlr(X, R) :- lrom(R, _), X>=R, not((lrom(R1, _), X >= R1,  R1 > R)).
l2rom(R, L) :- lrom(R, L).
l2rom(N, [L1, L2|T]) :- lrom(R1, [L1]), lrom(R2, [L2]), R1 < R2, l2rom(N1, T), lrom(R, [L1, L2]), N is N1 + R.
l2rom(N, [L1, L2|T]) :- lrom(R1, [L1]), lrom(R2, [L2]), R1 >= R2, l2rom(N1, [L2|T]), N is N1 + R1.

rom2l(N, L) :- lrom(N, L).
rom2l(N, L) :- maxlr(N, NR), lrom(NR, LR), NN is N - NR, rom2l(NN, LN), cnct(LR, LN, L).
