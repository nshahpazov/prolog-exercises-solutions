% finds out whether an element is in a list
member(H, [H|T]). % bottom rule
member(X, [H|T]) :- member(X, T).

% appends two lists
append([], X, X).
append([H|T1], X, [H|T2]) :- append(T1, X, T2).

% finds the kth element of a list
kth(H, [H|_], 1).
kth(X, [_|T], K) :- K > 0,
  K1 is K - 1, kth(X, T, K1).

% finds the length of a list
len([], 0).
len([_|T], N) :- len(T, K), N is K + 1.

% reverse a list
rev([], []).
rev([H|T], R) :- rev(T, Y), append(Y, [H], R).

% finds out whether a list is palindrome
palindrome(L) :- reverse(L, L).

% split a list (L1, N, R1, R2)
split(L, 0, [], L).
split([H|T], N, [H|R1], R2) :- N > 0, N1 is N - 1,
  split(T, N1, R1, R2).

% extract a given number of randomly selected elements
% for now its not a sublist of unique elements... must be :)
rand_sublist(_, 0, []).
rand_sublist(T, N, [X|M]) :- N > 0, N1 is N - 1,
  len(T, L),
  random_between(1, L, RAND),
  kth(X, T, RAND),
  rand_sublist(T, N1, M).

% generates a list of numbers in range of M with length N
random_select(0, _, []).
random_select(N, M, [X|R]) :- N > 0, N1 is N - 1,
  random_between(1, M, X),
  random_select(N1, M, R).

% counts occurences of an element in a list
count(_, [], 0).
count(H, [H|T], N) :- count(H, T, N1), N is N1 + 1.
count(H, [_|T], N) :- count(H, T, N).
