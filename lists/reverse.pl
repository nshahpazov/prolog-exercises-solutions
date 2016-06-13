reverse_([], []).
reverse_([H|T], R) :- reverse_(T, Y),
    append(Y, [H], R).