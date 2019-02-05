
rng('shuffle')
numRolls=input('How many rolls you would like to simulate:');
counts = 0;
for r = 1 : numRolls
    roll1 =  randi(6,1,1);
    roll2 =  randi(6,1,1);
    roll3 =  randi(6,1,1);
    if (roll1 == 3 || roll2 ==3 || roll3 == 3)
        counts = counts + 1;
    end    
end
disp(counts/numRolls);
