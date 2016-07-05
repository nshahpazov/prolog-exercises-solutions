%rotate([a, b, c, d, e, f, g, h], 3, X).
%X = [d, e, f, g, h, a, b, c]
% use split
rotate(Xs, N, Rs) :- split(Xs, N, Ys, Zs),
                     append(Zs, Ys, Rs).