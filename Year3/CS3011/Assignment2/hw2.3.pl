s(0) --> [].
s(X) --> { mkList(X, OutputList), member(Number, OutputList), NumbersLeft is X-Number }, 
    [Number], s(NumbersLeft).
    
mkList(0, []).
mkList(H, [H|T]) :- X is H-1, H>0, mkList(X, T).
