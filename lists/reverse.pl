% reverse a list in prolog

rev([], []).
rev([H|T], R) :- rev(T, Y),
    append(Y, [H], R).