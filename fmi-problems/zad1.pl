% X е списък от списъци

%p1(X) [] е елемент на X

p1([[]|_]).
p1([_|L]) :- p1(L).

% p2(X) X съдържа Y  и Z, които нямат общи елементи
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

notoverlap(L1, L2) :- not((member(X, L1), member(X, L2))).

p2(X) :- member(Y, X), member(Z, X), Z \= Y, notoverlap(Y, Z).

% p4(X) за всеки елемент Y на X съществува елемент Z такъв че Y и Z нямат общи елементи.

p4(X) :- not((member(Y, X), not((member(Z, X), notoverlap(Y, Z))))).

%p5(X) X съдържа елемент, съдържащ точно един елемент.
p5(X) :- member([_], X).

% Казваме, че списъкът [X1, X2,...,Xn] от цели числа е специален ако за всяко k; 1<=k<=n/2 е изпълнено:
% *X_2k = X_(X_(k+2)) ако 1<=k+2<=n и 1<=X_(k+2)<=n
% *X_2k = 2X_k + 2 в противен случай
% spec(X) връща дали X е специален.

nth(1, X, [X]).
nth(N, X, [H|T]) :- X \= H, nth(N1, X, T), N is N1 + 1.

size(0, []).
size(N, [_|T]) :- size(N1, T), N is N1 + 1.

between(A, A, B) :- A =< B.
between(A, X, B) :- A =< B, A1 is A + 1, between(A1, X, B).

speck(K, L) :- size(N, L),
               KK is K * 2,
               K2 is K + 2,
               1 =< K2,
               K2 =< N,
               nth(K2, XK2, L),
               1 =< XK2,
               XK2 =< N,
               nth(KK, XKK, L),
               nth(XK2, XXK2, L),
               XKK = XXK2. % може да се качи горе


speck(K, L) :- size(N, L),
               KK is K * 2,
               K2 is K + 2,
               (K2 < 1; K2 > N),
               nth(K2, XK2, L),
               (XK2 < 1; XK2 > N),
               nth(KK, XKK, L),
               XKK is 2 * XKK + 2.

spec(L) :- not((size(N, L), N2 is N/2, between(1, K, N2), not(speck(K, L)))).
