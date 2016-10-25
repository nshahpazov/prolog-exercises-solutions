Зад. 1.
Да се дефинира на пролог предикат p(L), който по даден списък L от списъци проверява дали за всеки два елемента на L, съществува трети елемент, съдържащ елемент, който не се среща в никой от другите два.
Решение:
member(X, [X|_]).
member(X, [_|T]):-member(X, T).
%common(A, B, C) :- C съдържа елемент, който го има и в A и в B
common(A, B, [X|_]) :- member(X, A), member(X, B).
common(A, B, [_|T]) :- common(A, B, T).
p(L):-
not( (member(A, L),
member(B, L),
member(C, L),
not(A = C), not(B = C),not(A = B),
common(A, B, C))).