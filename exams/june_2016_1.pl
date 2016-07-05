% define a prolog predicate p(L) which checks whether for a given a list of
% lists L, for every two elements of L there exists a third which holds all common
% elements of the first two lists

intersection([], _, []).
intersection([X|Xs], L2, [X|Zs]) :- member(X, L2),
                                intersection(Xs, L2, Zs).
intersection([X|Xs], L2, Zs) :- not(member(X, L2)), intersection(Xs, L2, Zs).

different(L1, L2) :- member(X, L1), not(member(X, L2)).
different(L1, L2) :- member(X, L2), not(member(X, L1)).

p(L) :- member(L1, L),
        member(L2, L),
        different(L1, L2),
        member(L3, L),
        intersection(L1, L2, L3).