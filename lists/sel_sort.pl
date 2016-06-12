sort_([], []).
sort_([X|XS], [K|KS]) :- max([X|XS], K),
                         remove_([X|XS], K, YS),
                         sort_(YS, KS).