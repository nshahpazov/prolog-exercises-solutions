% count an occurance of an element in a list

% count(E, L, N).

count(_, [], 0).
count(H, [H|T], N) :- count(H, T, N1), N is N1 + 1.
count(H, [Y|T], N) :- H \= Y, count(H, T, N).
