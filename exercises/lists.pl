rev([], []).
rev([H|T], R) :- rev(T, Y), append(Y, [H], R).

len([], 0).
len([H|T], N) :-
  len(T, N1), N is N1 + 1.


