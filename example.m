function example

restoredefaultpath
addpath(genpath('utils'))
addpath(genpath('subroutines'))
addpath(genpath('SpectralClusteringOfSignedGraphsViaMatrixPowerMeans'))

%% Example where the first layer is informative and the second is not informative
numLayers                 = 2;
numNodes                  = 100;
numClusters               = 2;
groundTruth               = zeros(numNodes,1);
groundTruth(1:numNodes/2) = 1;
GroundTruthPerLayerCell   = {groundTruth, groundTruth};
pinVec                    = [0.9 0.8];
poutVec                   = [0.1 0.2];
s                         = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
Wcell                     = generate_multilayer_graph(numLayers, GroundTruthPerLayerCell, pinVec, poutVec);

% visualize adjacency matrices
figure, hold on
subplot(1,2,1), spy(Wcell{1}), title('Positive Edges')
subplot(1,2,2), spy(Wcell{2}), title('Negative Edges')

figure, hold on
% Clustering with p = 10
p           = 10; 
s           = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
C           = clustering_signed_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
subplot(1,5,1), stem(C), title('p=10')
1;

% Clustering with p = 1 (Arithmetic Mean)
p           = 1; 
s           = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
C           = clustering_signed_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
subplot(1,5,2), stem(C), title('p=1')
1;
1;

% Clustering with p -> 0 (log euclidean Mean)
p           = 1; 
s           = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
C           = clustering_signed_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
subplot(1,5,3), stem(C), title('p->0')
1;
1;

% Clustering with p = -1 (Harmonic Mean)
p           = -1; 
s           = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
C           = clustering_signed_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
subplot(1,5,4), stem(C), title('p=-1')
1;
1;

% Clustering with p = -10 
p           = -10; 
s           = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
C           = clustering_signed_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
subplot(1,5,5), stem(C), title('p=-10')
1;
1;


