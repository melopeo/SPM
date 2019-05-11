function error_rate = classification_error_for_clustering(C_estimated, C_ground_truth)
% error_rate = classification_error_for_clustering(C_estimated, C_ground_truth)
% This function calculates the classification error of clustering
% assignment given a reference ground truth labeling
% INPUT : C_estimated    : vector with cluster assignments
%       : C_ground_truth : vector with ground truth labels
% OUTPUT: error_rate     : classification error

numObs     = length(C_estimated);
Cout       = label_through_majority_vote(C_estimated, C_ground_truth);
error_rate = sum(Cout ~= C_ground_truth)/numObs;