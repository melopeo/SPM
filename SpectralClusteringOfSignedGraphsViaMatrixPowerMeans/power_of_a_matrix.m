function FH = power_of_a_matrix(H,p)
% FH = power_of_a_matrix(H,p)
% This function calculates the power of a matrix, H^p, based on the spectral
% decomposition. 
% INPUT:  H   : matrix ( n x n )
%         p   : scalar
% OUTPUT: FH  : matrix ( n x n )

[V,D] = eig(H, 'vector');
Dp    = D.^p;
FH    = V*diag(Dp)*V';
FH    = 0.5*(FH + FH');
