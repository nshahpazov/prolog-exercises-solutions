% Find the last element
my_last([X|[]], X).
my_last([_|XS], X) :- my_last(XS, X).

% Last but one element
last_but_one([X|[_|[]]], X).
last_but_one([_|XS], X) :- last_but_one(XS, X).

% Find the K'th Element of a list
kth([X|_], 1, X).
kth([_|XS], K, Y) :- K > 0, K1 is K - 1, kth(XS, K1, Y).

size([], 0).
size([X|XS], N) :- N is N1 + 1, size(XS, N1).
