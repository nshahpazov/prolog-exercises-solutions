% remove an element from a list
remove_([], _, []).
remove_([X|XS], X, XS).
remove_([X|XS], Y, [X|KS]) :- Y \= X, remove_(XS, Y, KS).