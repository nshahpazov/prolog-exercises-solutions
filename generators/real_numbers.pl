% generate real numbers
z(X) :- e(E),
        member(Z, [-1, 1]),
        X is E * Z.
