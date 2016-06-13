% pack duplicates in consecutive lists
pack([], []).
pack([H], [[H]]).

pack([H, H|T], [[H|T2]|Rest]) :- pack([H|T], [T2|Rest]).
pack([X, Y|T], [[X]|Rest]) :- X \= Y, pack([Y|T], Rest).
