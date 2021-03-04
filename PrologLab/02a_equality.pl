father(dale, sarah).
father(dale, eric).

sibling(X, Y) :- father(F, X), father(F, Y).

