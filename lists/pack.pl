% pack duplicates in consecutive lists
pack([], []).
pack([H], [[H]]).
pack([H, H|T], [[H|T2]|Rest]) :- pack([H|T], [T2|Rest]).
pack([X, Y|T], [[X]|Rest]) :- X \= Y, pack([Y|T], Rest).


% p99's solution
pack_([], []).
pack_([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z), pack_(Ys, Zs).