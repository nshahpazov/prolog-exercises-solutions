heads([], []).
heads([[H|_]|HT], [H|TT]) :- heads(HT, TT).

tails([], []).
tails([[_|T]|HT], [T|TT]) :- tails(HT, TT).

nthc(H, M, 1) :- heads(M, H).
nthc(C, M, N) :- tails(M, T), N1 is N - 1, nthc(C, T, N1).

le([[]]).
le([[]|L]) :- le(L).

t(L, []) :- le(L).
t(M, [H|TT]) :- heads(M, H), tails(M, T), t(T, TT).

sk([A], [B], AB) :- AB is A * B.
sk([HA|TA], [HB|TB], AB) :- sk(TA, TB, AB1), AB is AB1 + (HA * HB).


prod([], _, [], N, N).
prod([_|A], B, [_|AB], N, N) :- write(A), prod(A, B, AB, 1, N).
prod([RA|A], B, [RAB|AB], I, N) :- write(I), I < N, nthc(CIB, B, I), nth(C, RAB, I), sk(RA, CIB, C), I1 is I + 1, prod([RA|A], B, [RAB|AB], I1, N).
%m(A, B, AB) :-  nth(A, B, AB, 1), 
