%% out(L, X, R) :- append(A, [X | B], L), append(A, B, R).
%% subsetgen(L, [X | Q]) :- out(L, X, R), subsetgen(R, Q).
%% subsetgen(L, Q) :- out(L, X, R), subsetgen(R, Q).
%% perm(L, [X | Q]) :- out(L, X, R), perm(R, Q).
%% perm([], []).
%% take([H | Q], N, L) :- L = [H | L1], N is N1 + 1, take(Q, N1, L1).
%% subset3gen(L, S) :- perm(L, M), take(M, 3, S).

intgen(0).
intgen(N) :- intgen(N1), N is N1 + 1.

tuple(0, _, []).
tuple(N, S, [A | Q]) :- N > 0, between(0, S, A), S1 is S - A, N1 is N - 1,
    tuple(N1, S1, Q).

triple(L) :- intgen(S), tuple(3, S, L).

pythagorean(A, B, C) :- A * A + B * B =:= C * C.

p(X, N, M, K) :- triple(L), L = [N, M, K], pythagorean(N, M, K), S is N+M+K,
    member(X, Y), member(Y, Z), S < Z, not(member(X, Y1), Y1 = [_, SE | _],
    (member(SE, M); member(SE, N))), member(X, Y2), K is sum(Y2).
