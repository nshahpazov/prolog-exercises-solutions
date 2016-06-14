% duplicates elements in a list given an encoded list of pairs [El, Times]
duplicate_encoded([], []).
duplicate_encoded([[E, T]|Es], [Z|Zs]) :- times(E, T * 2, Z),
                                         duplicate_encoded(Es, Zs).

% encodes to [Element, Times] and then uses the duplicate_encoded to duplicate
% the number of elements
duplicate([], []).
duplicate(Xs, Zs) :- encode(Xs, Ys), duplicate_encoded(Ys, Zs).