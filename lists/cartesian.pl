d([], []).
d([H|T], [HD|TD]) :- member(HD, H), d(T, TD).


