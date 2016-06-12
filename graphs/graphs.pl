; creating a graph

; <V, E> :- definition of a graph
; arc, path, connected


; arc of a non directed graph, for directed use or operator
arc([V, E], A, B):-
    member([A, B], E),
    member([B, A], E).

; path in a graph (dfs)
; A -> B, P is a blackbox for keeping track of the path
; V is for visited and not vendetta

_path(G, B, B, V, V). ; bottom of the search (found)
_path(G, A, B, P, V) :-
    arc(G, A, C),
    not(member(C, V)),
    ; add C to visited and continue with !existing another C for which ...
    _path(G, C, B, P, [C|V]).

; public procedure which uses the _path procedure
path(G, A, B, P) :-
    _path(G, A, B, P, [A]).

; connected
connected([V, E]) :-
    not(member(X, V), member(Y, V), not(path([V, E], X, Y, _))).
    ; not true that there are X, Y, members of V, for which there is no path X -> Y