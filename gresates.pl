% this is another exam, not sure which exactly. I have to check and add later.

gresates(X, Y) :- member(B, Y),
                  not((
                    member(A, X),
                    not(B mod A =:= 0)
                  )).

q(L) :- not((
          member(X,L),
          not((
            member(Y, L),
            gresates(Y, X)
          ))
        )).
