%% L = [e, d, a]
%% random(1, 5, R).
%% Not a generator
random_select(_, 0, []).
random_select(L, N, [R|Rs]) :- N > 0,
                          length(L, Length),
                          N1 is N - 1,
                          random(1, Length, Rand),
                          get_at(L, Rand, R),
                          remove_kth(L, Rand, Next),
                          random_select(Next, N1, Rs).