% finds out whether an element is in a list
member(H, [H|T]). % bottom rule
member(X, [H|T]) :- member(X, T).

% appends two lists
append([], X, X).
append([H|T1], X, [H|T2]) :- append(T1, X, T2).

% finds the last element
last([H|[]], H).
last([_|T], X) :- last(T, X).

% finds the last but one element of a list
lastbutone([H|[_|[]]], H).
lastbutone([_|T], X) :- lastbutone(T, X).

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

% removes duplicates from a list
% can be optimized with H|T and without append and without if
set([], []).
set([H|T], [H|R]) :- not(member(H, T)), set(T, R).
set([H|T], R) :- member(H, T), set(T, R).

% removes consequetive duplicates
compress([], []).
compress([X], [X]).
compress([X, X|Xs], Zs) :- compress([X|Xs], Zs).
compress([X, Y|Ys], [X|Zs]) :- X \= Y, compress([Y|Ys], Zs).

% transfer(X, Xs, Ys, Z)
transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- X \= Y.
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).

% duplicates an element k times
ns(_, 0, []).
ns(H, K, [H|T]) :- K > 0, K1 is K - 1, ns(H, K1, T).

% duplicates in packs
dupl_in_packs([], _, []).
dupl_in_packs([H|T], N, [H1|T1]) :- ns(H, N, H1), dupl_in_packs(T, N, T1).

% just duplicates the first element a given amount of times
dupl([], _, []).
dupl([H|T], N, R) :- append(X, Y, R), ns(H, N, X),
  dupl(T, N, Y).


% sublists of duplicates
pack([], []).
pack([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z),
  pack(Ys, Zs).

% length encoding
% encode([a, a, a, a, b, c, c, c], X)
% X = [[4, a], [1, b], [3, c]].

% encode([], []).
encode(L1, L2) :- pack(L1, L), encounters(L, L2).

% takes the head of a list
single([], []).
single([H|_], H).

% encounters how many times a sublist has its duplicates
% for example [[a, a], [b ,b, b], X].
% X = [2, a], [3, b].
encounters([], []).
encounters([H1|T1], [[H2, Y]|T2]) :- length(H1, H2),
  single(H1, Y), encounters(T1, T2).

encode_modified(L1, L2) :- encode(L1, L), strip(L, L2).

% strips singles from lists of encounters
strip([], []).
strip([[1, X]|Ys], [X|Zs]) :- strip(Ys, Zs). % recursive
strip([[N, X]|Ys], [[N, X]| Zs]) :- N > 1, strip(Ys, Zs).

% decode run-length-encoding
% [[2, a], [1, z], [2, foo]]] -> [a, a, z, foo, foo]
decode([], []).
decode([[N, X]|Xs], Ys) :- ns(X, N, Y),
  append(Y, Gs, Ys), decode(Xs, Gs).

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
