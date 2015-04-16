% generate all sublists of a list
subl([], []).

subl([First|Rest], [First|Sub]) :-
    subl(Rest, Sub).

subl([_|Rest], Sub) :-
    subl(Rest, Sub).
