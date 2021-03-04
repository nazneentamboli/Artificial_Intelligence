double(X, Y) :- Y is X*2.

older_than(X, Y) :- age(X, A1), age(Y, A2), A1 > A2.
age(fannie, 35).
age(flo, 34).

factorial(1,1).
factorial(X, R) :- XX is X-1, factorial(XX, T), R is  X * T.

