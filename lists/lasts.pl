% finds the last element
last([H|[]], H).
last([_|T], X) :- last(T, X).

% finds the last but one element of a list
lastbutone([H|[_|[]]], H).
lastbutone([_|T], X) :- lastbutone(T, X).
