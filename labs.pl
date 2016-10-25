member(H, [H|_]).
member(X, [_|T]) :- member(X, T).

first(F, [F|_]).
second(S, [_,S|_]).

% append L1 to L2, to get L1 + L2 = L3
append([], L2, L2).
append([H|T], L2, [H|R]) :- append(T, L2, R).

last(H, [H]).
last(X, [_|T]) :- last(X, T).

almost_last(X, [X,_]).
almost_last(X, [_|T]) :- almost_last(X, T).

% using append to get the same predicates as last and member
final(X, L) :- append(_, [X], L).
has(M, L) :- append(_, [M|_], L).

prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).
infix(I, L) :- append(P, _, L), append(_, I, P).

add(X, L, [X|L]).
add(X, [H|T], [H|N]) :- add(X, T, N).

% removes X from L to get N
remove(X, L, N) :- add(X, N, L).


% permutation(P, L) - P is a permutation of L
permutation([], []).
permutation([H|T], L) :- member(H, L),
                         remove(H, L, L1),
                         permutation(T, L1).

% todo: understand this one
% subset([], _).
%s ubset([H|S], L) :- append(_, [H|T], L), subset(S, T).

% predicate to check whether a list is sorted
less(A, B) :- not(B < A).
is_sorted([]).
is_sorted([_]).
is_sorted([A, B|T]) :- less(A, B), is_sorted(T).

% predicate to check whether S is a sorted permutation of L
permutation_sort(L, S) :- permutation(S, L), sorted(S).

% second way using the existence quantifier technique
is_sorted2(L) :- not((infix([A, B], L), not(less(B < A)))).

% min2(X, A, B) :- X is A if A is less then B
min_helper(A, A, B) :- less(A, B).
min_helper(B, A, B) :- not(less(A, B)).

% find a minimum element in a list
min(M, [M]).
min(M, [H|T]) :- min(Y, T), min_helper(M, H, Y).

% selection-sort
ssort([], []).
ssort([X|Xs], L) :- min(X, L), remove(X, L, L1), ssort(Xs, L1).

% just a quickie sort
% split(L, X, A, B)