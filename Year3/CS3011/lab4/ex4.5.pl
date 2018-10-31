tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine). 

listtran([],[]).
%listtran(X,Y) :- tran(X, Y).
%listtran(X,[Y|T]) :-tran(X,T).

listtran([X|Xi],[Y|Yi]) :- tran(X,Y), listtran(Xi,Yi).