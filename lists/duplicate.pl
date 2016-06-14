duplicate_packed([], []).
duplicate_packed([[E, T]|Es], [Z|Zs]) :- times(E, T * 2, Z),
                                         duplicate_packed(Es, Zs).

duplicate([], []).
duplicate(Xs, Zs) :- encode(Xs, Ys), duplicate_packed(Ys, Zs).