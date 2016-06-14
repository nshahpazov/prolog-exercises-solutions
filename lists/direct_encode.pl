% Run-length encoding of a list (direct solution).
% Implement the so-called run-length encoding data compression method directly.
% don't explicitly create the sublists containing the duplicates,
% as in problem P09, but only count them. As in problem P11,
% simplify the result list by replacing the singleton terms [1,X] by X.

encode_one_direct([], []).
encode_one_direct([[X1|[]]|Xs], [X1|Zs]) :- encode_one_direct(Xs, Zs).
encode_one_direct([[X1|X1s]|Xs], [[X1, Y]|Zs]) :- length([X1|X1s], Y),
                                                  encode_one_direct(Xs, Zs).
encode_direct([], []).
encode_direct(Xs, Zs) :- pack(Xs, Ys), encode_one_direct(Ys, Zs).