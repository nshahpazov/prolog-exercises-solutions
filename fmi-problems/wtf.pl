p([], _).
p([H | Q], M) :- (H >= 5, X is H + 5; X is H), M = [X | M1], p(Q, M1).
