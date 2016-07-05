%% insert_at(alfa, [a, b, c, d], 2, L).
%% L = [a, alfa, b, c, d].
insert_at([X|Xs], El, 1, [El, X|Xs]).
insert_at([X|Xs], El, I, [X|Rs]) :- I > 1,
                                    I1 is I - 1,
                                    insert_at(Xs, El, I1, Rs).