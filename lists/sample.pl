
%% slice([a, b, c, d, e, f, g, h, i, k], 3, 7, L).

slice(_, 1, 0, []).
slice([X|Xs], 1, K, [X|Rs]) :- K > 0,
                               K1 is K - 1,
                               slice(Xs, 1, K1, Rs).

slice([_|Xs], N, K, Rs) :- N > 1,
                           K > 0,
                           N1 is N - 1,
                           K1 is K - 1,
                           slice(Xs, N1, K1, Rs).

