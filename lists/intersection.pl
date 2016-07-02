intersection([], _, []).
intersection([X|Xs], L2, [X|Zs]) :- member(X, L2),
                                intersection(Xs, L2, Zs).
intersection([X|Xs], L2, Zs) :- not(member(X, L2)), intersection(Xs, L2, Zs).
