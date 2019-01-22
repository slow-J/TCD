s --> us(Count), [2], vs(Count2), {Count is (2*Count2)}.

us(0)     --> [].
us(Count) --> [0], us(Prev), {Count is Prev+1}.
us(Count) --> [1], us(Count).

vs(0)     --> [].
vs(Count2) --> [1], vs(Prev), {Count2 is Prev+1}.
vs(Count2) --> [0], vs(Count2).