function Ainv = Inverse (A)
[n, m]=size(A);  % n= no. of rows in A, m= no. of columns in A
if n ~= m     % check if A is a square matrix
    Ainv ='The matrix must be square';
    return
end
if n == 0     % check if A is empty
    Ainv ='Matrix cant be empty';
    return
end

Ainv = eye(n); % set up identity matrix
for r = 1 : n
    for c = r : n
        if A(c,r) ~= 0 % cannot operate a division on a zero
            t = 1/A(r,r); % left val of row being operated on
            for i = 1 : n
                %getting A(r,k) to be 1
                A(r,i) = t * A(r,i);
                %repeat calculation on identity matrix
                Ainv(r,i) = t * Ainv(r,i); 
            end
            %looking for not diagonal elements
            for i = 1 : n
                if i ~= r % if count doesnt equal row
                    % for rows that 
                    t = -A(i,r);
                    for j = 1 : n
                        % subtracting to get the element to be zero
                        A(i,j) = A(i,j) + t * A(r,j);
                        Ainv(i,j) = Ainv(i,j) + t * Ainv(r,j);
                    end
                end
            end
        end
        break
    end
end
