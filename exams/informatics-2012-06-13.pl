% Problem 1
% write a predicate p which generates all points (X, Y)
% which are in square with bottom left point (X1, Y1),
% and width of sides A, and in the same time in circle with center (X2, Y2) with radius R

in_circle(X2, Y2, R, X, Y) :- Z is sqrt((X2-X)*(X2-X)+(Y2-Y)*(Y2-Y)),
                                Z < R.

p(X1, Y1, A, X2, Y2, R, X, Y) :- between(X, X1, X1 + A),
                                 between(Y, Y1, Y1 + A),
                                 in_circle(X2, Y2, R, X, Y).



% Problem 2
% We say that the list L = [[x1,y1],..., [x_n, y_n]] describes a function F
% 1. Write a predicate i which checks whether a function described by the list L is injective
i(L) :- not((
          member([X1, Y1], L),
          member([X2, Y2], L),
          X1 \= X2, Y1 =:= Y2
        )).

% 2. Write a predicate m which checks whether a function described by the list L is monotonic
m1(L) :- not((
          member([X1, Y1], L),
          member([X2, Y2], L),
          X1 < X2, Y2 < Y1
         )).


m2(L) :- not((
          member([X1, Y1], L),
          member([X2, Y2], L),
          X1 < X2, Y1 < Y2
         )).

m(L) :- m1(L).
m(L) :- m2(L).

% 3. Write a predicate c which from two lists L1, L2, creates a list L3 which represent the
% composition of the functions F1(L1) and F2(L2), i.e. F3(x) = F2(F1(x))
exec(L, X, Y) :- member([X, Y], L).
c([], _, []).
c([[X1, Y1]|T1], L2, [[X1, A]|R]) :- exec(L2, Y1, A), c(T1, L2, R).