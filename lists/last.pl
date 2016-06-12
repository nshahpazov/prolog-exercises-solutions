last([X|[]], X).
last([X|T], Y)) :- last(T, Y).