% generate a subsequence
between(A, A, B) :- A =< B.
between(X, A, B) :- A < B,
                    A1 is A + 1,
                    between(X, A1, B).

% TODO: check out what is this!
% between_(I,J,K) is true if K is an integer between I and J inclusive.

between_(I, J, I) :- I =< J.
between_(I, J, K) :- I < J,  I1 is I+1,  between_(I1, J, K).
