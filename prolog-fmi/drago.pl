pm([N|_], N).
pm([_|T], N) :- pm(T, N).
pm([H|T], N) :- N1 is N - H, pm(T, N1).

