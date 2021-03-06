% tree in prolog

% Left, Root, Right
t(L, T, R).

% tsort(S, L)

% make a tree from a list
% maketree(L, T)

% ltr() ; traversing the tree
% maketree
% making a tree from empty list is the constant e (empty)
maketree([], e).
maketree([H|L], T) :- maketree(L, T1), add(H, T1, T).

add(X, e, t(e, X, e)).

add(X, t(L, T, R), t(L1, T, R)) :- X < T, add(X, L, L1).

ltr(e, []) :- ltr(L, SL),
              ltr(R, SR),
              append(SL, [T|SR], S)

tsort(S, L) :- make(L, T), ltr(T, S).

% structure of a tree
% n + m + 1 = k
t(K, [A,B]) :-
    K1 is K - 1,
    between(M, O, K1),
    N is K1 - M,
    % make the two trees
    t(M, A),
    t(N, B).

sorted([]).
sorted([_]).
sorted([A, B|T]) :- less(A, B), sorted([B|T]).
