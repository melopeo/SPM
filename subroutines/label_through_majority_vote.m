function Cout = label_through_majority_vote(C, reference_label)
% Cout = label_through_majority_vote(C, reference_label)
% This function labels clusters through a reference label assignment,
% through majority vote
% INPUT : C               : cluster assignment
%       : reference_label : reference label
% OUTPUT: Cout            : labeled cluster assignment

C               = C(:);
reference_label = reference_label(:);

Cout      = inf(size(C));
label_idx = unique(C);

for i = 1:length(label_idx)
    loc          = C == label_idx(i);
    mode_cluster = mode( reference_label(loc) );
    Cout(loc)    = mode_cluster;
end
