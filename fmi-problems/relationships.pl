woman(ann).
woman(mary).

man(john).
man(tom).
man(jerry).

parent(ann, john).
parent(ann, mary).
parent(john, tom).
parent(mary, jerry).

mother(X, Y) :- parent(X, Y), woman(X).

father(X, Y) :- parent(X, Y), man(X).

siblings(X, Y) :- parent(Z, X), parent(Z, Y), not(X = Y).

brother(X, Y) :- siblings(X, Y), man(X).

cousins1(X, Y) :- parent(Z, X), parent(T, Y), siblings(Z, T), not(X = Y).

cousins(X, Y) :- cousins1(X, Y); (parent(Z, X), parent(T, Y), cousins(Z, T)).
