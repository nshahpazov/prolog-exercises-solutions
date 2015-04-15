last_but_one([H|[_|[]]], H).
last_but_one([_|T], H2) :- last_but_one(T, H2).

append([], X, X).
append([H|T1], X, [H|R]) :- append(T1, X, R).

palindrome(L) :- reverse(L, L).

flatten(H, [H]) :- not(is_list(H)).
flatten([], []).
flatten([H|L], Y) :- flatten(H, H1), flatten(L, Z), append(H1, Z, Y).


compress([], []).
compress([X], [X]).
compress([X, X|Xs], Zs) :- compress([X|Xs], Zs).
compress([X, Y|Xs], [X|Zs]) :- X \= Y, compress([Y|Xs], Zs).