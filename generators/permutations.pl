%% helper remove
permutation([], []).
permutation(Xs, [Y|Zs]) :- member(Y, Xs),
                          remove(Xs, Y, Ts),
                          permutation(Ts, Zs).
