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

% sublists of duplicates
sublist_dupl([], []).
sublist_dupl([H|T], [H1|T1]) :- ns(H, H1, 2), sublist_dupl(T, T1).

%duplicates
dupl([], []).
dupl([H|T], R) :- append(X, Y, R), ns(H, X, 3),
  dupl(T, Y).


