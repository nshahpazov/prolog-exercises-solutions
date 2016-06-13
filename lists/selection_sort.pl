sort_([], []).
sort_([X|XS], [K|KS]) :- min([X|XS], K),
                         remove([X|XS], K, YS),
                         sort_(YS, KS).