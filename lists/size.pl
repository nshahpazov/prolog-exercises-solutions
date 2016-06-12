% finds the length of a list
size([], 0).
size([_|T], N) :- size(T, K), N is K + 1.