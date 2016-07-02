different(L1, L2) :- member(X, L1), not(member(X, L2)).
different(L1, L2) :- member(X, L2), not(member(X, L1)).