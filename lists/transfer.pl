% transfer(X, Xs, Ys, Z) Ys is the list that remains from the list Xs
%    when all leading copies of X are removed and transfered to Z
transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- X \= Y.
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).
