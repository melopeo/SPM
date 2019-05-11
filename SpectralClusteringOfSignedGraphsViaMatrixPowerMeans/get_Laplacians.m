function matrix_cell = get_Laplacians(adjacency_cell, diagShift)
% matrix_cell = get_Laplacians(adjacency_cell, str_cell, p)
% This function gets the Laplacian or Signed Laplacian for each adjacency
% matrix given in adjacency_cell, and adds a shift according to the
% parameters p
% INPUT : adjacency_cell :  cell array of adjacency matrices
%                        : adjacency_cell{1}: adjacency matrix of positive edges
%                        : adjacency_cell{2}: adjacency matrix of negative edges
%       : diagShift      : scalar for diagonal shift of Laplacians
% OUTPUT: matrix_cell    : cell array with Laplacian matrices:
%                        : matrix_cell{1}: has Laplacian of positive edges  
%                        : matrix_cell{2}: has signless Laplacian of negative edges  

if nargin < 2
    diagShift = 0;
end

numMatrices = length(adjacency_cell);          % number of layers
n           = size(adjacency_cell{1},1);       % number of nodes
matrix_cell = cell(numMatrices,1);
   
% layer with normalized Laplacian
W              = adjacency_cell{1};
L              = build_laplacian_matrix(W);
matrix_cell{1} = L;

% layer with normalized signlessLaplacian
W              = adjacency_cell{2};
Q              = build_signless_laplacian_matrix(W);
matrix_cell{2} = Q;

% apply shift
matrix_cell = cellfun(@(x) x + diagShift*speye(n), matrix_cell, 'UniformOutput', false);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function L = build_laplacian_matrix(W)
% L = build_Laplacian_matrix(W)
% This function builds a sparse Laplacian Matrix
% input:  W (matrix)    : adjacency matrix
% output: L (matrix)    : sparse Laplacian matrix
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

n               = size(W,1);              % size of graph
d               = sum(W,2);               % degree vector
dInv            = 1./d;                   % d_in^{-1}                   
dInv(d == 0)    = 0;                      % take care of isolated nodes

dInv         = dInv.^(0.5);            % d^{-1/2}
DInv         = spdiags(dInv, 0, n, n); % D^{-1/2}

% Symmetric Laplacian
L = spdiags(d ~= 0, 0, n, n) - DInv*W*DInv; 

% enforce symmetry
L = (L  + L')/2;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function L = build_signless_laplacian_matrix(W)
% L = build_Laplacian_matrix(W)
% This function builds a sparse Laplacian Matrix
% input:  W (matrix)    : adjacency matrix
% output: L (matrix)    : sparse Laplacian matrix
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

n               = size(W,1);              % size of graph
d               = sum(W,2);               % degree vector
dInv            = 1./d;                   % d^{-1}                   
dInv(d == 0)    = 0;                      % take care of isolated nodes

dInv         = dInv.^(0.5);            % d^{-1/2}
DInv         = spdiags(dInv, 0, n, n); % D^{-1/2}

% Symmetric Laplacian
L = spdiags(d ~= 0, 0, n, n) + DInv*W*DInv; 

% enforce symmetry
L = (L + L')/2;
