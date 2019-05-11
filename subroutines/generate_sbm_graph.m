function [A,flag] = generate_sbm_graph(C, pin, pout)
% function [A,flag] = generate_sbm_graph(C, pin, pout)
% This Function generates a random graph following the SBM distribution
% with parameters pin and pout.
% 
% INPUT:
% C                : (array) cluster idx per node 
% pin              : (scalar) probability of edge inside clusters
% pout             : (scalar) probability of edge between clusters
% OUTPUT: 
% A                : random matrix
% flag             : (boolean). True if output graph is connected. 

% Credits: this code is partially based on the code related to the paper:
% Saade, A., Krzakala, F., & Zdeborová, L. (2014). 
% Spectral clustering of graphs with the bethe hessian. 
% In Advances in Neural Information Processing Systems (pp. 406-414).

% sort nodes by clustering
[C_sorted, idx_sort] = sort(C);
[~, idx_rev]         = sort(idx_sort); 

labels           = unique(C_sorted);
numClusters      = length(labels);
clusterSizeArray = zeros(numClusters,1);
for i = 1:numClusters
    clusterSizeArray(i) = sum(C_sorted == labels(i));
end

N    = sum(clusterSizeArray);    % total number of nodes
q    = length(clusterSizeArray); % number of clusters

cumulativeClusterSize = cumsum(clusterSizeArray);
idxStartCluster       = [1; cumulativeClusterSize(1:end-1)+1];
idxEndCluster         = cumulativeClusterSize;
1;

A=sparse(N,N);

% Build diagonal blocks (blocks based on pin)
for i=1:q
    block_size    = clusterSizeArray(i);
    current_block = sprand(block_size,block_size,pin);
    current_block = (current_block~=0);
    current_block = triu(current_block,1);
    current_block = current_block+current_block';
    A(idxStartCluster(i):idxEndCluster(i), idxStartCluster(i):idxEndCluster(i)) = current_block;
1;
end
1;

% Build blocks between clusters (blocks based on pout)
for i=1:q
    block_size_i = clusterSizeArray(i);

    for j=i+1:q
        block_size_j = clusterSizeArray(j);

        current_block=sprand(block_size_i,block_size_j,pout);
        current_block=(current_block~=0);

        A(idxStartCluster(i):idxEndCluster(i), idxStartCluster(j):idxEndCluster(j)) = current_block;
        A(idxStartCluster(j):idxEndCluster(j), idxStartCluster(i):idxEndCluster(i)) = current_block';

        1;
    end
end
    
% Check if generated graph is connected
d = sum(A,1);
if(sum(d==0)>0) 
  disp('Warning: there exist isolated points with degree 0'); 
  flag = 0;
else
  flag = 1;
end

% Return to original ordering of nodes
A = A(idx_rev,idx_rev);