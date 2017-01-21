add(X, L, [X|L]).
add(X, [H|T], [H|R]) :- add(X, T, R).

remove(X, L1, L2) :- add(X, L2, L1).

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

append2([], L, L).
append2([H|T], L, [H|R]) :- append(T, L, R).

last2(X, L) :- append(_, [X], L).
member2(X, L) :- append(_, [X|_], L).

infix(N, L) :- append(X, N, L), X \= [].

length2([], 0).
length2([_|T], N) :- length2(T, N1), N is N1 + 1.

permutation([], []).
permutation([H|T], L) :- member(H, L), remove(H, L, L1), permutation(T, L1).


sorted([_]).
sorted([X, Y|T]) :- X =< Y, sorted([Y|T]).

psort(L, S) :- permutation(S, L), sorted(S).

min(M, [M]).
min(H, [H|T]) :- min(M, T), H =< M.
min(M, [H|T]) :- min(M, T), M =< H.

ssort([], []).
ssort([M|T], L) :- min(M, L), remove(M, L, L2), ssort(T, L2).

rev([], S, S).
rev([H|T], S, R) :- rev(T, [H|S], R).

rev(A, B) :- rev(A, [], B).