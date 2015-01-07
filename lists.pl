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

% flattens a list
flatt(X, [X]) :- not(is_list(X)). % if its not a list make it a list so that it can be appended later
flatt([], []).
flatt([H|T], X) :- flatt(H, Y), flatt(T, Z),
  append(Y, Z, X).

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

% drop nth element
drop_([], _, _, R).
drop_([H|T], N, K, [H|R]) :- K mod N =\= 0, K1 is K + 1,
  drop_(T, N, K1, R).
drop_([_|T], N, K, R) :- K mod N =:= 0, K1 is K + 1,
  drop_(T, N, K1, R).
drop(L, N, R) :- drop_(L, N, 1, R).

% slice a list
% slice(L, S, E, R).
slice([], _, _, []).
slice(_, 0, 0, []).
slice([H|T1], 0, E, [H|T]) :- E1 is E - 1, slice(T1, 0, E1, T).
slice([H|T1], N, E, T) :- N > 0, N1 is N - 1,
  E1 is E - 1, slice(T1, N1, E1, T).

% remove at index
% rem(L, K, R).
remove_at([], _, []).
remove_at([H|T1], 0, R) :- remove_at(T1, -1, R).
remove_at([H|T], N, [H|R]) :- N \= 0, N1 is N - 1,
  remove_at(T, N1, R).

% insert at a given position
insert_at([], X, _, [X]).
insert_at(T, H, 0, [H|T]).
insert_at([X|Xs], Y, N, [X|Zs]) :- N > 0, N1 is N - 1,
  insert_at(Xs, Y, N1, Zs).

% split a list (L1, N, R1, R2)
split(L, 0, [], L).
split([H|T], N, [H|R1], R2) :- N > 0, N1 is N - 1,
  split(T, N1, R1, R2).

% rotate a list to the left (uses split procedure)
% rotate([1,2,3,4,5], -2, R).
% R = [4, 5, 1, 2, 3].
rotate([], _, []).
rotate(L, N, R) :- length(L, N2), N1 is N2 + N,
  append(Y, X, R), split(L, N1, X, Y).

% range(K, N, R)
% R = [K, K + 1, K + 2,..., N].
range(X, X, [X]).
range(S, E, [S|T]) :- S \= E,
  S1 is S + 1, range(S1, E, T).

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
  random_select(N1,M, R ).

% rand permutation of a list
rand_perm([], []).
rand_perm(L, R) :- len(L, LEN), rand_sublist(L, LEN, R).

% if X is element return the list
el(X, [X|L], L).
el(X, [_|L], R) :- el(X, L, R).

% combination(3, [a, b, c, d, e, f], L).
% note: understand it well
% L = [a, b, c], L = [a, b, d], ...
combination(0, _, []).
combination(K, L, [X|Xs]) :- K > 0,
  el(X, L, R), K1 is K - 1, combination(K1, R, Xs).

% p27
% a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? Write a predicate that generates all the possibilities via backtracking.

% select N but avoid permutations
% selectN(N, L, R).

% group3(G, G1, G2, G3) :-
% not working right now
group3(G,G1,G2,G3) :-
  combination(2, G, G1),
  subtract(G, G1, R1),
  combination(3, R1, G2),
  subtract(R1, G2, R2),
  combination(4, R2, G3),
  subtract(R2, G3, []).

% makes a variations with X in front
% put(a, [1, 2, 3, 4], R).
% R = [[a, 1], [a, 2], [a, 3], [a, 4]]
put(X, [], []).
put(X, [H|T], [[X, H]|R]) :- put(X, T, R).

% cartesian product
cartesian([], _, []).
cartesian([H1|T1], S2, R) :- put(H1, S2, R1),
  cartesian(T1, S2, R2), append(R1, R2, R).

% counts occurences of an element in a list
count(_, [], 0).
count(H, [H|T], N) :- count(H, T, N1), N is N1 + 1.
count(H, [_|T], N) :- count(H, T, N).

% find the fibonnaci nth element
fibb(1, 0).
fibb(2, 1).

fibb(N, E) :- N >= 3,
  N1 is N - 1,
  N2 is N - 2,
  fibb(N1, E1), fibb(N2, E2),
  E is E1 + E2. % must be at the back because of the nesting  

% generate the fibonacci sequence
% not finished yet, not working right now
fib_seq(1, [0]).
fib_seq(2, [0, 1]).
fib_seq(N, [X|T]) :- N > 0,
  last(T, X1),
  lastbutone(T, X2),
  X is X1 + X2,
  fib_seq(N1, T),
  N is N1 + 1.
