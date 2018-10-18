pterm(null).
pterm(f0(X)) :- pterm(X).
pterm(f1(X)) :- pterm(X).

incr(null, X) :- X = f1(null).
incr(f0(X), f1(X)).
incr(f1(X), f0(X, Y)) :- incr(X, Y).

legal(f0(null)).
legal(X) :- legal(Y), incr(Y,X).

add(f0(null)).
add(X1, Y, Z1) :- add(X, Y, Z), incr(X, X1), incr(Z, Z1).

mult(f1(null), X, X).
mult(f0(X), Y, f0(Z)) :- mult(X, Y, Z).
mult(f1(X), Y, Z1) :- mult(f0(X), Y, Z), add(Z, Y, Z1). 

revers(L1,L2):- accReverse(L1, null, L2).
accReverse(null, L, L). 
accReverse(f0(X), Y, Rev):- accReverse(X, f0(Y), Rev).
accReverse(f1(X), Y, Rev):- accReverse(X, f1(Y), Rev).

% enc(null) = 0.
 
% test add inputting numbers N1 and N2

testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
add(T1,T2,SumT), pterm2numb(SumT,Sum).

% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).

% test revers inputting list L

testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).

% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).

% make a pterm T from a number N    numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).

% make a number N from a pterm T  pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.

% reversible  ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).
