% Run-length encoding of a list.
% Use the result of problem P09 to implement the so-called run-length encoding
% data compression method.
% Consecutive duplicates of elements are encoded as terms [N,E] where N is the
% number of duplicates of the element E.

encode_one([], []).
encode_one([[X1|X1s]|Xs], [[X1, Y]|Zs]) :- length([X1|X1s], Y),
                                           encode_one(Xs, Zs).

encode([], []).
encode(Xs, Zs) :- pack(Xs, Ys), encode_one(Ys, Zs).
