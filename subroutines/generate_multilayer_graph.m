function W_cell = generate_multilayer_graph(numLayers, GroundTruthPerLayerCell, pinVec, poutVec)
% W_cell = generate_multilayer_graph(numLayers, GroundTruthPerLayerCell, pinVec, poutVec)
% Generates a multilayer graph under the Stochastic Block Model
% INPUT: numLayers: number of layers in multilayer graph
%      : GroundTruthPerLayerCell: cell with groundtruth clustering per layer
%      : pinVec : vector with probabilities of observing an edge between
%      nodes that belong to the same cluster. i-th entry corresponds to
%      the i-th layer
%      : poutVec : vector with probabilities of observing an edge between
%      nodes that belong to the different clustesr.  i-th entry corresponds to
%      the i-th layer

    if isscalar(pinVec) 
        pinVec = pinVec*ones(numLayers,1);
    end
 
    if isscalar(poutVec) 
        poutVec = poutVec*ones(numLayers,1);
    end

    W_cell = cell(numLayers,1);
    for i = 1:numLayers
        flag = false;
        while ~flag
            [W,flag] = generate_sbm_graph(GroundTruthPerLayerCell{i}, pinVec(i), poutVec(i));
        end
        W_cell{i} = W;
    end