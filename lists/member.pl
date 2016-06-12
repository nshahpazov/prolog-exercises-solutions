% finds out whether an element is in a list
member(H, [H|T]). % bottom rule
member(X, [H|T]) :- member(X, T).
