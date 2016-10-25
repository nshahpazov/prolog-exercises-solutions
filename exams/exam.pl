% ########################## I. Списъци ##########################

%member(A, L) - A е елемент на списъка L
member(A, [A|X]).
member(A, [H|T]):-member(A, T).

%count(L, C) - C е броят на елементи в списъка L 
count([], 0).
count([_|T],N1) :-count(T,N), N1 is N+1.

%sorted(L) - списъка L е сортиран възходящо
sorted([]).
sorted([A]).
sorted([A, B|X]):-A=<B, sorted([B|X]).

%sorted2(L) - списъка L е сортиран нисходящо
sorted2([]).
sorted2([A]).
sotred2([A, B|X]):-A>=B, sorted([B|X]).

%first(L, A) - A е първия елемент на списъка L
first([A], A).
first([H|T], A):-first(H, A).

%last(L, A) - A е последния елемент на списъка L
last([A], A).
last([H|T], A):-last(T, A).

%conseq(L, X, Y) - X и Y са последователни елементи на списъка L 
conseq(L, X, Y):-append(_, [X, Y|_], L). 

%beforelast(L, A) - А е предпоследния елемент на списъка L
beforelast([A|_], A).
beforelast([_, H|T], A):-beforelast([H|T], A).

%kth(L, K, X) - X е К-тият елемент на списъка L
kth([X|_], 1, X).
kth([_|L], K, X):- K > 1, K1 is K - 1, kth(L, K1, X).

%append(X, Y, Z)-Z е конкатенацията на списъците X и Y
append([], Y, Y).
append([H|T], Y, [H|R]):-append(T, Y, R).

%insert(A, Y, Z) - Z е резултатът от вмъкването на елемента A в списъка L
insert(A, Y, [A|Y]).
insert(A, [B|Y], [B|Z]):-insert(A, Y, Z).

%extract(Y, A, Z) - A е елемент от списъка Y, а Z е списъка Y без елемента A
extract([A|Y], A, Y).
extract([A|X], B, [A|Z]):-extract(X, B, Z).

%perm(L, P) - P е пермутация на списъка L
perm([], []).
perm([A|X], Z):-perm(X, Y), insert(A, Y, Z).

%sublist(L, S) - S е подсписък на L 
sublist(L, S):-append(A, R, L), append(S, B, R).

%palindrome(L) - L е палиндром, т.е. няма значение дали го разглеждаме от ляво на дясно или от дясно на ляво [x, a, m, a, x]
palindrome(L):-reverse(L, L).

%compress(L, C) - C е списъка L, но всеки елемент на L се среща само веднъж в C, т.е. премахва повторенията
compress([], []).
compress([X], [X]).
compress([X,X|Xs], Zs):-compress([X|Xs], Zs).
compress([X,Y|Ys],[X,Zs]):- X\=Y, compress([Y|Ys], Zs).

%sort(L, S) - S е списъка L, но сортиран възходящо 
sort(L, S):-perm(L, S), sorted(S).	% бавно и неефективно

%sort2(L, S) - S е списъка L, но сортиран възходящо
%limit(L, Т) - T е модата на списъка L
limit(L, T):-first(L, F), last(L, G), T is (F + G) / 2.
%split(L, T, A, B) - A съдържа всички елементи на списъка L, които са по-малки от T,
%					 а B съдържа всички елементи на списъка L, които са по-големи от Т
split([], _, [], []).
split([H|Q], T, [H|A], B):-H=<T, split(Q, T, A, B).
split([H|Q], T, A, [H|B]):-H > T, split(Q, T, A, B).
sort2(L, S):-count(L, C), C > 1, limit(L, T, A, B),
            sort2(A, SA), sort2(B, SB), append(AS, BS, S).
			
% ############# I. Графи #############
% Граф наричаме всяка двойка (V, E), където V е множество от върхове, а E е множество от ребра.
%граф([V, E])-граф([a1, a2, ...], [[ai, vj], ....]).

%edge(G, V1, V2) - има ребро между V1 и V2
edge([V, E], V1, V2):-member([V1, V2], E).

%isolated(U, G):- U е изолиран връх на G
isolated(U, [V, E]):-member(U, V), not(member([_, U], E)), not(member([U, _], E)).

%path(X, G) - X е път в G (не става за генератор!)
path(X, [V, E]):-not(append(X, _, [u1, u2|_)),
				 not(member([u1, u2], E)).
				 
%acyclicPath(X, G) - X е път в G, който не минава само по-веднъж през всеки връх.
acyclicPath(X, [V, E]):-perm(W, V), union(W, X, _), path(X, [V, E]).

%connected(U1, U2, G) - в G има път от U1 до U2
connected(U, U, [V, E]):-member(U, V).
connected(U1, U2, [V, E]):-acyclicPath([U1|X], [V, E]), last(U2, X).

%clique([V, E], C):- C е максимално множество от върхове, като между всеки два
%					 връха от това множество има ребро, т.е. е клика
clique([V, E], C):-sublist(V, C), not(member(C, X), member(C, Y)), not(member(E, [X, Y])).

% Малко инфо за реализацията:
% Запозваме с дефиницията за клика:
%	C е клика <=> C ⊆ V & ∀x∀y[(x∈C & y∈C) => (x, y)∈E]
%	C ⊆ V & ¬∃x∃y[x∈C & y∈C&¬(x, y)∈E] => C е клика

%path(G, A, B, P) - P е ацикличен път от A до B в графа G.
path(G,A,B,P) :- path1(G,A,[B],P).
path1(_,A,[A|P1],[A|P1]).
path1(G,A,[Y|P1],P) :- 
   edge(X,Y,G), member(X,[Y|P1]), path1(G,A,[X,Y|P1],P).
   
%cycle(G, A, P):- P е цикъл започващ от A в графа G
cycle(G, A, P):-edge(B, A, G), path(G, A, B, P1), count(P1, L), L > 2, append(P1, [A], P).
 
% ########################## II. Аритметика ##########################
%
% ВАЖНО ЗА ГЕНЕРАТОРИТЕ: Ако се използват повече от два генератора за предикат
% това е грешка! Ако предикат с безкраен генератор използва друг предикат, който
% използва безкраен генератор това също е грешка. НА ИЗПИТА ЗАДАЧИ С ТОЗИ ПРОБЛЕМ
% СЕ ОЦЕНЯВАТ С 0 ТОЧКИ. Решението е да се използва един безкраен и един краен
% генератор, например between(N, A, B) - N е число между A и B
%
%nat(N) - N е естествено число (генератор)
nat(0).
nat(N1):-nat(N), N1 is N + 1.
 
%int(N) - N е цяло число (генератор)
int(N):-nat(K), (N = L; N is - L).

%between(N, A, B) - N е число между A и B
between(X, L, H) :- X is L + 1, X < H.
between(X, L, H) :- L1 is L + 1, L1 < H, between(X, L1, H).

%rat(Z) - N е рационално число (q/p)(генератор)
rat(Z):-pair(X, Y), Z is X/Y.

%pair(X, Y):-X и Y са цели числа (генератор на двойки цели числа)
pair(X, Y):- int(S), between2(X, 0, S), Y is S - X.

%sum(X, N) - N е сумата на всички елементи на списъка X 
sum([], 0).
sum([A|X], Z):-sum(X, K), Z is A + K.

%remainder(X, Y, R) - R е остатъка от целичисленото делене X / Y
remainder(X, Y, R):- R is X - (X // Y) × Y.

%prime(N) - N е просто число
prime(N):-nat(N), N1 is N-1, between(K, 2, N1), not(remainder(K, N, 0)), N > 1.