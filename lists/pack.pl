% pack duplicates in consecutive lists
pack([], []).
pack([H], [[H]]).
pack([H, H|T], [[H|T2]|Rest]) :- pack([H|T], [T2|Rest]).
pack([X, Y|T], [[X]|Rest]) :- X \= Y, pack([Y|T], Rest).


% p99's solution
pack_([], []).
pack_([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z), pack_(Ys, Zs).

% transfer(X, Xs, Ys, Z) Ys is the list that remains from the list Xs
%    when all leading copies of X are removed and transfered to Z
transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- X \= Y.
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).
