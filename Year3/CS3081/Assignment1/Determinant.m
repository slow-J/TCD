function D = Determinant(A)
[n, m]=size(A);  % n= no. of rows in A, m= no. of columns in A

if n ~= m     % check if A is square
    D ='The matrix must be square';  
    
elseif n > 4 % check if bigger than 4x4
    D ='Matrix too big';  
    
elseif n == 2 % 2x2 matrix determinant
	D = A(1,1)*A(2,2) - A(1,2)*A(2,1);  
          
elseif n == 3 % 4x4 matrix
    % 3 new matrixes, ready for recursive call
    M1 = [A(2,2),A(2,3);A(3,2),A(3,3)];
    M2 = [A(2,1),A(2,3);A(3,1),A(3,3)];
    M3 = [A(2,1),A(2,2);A(3,1),A(3,2)];
    % recursive call below to 2x2 matrix
	D = A(1,1)*Determinant(M1) -  A(1,2)*Determinant(M2) +  A(1,3)*Determinant(M3);
elseif n == 4  %4x4 matrix
    % 4 matrixes
    M1 = [A(2,2),A(2,3),A(2,4); A(3,2),A(3,3),A(3,4); A(4,2),A(4,3),A(4,4)];
    M2 = [A(2,1),A(2,3),A(2,4); A(3,1),A(3,3),A(3,4); A(4,1),A(4,3),A(4,4)];
    M3 = [A(2,1),A(2,2),A(2,4); A(3,1),A(3,2),A(3,4); A(4,1),A(4,2),A(4,4)];
    M4 = [A(2,1),A(2,2),A(2,3); A(3,1),A(3,2),A(3,3); A(4,1),A(4,2),A(4,3)];
    % calling recurisvely the function with 4, 3x3 matrixes
	D = A(1,1)*Determinant(M1)-A(1,2)*Determinant(M2) + A(1,3)*Determinant(M3)-A(1,4)*Determinant(M4);
end     