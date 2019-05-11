function C_cell_power_mean = run_experiment_SBM(pinVec, poutVec, numRuns, numClusters, GroundTruthPerLayerCell, numLayers, pArray, diagShiftArray, method_str)
% Obtain clusters through the power mean Laplacian for different runs of
% the Stochastic Block Model
    C_cell_power_mean = cell(numRuns,1);
    for i = 1:numRuns
        s                    = RandStream('mcg16807','Seed',i); RandStream.setGlobalStream(s);
        W_cell               = generate_multilayer_graph(numLayers, GroundTruthPerLayerCell, pinVec, poutVec);
        C_cell_power_mean{i} = get_clusters_from_signed_with_power_mean_Laplacian(W_cell, numClusters, pArray, method_str, diagShiftArray);
    end

function C_cell = get_clusters_from_signed_with_power_mean_Laplacian(W_cell, numClusters, pArray, method_str, diagShiftArray)
% Obtain clusters through the power mean laplacian for different powers  
    C_cell = cell(length(pArray),1);
    for j = 1:length(pArray)
        p         = pArray(j);
        diagShift = diagShiftArray(j);
        s         = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
        C_cell{j} = clustering_signed_graphs_with_power_mean_laplacian(W_cell, p, numClusters, diagShift, method_str);
    end
