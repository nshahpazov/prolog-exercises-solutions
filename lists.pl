% finds out whether an element is in a list
member(H, [H|_]). % bottom rule
member(X, [_|T]) :- member(X, T).

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
kth(H, [H|_], 0).
kth(X, [H|T], K) :- K > 0,
  K1 is K - 1,
  kth(X, T, K1).

% finds the length of a list
length2([], 0).
length2([_|T], N) :- length2(T, K), N is K + 1.

% reverse a list
rev([], []).
rev([H|T], X) :- rev(T, Y), append(Y, [H], X).

% finds out whether a list is palindrome
palindrome(L) :-reverse(L, L).

% flattens a list
flatt(X, [X]) :- not(is_list(X)). % if its not a list make it a list so that it can be appended later
flatt([], []).
flatt([H|T], X) :- flatt(H, Y), flatt(T, Z), append(Y, Z, X).

% removes duplicates from a list
set([], []).
set([H|T], X) :- not(member(H, T)) -> 
    append([H], Y, X), set(T, Y) ; set(T, X).

% removes consequetive duplicates
compress([], []).
compress([X], [X]).
compress([X, X|Xs], Zs) :- compress([X|Xs], Zs).
compress([X, Y|Ys], [X|Zs]) :- X \= Y, compress([Y|Ys], Zs).

%packs a consequetive duplicates into sublists
pack([], []).

% transfer(X, Xs, Ys, Z)
transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- X \= Y.
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).

% duplicates an element k times
ns(X, [X], 1).
ns(X, Y, K) :- K > 0, K1 is K - 1, append([X], Z, Y), ns(X, Z, K1).

% duplicates in packs
dupl_in_packs([], []).
dupl_in_packs([H|T], [H1|T1]) :- ns(H, H1, N), pack_dupl(T, T1).

% just duplicates the first element a given amount of times
dupl([], []).
dupl([H|T], R) :- append(X, Y, R), ns(H, X, 2),
  dupl(T, Y).

% sublists of duplicates
pack([],[]).
pack([X|Xs],[Z|Zs]) :- transfer(X,Xs,Ys,Z),
  pack(Ys,Zs).

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
% [[2, a], [1, z], [2, topki]]] -> [a, a, z, topki, topli]
decode([], []).
decode([[N, X]|Xs], Ys) :- ns(X, Y, N),
  append(Y, Gs, Ys), decode(Xs, Gs).



















