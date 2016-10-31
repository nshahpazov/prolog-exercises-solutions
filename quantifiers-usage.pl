% X is a list of numbers
% Y is a list of lists of numbers

% 1. p1(X, Y) :- There exists an element of X which is in an element of Y
p1(X, Y) :- member(A, X), member(B, Y), member(A, B).

% 2. p2(X, Y) :- Exists an element of X, which is in every element of Y
p2(X, Y) :- member(A, X), not((member(B, Y), not(member(A, B)))).

% 3. p3(X, Y) :- every element of X is in an element of Y
p3(X, Y) :- not((member(A, X), not((member(B, Y), member(A, B))))).

% p4(X, Y) :- every of X is in every of Y
p4(X, Y) :- not((member(A, X), member(B, Y), not(member(A, B)))).