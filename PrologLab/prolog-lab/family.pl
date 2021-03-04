mother(a,b).              
mother(a,c).
mother(b,d).
mother(b,e).
mother(c,f).

sibling(X,Y):- mother(A,X),mother(A,Y),not(X=Y).
cousin(X, Y):- mother(A,X),mother(B,Y),sibling(A,B),not(X=Y).
grandchild(X, Y):- mother(Y,A),mother(A,X).

descendent(X, Z):- mother(X,Y),descendent(Y,Z).
descendent(X, Z):- X = Z.