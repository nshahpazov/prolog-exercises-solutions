memberpos([H | _], 0, H).
memberpos([_ | Q], N, X) :- N is N1+1, memberpos(Q, N1, X).

len([], 0).
len([_ | Q], N) :- N is N1+1, len(Q, N1).

specialcond(L, N, K) :- KD is 2*K, memberpos(L, KD, X),
    (KP2 is K+2, between(1, N, KP2), memberpos(L, KP2, Y), between(1, N, Y),
    memberpos(L, Y, X); memberpos(L, K, Z), X is 2*Z+2).

special(L) :- len(L, N), NH is N/2, between(0, NH, K), specialcond(L, N, K).
