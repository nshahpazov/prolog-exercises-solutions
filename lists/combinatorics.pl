% rand permutation of a list
% ?- rand_perm([a, b, c, d, e, f], L).
% L = [b, a, d, c, e, f]
rand_perm([], []).
rand_perm(L, R) :- len(L, LEN), rand_sublist(L, LEN, R).

% if X is element return the tail of it
el(X, [X|L], L).
el(X, [_|L], R) :- el(X, L, R).

% combination(3, [a, b, c, d, e, f], L).
% note: understand it well
% L = [a, b, c], L = [a, b, d], ...
combination(0, _, []).
combination(K, L, [X|Xs]) :- K > 0,
  el(X, L, R), K1 is K - 1, combination(K1, R, Xs).

% p27
% a) In how many ways can a group of 9 people work in 3 
% disjoint subgroups of 2, 3 and 4 persons?
% Write a predicate that generates all the possibilities 
%   via backtracking.
% select N but avoid permutations
% selectN(N, L, R).
% group3(G, G1, G2, G3) :-
group3(G,G1,G2,G3) :-
  combination(2, G, G1),
  subtract(G, G1, R1),
  combination(3, R1, G2),
  subtract(R1, G2, R2),
  combination(4, R2, G3),
  subtract(R2, G3, []).

% makes a variations with X in front
% put(a, [1, 2, 3, 4], R).
% R = [[a, 1], [a, 2], [a, 3], [a, 4]]
put(X, [], []).
put(X, [H|T], [[X, H]|R]) :- put(X, T, R).

% cartesian product
cartesian([], _, []).
cartesian([H1|T1], S2, R) :- put(H1, S2, R1),
  cartesian(T1, S2, R2), append(R1, R2, R).

