function Ret = InfinityNorm (A)
[n, m]=size(A);
if n ~= m     % check if A is a square matrix
    Ret ='The matrix must be square';
    return
elseif n == 0     % check if A is empty
    Ret ='Matrix cant be empty';
    return
else
    Ret=0;
    rowVal=0;
    for i = 1:n
        for j = 1:n
            elem = abs(A(i,j));
            rowVal = rowVal + elem;
        end
        if Ret < rowVal
            Ret = rowVal;
        end
    rowVal=0;
    end
end
