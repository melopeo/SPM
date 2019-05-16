function C = clustering_signed_graphs_with_power_mean_laplacian(W_cell, p, numClusters, diagShift, method_str, krylovOpts)
% C = clustering_signed_graphs_with_power_mean_laplacian(W_cell, p, diagShift, method_str)
% INPUT: W_cell (cell)              : cell containing adjacency matrices:
%                                   : First entry (W_cell{1}) contains adjacency matrix of positive edges
%                                   : Second entry (W_cell{2}) contains adjacency matrix of negative edges
%        p (scalar)                 : p-th power of generalized matrix mean
%        diagShift (scalar)         : diagonal shift of Laplacians for the case where p<0
%                                     deafult:
%                                     - for p <= 0 : log10(1+abs(p))+1
%                                     - for p > 0  : zero
%        numClusters (scalar)       : number of clusters to compute
%        method_str (string)        : string defining computation method of
%                                     eigenvectors
%                                    options:
%                                    - 'direct' : first computes the power mean
%                                       Laplacian Lp and then the corresponding eigenvectors
%                                    - 'eigs' : first computes the power mean
%                                       Laplacian (Lp)^p (avoids the outer power '1/p' 
%                                       and then the corresponding
%                                       eigenvectors) and then the corresponding eigenvectors
%                                    - 'polynomial_krylov': matrix-free
%                                       polynomial krylov computation of
%                                       eigenvectors of power mean Laplacian Lp
% OUTPUT: C (array)                 : array with clustering assignments                                   

% Reference:
% @InProceedings{pmlr-v97-mercado18a,
%   title = 	 {Spectral Clustering of Signed Graphs via Matrix Power Means},
%   author = 	 {Pedro Mercado and Francesco Tudisco and Matthias Hein},
%   booktitle = 	 {Proceedings of the Thirty-sixth International Conference on Machine Learning},
%   pages = 	 {-},
%   year = 	 {2019},
%   editor = 	 {Kamalika Chaudhuri and Ruslan Salakhutdinov},
%   volume = 	 {97},
%   series = 	 {Proceedings of Machine Learning Research},
%   address = 	 {Long Beach, California},
%   month = 	 {09--15 June},
%   publisher = 	 {PMLR},
%   pdf = 	 {-},
%   url = 	 {-},
% }



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % Process input parameters % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% if diagonal shift is not given, set it depending on value of p
if nargin < 4 
    if p > 0
        diagShift = 0;
    else
        diagShift = log10(1+abs(p));
    end
end

if nargin < 5
    method_str = 'eigs';
end

if nargin < 6
    krylovOpts.tol   = 1.e-10;
    krylovOpts.maxIt = size(W_cell{1},1);
end

if isempty(diagShift)
    if p > 0
        diagShift = 0;
    else
        diagShift = log10(1+abs(p));
    end
end

% polynomial krylov method is designed only for negative powers
if (p>=0 && (strcmp(method_str, 'polynomial_krylov')==1))
    warning(['Polynomial Krylov method is developed only for negative powers (i.e. p<0). Computation will proceed with method_str = ''eigs'' '])
    method_str = 'eigs';
end

assert( numClusters >=2, 'Number of clusters (numClusters) has to be larger than one')

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % Clustering % % % % %  % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
matrix_cell                 = get_Laplacians(W_cell, diagShift);
[eigenvectors, eigenvalues] = get_eigenvectors_of_power_mean_laplacian(matrix_cell, p, numClusters, method_str, krylovOpts);
C                           = kmeans(eigenvectors, numClusters, 'Replicates', 10, 'emptyaction', 'singleton');
