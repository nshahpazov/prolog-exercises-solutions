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

% p1000 :- generates all natural numbers less than 1000 which are sums of squares of 4 natural numbers
p1000(X) :- between(X1, 0, 32),
            between(X2, 0, 32),
            between(X3, 0, 32),
            between(X4, 0, 32),
            X is X1 * X1 + X2 * X2 + X3 * X3 + X4 * X4,
            X < 1000.

% or just this solution
p1000_(X) :- between(X, 0, 999).


%%%%%%%%%%%%%%%%%%%% 02.11.16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tree structure generator
% [] - tree
% [A, B] - tree when A and B are trees
tree(T) :- natural(N), tree(T, N).

tree([], 0).
tree([A, B], N) :- N > 0,
                   N1 is N - 1,
                   between(K, 0, N1),
                   M is N1 - K,
                   tree(A, K),
                   tree(B, M).

% cartesian(L, X ~ [[a,b,c,d], [1,2,3,4]]) :- generates in L all the possible cartesian producsts of X
cartesian([], []).
cartesian([H|T], [L1|Ls]) :- member(H, L1), cartesian(T, Ls).

% list_of_sum(S, L) :- genrates in L the members whih form a sum in S
list_of_sum(0, []).
list_of_sum(S, [H|T]) :- between(H, 1, S),
                         M is S - H,
                         list_of_sum(M, T).



% split(L, M) :- concat(M) = L where L is list of lists
split([], []).
split(L, [H|T]) :- append(H, R, L),
                    H \= [],
                   split(R, T).

% generate in X1, Y1 coordinates of points in (Circle X, Y, Radius) - solve by yourself
%% in_circle(X, Y, R, X1, Y1).

% knight moves generation
% knight(X, Y, P) :- P is path so far, [X, Y] is start

% generates all possible moves from given position

% check whether a coordinate is inside the allowed dimension
in(Coord) :- Coord >= 1, Coord =< 8.

% move(X, Y, X1, Y1) :- [X, Y] - where it is, [X1, Y1] - generated values:
move(X, Y, X1, Y1) :- X1 is X - 1,
                      in(X1),
                      Y1 is Y - 2,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X - 1,
                      in(X1),
                      Y1 is Y + 2,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X + 1,
                      in(X1),
                      Y1 is Y - 2,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X + 1,
                      in(X1),
                      Y1 is Y + 2,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X - 2,
                      in(X1),
                      Y1 is Y - 1,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X - 2,
                      in(X1),
                      Y1 is Y + 1,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X + 2,
                      in(X1),
                      Y1 is Y - 1,
                      in(Y1).

move(X, Y, X1, Y1) :- X1 is X + 2,
                      in(X1),
                      Y1 is Y + 1,
                      in(Y1).

knight(X, Y, P) :- dfs(X, Y, [[X, Y]], P).

% (X, Y) is start, V are visited, P is the path so far
% length has to be 64 since we want the knight to go through all the positions on the board
dfs(_, _, Visited, Visited) :- length(Visited, 64).
dfs(X, Y, V, P) :- move(X, Y, X1, Y1),
                   not(member([X1, Y1], V)),
                   % append (X1, Y1) in front of the visited list
                   dfs(X1, Y1, [[X1, Y1]|V], P).

% common prime denominators
% cpd(X, Y).

% X is divisor of Y
diviseur(X, Y) :- Y mod X =:= 0.

prime(P) :- P1 is P - 1,
            not((
              between(X, 2, P1),
              diviseur(X, P)
            )).

prime_divisors(P, X) :- between(P, 2, X),
                        prime(P),
                        diviseur(P, X).

ds(X, Y) :- not((
              prime_divisors(P, X),
              not(diviseur(P ,Y))
            )).

cpd(X, Y) :- ds(X, Y), ds(Y, X).

path_(_, X, X, V, P) :- reverse([X|V], P).
path_(Graph, X, Y, V, P) :- arc(Graph, X, T),
                        not(member(T, V)),
                        path_(Graph, T, Y, [X|V], P).
path(Graph, X, Y, P) :- path_(Graph, X, Y, [], P).

% graphs - path and connected
connected([V, E]) :- not((
                        member(X, V),
                        member(Y, V),
                        not((path([V, E], X, Y, _) ; path([V, E], Y, X, _)))
                      )).

arc([_, E], X, Y) :- member([X, Y], E).

% spanning tree(Graph, Visited, N, E, R).
% not finished
%% stree(G, V, [], E, E).
%% stree([V1, E1], V, N, E, R) :- member(X, V),
%%                                member(Y, N),
%%                                arc([V1, E1], X, Y),
%%                                remove(Y, N, N1),
%%                                stree([V1, E1], [Y|V], [[X,Y]|E], R).

graph([[a, b, c, d, e], [[a, b], [b, c], [c, d], [d, e]]]).

isList([]).
isList([_|_]).
flatten([], []).
flatten([L|Ls], F) :- isList(L),
                      flatten(L, FL),
                      flatten(Ls, FLs),
                      append(FL, FLs, F).

flatten([H|Ls], [H|F]) :- not(isList(H)),
                          flatten(Ls, F).
