s --> house(Col1, Nat1, Pet1), house(Col2, Nat2, Pet2), house(Col3, Nat3, Pet3),
    {Col1 \= Col2, Col1 \= Col3, Col2 \= Col3, Nat1 \= Nat2, Nat1 \= Nat3, Nat2 \= Nat3, 
        Pet1 \= Pet2, Pet1 \= Pet3, Pet2 \= Pet3}.

house(Col, Nat, Pet) --> colour(Col), national(Nat), pet(Pet).

colour(red)   --> [red].
colour(blue)  --> [blue].
colour(green) --> [green].

national(english)  --> [english].
national(japanese) --> [japanese].
national(spanish)  --> [spanish].

pet(snail)  --> [snail].
pet(jaguar) --> [jaguar].
pet(zebra) --> [zebra].