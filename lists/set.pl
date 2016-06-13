% makes a set by removing duplicates
set([], []).
set([H|T], [H|R]) :- not(member(H, T)), set(T, R).
set([H|T], R) :- member(H, T), set(T, R).

% another way is to sort and compress
set_(Xs, Ys) :- sort(Xs, Zs), compress(Zs, Ys).

% A wrong way to do it is the following:
% this will not work because it will first try to match member([], _G1234)
% which will fail and cause the backtracking to try again with the
% previous head and attach it again
%% wrong_set([], []).
%% wrong_set([H|T], [H|Y]) :- not(member(H, Y)), wrong_set(T, [H|Y]).
%% wrong_set([H|T], Y) :- member(H, Y), wrong_set(T, Y).
