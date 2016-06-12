% flattens a list
% if its not a list make it a list so that it can be appended later
flatt(X, [X]) :- not(is_list(X)).
flatt([], []).
flatt([H|T], X) :- flatt(H, Y), flatt(T, Z),
  append(Y, Z, X).