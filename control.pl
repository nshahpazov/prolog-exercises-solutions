p(L) :- not((
    member(X, L),
    member(Y, L),
    X \== Y,
    not((
      member(Z, L),
      Z \== X, Z \== Y,
      member(A, Z),
      not(member(A, X)),
      not(member(A, Y))
    ))
  )).


gcd(0, X, X) :- X > 0.
gcd(X, Y, Z) :- X > 0, X >= Y, X1 is X - Y, gcd(X1, Y, Z).
gcd(X, Y, Z) :- X > 0, X < Y, gcd(Y, X, Z).


