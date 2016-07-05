remove_kth([_|Xs], 1, Xs).
remove_kth([X|Xs], K, [X|Rs]) :- K > 0,
                                 K1 is K - 1,
                                 remove_kth(Xs, K1, Rs).
