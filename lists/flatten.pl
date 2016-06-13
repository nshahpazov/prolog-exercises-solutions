% flattens a list
% if its not a list make it a list so that it can be appended later
flatten_(X, [X]) :- not(is_list(X)).
flatten_([], []).
flatten_([H|T], X) :- flatten_(H, Y), flatten_(T, Z),
  append(Y, Z, X).