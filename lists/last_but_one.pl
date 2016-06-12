last_but_one([H|[_|[]]], H).
last_but_one([_|T], H2) :- last_but_one(T, H2).
