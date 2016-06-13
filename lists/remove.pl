% remove an element from a list
remove([], _, []).
remove([X|XS], X, XS).
remove([X|XS], Y, [X|KS]) :- Y \= X, remove(XS, Y, KS).