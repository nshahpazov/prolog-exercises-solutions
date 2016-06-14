% Decode a run-length encoded list.
% Given a run-length code list generated as specified in length_encode.
% Construct its uncompressed version.
decode([], []).
decode([[X, T]|Xs], Zs) :- times(X, T, Y),
                           decode(Xs, Ys),
                           append(Y, Ys, Zs).