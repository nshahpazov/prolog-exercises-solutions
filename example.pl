diff([]).
diff(L) :- X \= 1, not(member(X, L)).

likes(_, pom).
