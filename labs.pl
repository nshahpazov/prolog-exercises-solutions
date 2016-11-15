member(H, [H|_]).
member(X, [_|T]) :- member(X, T).

first(F, [F|_]).
second(S, [_,S|_]).

% append L1 to L2, to get L1 + L2 = L3
append([], L2, L2).
append([H|T], L2, [H|R]) :- append(T, L2, R).

last(H, [H]).
last(X, [_|T]) :- last(X, T).

almost_last(X, [X,_]).
almost_last(X, [_|T]) :- almost_last(X, T).

% using append to get the same predicates as last and member
final(X, L) :- append(_, [X], L).
has(M, L) :- append(_, [M|_], L).

prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).
infix(I, L) :- append(P, _, L), append(_, I, P).

insert(X, L, [X|L]).
insert(X, [H|T], [H|N]) :- insert(X, T, N).

% removes X from L to get N
remove(X, L, N) :- insert(X, N, L).


% permutation(P, L) - P is a permutation of L
permutation([], []).
permutation([H|T], L) :- member(H, L),
                         remove(H, L, L1),
                         permutation(T, L1).

% todo: understand this one
% subset([], _).
%s ubset([H|S], L) :- append(_, [H|T], L), subset(S, T).

% predicate to check whether a list is sorted
less(A, B) :- not(B < A).
is_sorted([]).
is_sorted([_]).
is_sorted([A, B|T]) :- less(A, B), is_sorted(T).

% predicate to check whether S is a sorted permutation of L
permutation_sort(L, S) :- permutation(S, L), sorted(S).

% second way using the existence quantifier technique
is_sorted2(L) :- not((infix([A, B], L), not(less(B < A)))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%% 19.10.2016 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% min2(X, A, B) :- X is A if A is less then B
min_helper(A, A, B) :- less(A, B).
min_helper(B, A, B) :- not(less(A, B)).

% find a minimum element in a list
min(M, [M]).
min(M, [H|T]) :- min(Y, T), min_helper(M, H, Y).

% selection-sort
ssort([], []).
ssort([X|Xs], L) :- min(X, L), remove(X, L, L1), ssort(Xs, L1).

% just a quickie sort
% split(L, X, A, B)
split([], _, [], []).
split([H|T], X, [H|A], B) :- H < X, split(T, X, A, B).
split([H|T], X, A, [H|B]) :- not(H < X), split(T, X, A, B).

qs([], []).
qs([H|T], R) :- split(T, H, R1, R2),
                qs(R1, S1),
                qs(R2, S2),
                append(S1, [H|S2], R).

% binary trees
% []
% [L, T, R]

add(X, [], [[], X, []]).
add(X, [L1, Y, R], [L, Y, R]) :- X < Y, add(X, L1, L).
add(X, [L, Y, R1], [L, Y, R]) :- not(X < Y), add(X, R1, R).

maketree([], []).
maketree([X|Xs], R) :- maketree(Xs, Y),
                       add(X, Y, R).

ltr([L, T, R], A) :- ltr(L, Ls), ltr(R, Rs), append(Ls, [T|Rs], A).
tsort(L, S) :- maketree(L, T), ltr(T, S).

reverse([], []).
reverse([H|T], R) :- reverse(T, T1), append(T1, [H], R).

% reverse using the stack technique
reverse_([], S, S).
reverse_([H|L], S, R) :- reverse_(L, [H|S], R).

reverse2(L, R) :- reverse_(L, [], R).

% arithmetics
size([], 0).
size([_|T], N) :- size(T, N1), N is N1 + 1.

sum([], 0).
sum([H|T], S) :- sum(T, S1), S is S1 + H.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 26.10.2016 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nth([H|_], 0, H).
nth([_|T], N, X) :- N1 is N - 1, nth(T, N1, X).

% set operations generators
intersection_generator(A, B, X) :- member(X, A), member(X, B).

union_generator(A, _, X) :- member(X, A).
union_generator(_, B, X) :- member(X, B).

difference_generator(A, B, X) :- member(X, A), not(member(X, B)).

% number generators
natural(0).
natural(N) :- natural(N1), N is N1 + 1.

odd(1).
odd(N) :- odd(N1), N is N1 + 2.

even(0).
even(X) :-  even(X1), X is X1 + 2.

fibonacci_(0, 1).
fibonacci_(Y, Z) :- fibonacci_(X, Y), Z is X + Y.
fibonacci(N) :- fibonacci_(N, _).

% todo: must understand reverse with stack and subsets


% a(0) = a(1) = a(2) = 1
% a(n + 3) = 2*a(n) + a(n + 1) + 0* a(n)
% a(n), a(n+1), a(n+2), a(n+3xxx`)
a(1, 1, 1).
a(Y, Z, T) :- a(X, Y, Z), T is 2 * X + Y + Z.

% wrong way, it's never going to stop
n10_wrong(X) :- natural(X), X < 3.

n100(X) :- between(X, 0, 99).

between(A, A, B) :- A =< B.
between(X, A, B) :- A < B,
                    A1 is A + 1,
                    between(X, A1, B).

pairs(X, Y) :- natural(S),
               between(X, 0, S),
               Y is S - X.
