function SBM_case_NegativeInformative

% Runs experiment corresponding to Figure 3a of our paper

% structure of signed graph:
% - 2 clusters
% - - Negative edges are informative

restoredefaultpath
addpath(genpath('utils'))
addpath(genpath('subroutines'))
addpath(genpath('SpectralClusteringOfSignedGraphsViaMatrixPowerMeans'))

dirName_Output_Data = 'SBM_case_NegativeInformative';
if ~exist(dirName_Output_Data,'dir')
    mkdir(dirName_Output_Data)
end

% Multilayer Graph data
sizeOfEachCluster   = 100;
numClusters         = 2;
numLayers           = 2;

% Ground Truth vector
GroundTruth         = [];
for i = 1:numClusters
    GroundTruth = [GroundTruth; i*ones(sizeOfEachCluster,1)];
end

% Setting ground truth per layer
GroundTruthPerLayerCell     = cell(numLayers,1);
for i = 1:numLayers
    GroundTruthPerLayerCell{i} = GroundTruth;
end

% Data for power means
pArray                 = [10,5,1,0,-1,-5,-10];
idxNeg                 = find(pArray<=0);

% Setting diagonal shift depending of value of power 'p'
diagShiftArray         = zeros(size(pArray))+1.e-6;
diagShiftArray(idxNeg) = log10(1+abs(pArray(idxNeg)))+1.e-6;

% computation method
method_str = 'eigs';
% method_str = 'polynomial_krylov';

% Mixing parameter
diffArray         = -0.05:0.005:0.05;
pin_Layer1_Array  = (0.1+diffArray)/2; %p_in of layer 1
pout_Layer1_Array = (0.1-diffArray)/2; %p_out of layer 2

pin_Layer2_Array  = 0.01*ones(size(diffArray)); %p_in of layer 2
pout_Layer2_Array = 0.09*ones(size(diffArray)); %p_out of layer 2

pin_input         = [pin_Layer1_Array(:)  pin_Layer2_Array(:) ]; %p_in per layer
pout_input        = [pout_Layer1_Array(:) pout_Layer2_Array(:)]; %p_out per layer
1;

% number of runs
numRuns = 50;

% Run experiment  
subdir = strcat(dirName_Output_Data, filesep, 'method_str_', method_str);%, '_diagShift_', num2str(diagShiftValue));
if ~exist(subdir,'dir')
    mkdir(subdir)
end

power_mean_error_mean_cell = cell(length(diffArray),1);

for i = 1:length(diffArray)

    pinVec                        = pin_input(i,:);
    poutVec                       = pout_input(i,:);

    C_cell_power_mean             = run_experiment_SBM(...
                                    pinVec, poutVec, numRuns, numClusters, GroundTruthPerLayerCell, numLayers, pArray, diagShiftArray, method_str);
    power_mean_error_mean_cell{i} = get_means(C_cell_power_mean, GroundTruth);

end

filename = strcat(subdir, filesep, 'output.mat');
save(filename, 'power_mean_error_mean_cell', '-v7.3')
% load(filename)
1;

% Plot
fig_handle = get_plot_SBM_1(power_mean_error_mean_cell, diffArray);
filename_prefix = strcat(subdir, filesep, 'plot');
save_plots(fig_handle, filename_prefix)
1;

function fig_handle = get_plot_SBM_1(power_mean_error_mean_cell, diffArray)

    dataMatrix = cell2mat(power_mean_error_mean_cell)';

    % plot Parameters
    [legendCell, colorCell, markerCell, LineStyleCell, LineWidthCell] = get_plot_parameters;
    MarkerSize      = [];
    fontSize        = 20;
    fontSize_legend = 20;

    xArray          = diffArray;
    legendLocation  = 'northeast';
    xAxisTitle_str = {'Positive Informative','\quad\,\, $G^+:p_{\mathrm{in}}^+ - p_{\mathrm{out}}^+$'};
    yAxisTitle_str  = 'Mean Clustering Error';
    title_str       = '\fontsize{15}{0} $ G^{-}: \mathbf{ p_{\mathrm{in}}=0.01,\,\,  p_{\mathrm{out}}=0.09}$';
    legendBoolean   = true;
    xTickArray      = [1,6,11,16,21];
    yTickArray      = 0:0.1:0.5;
    1;

    % plot!
    fig_handle = plot_performance(dataMatrix, xArray, legendCell, colorCell, LineStyleCell, markerCell, MarkerSize, LineWidthCell,legendLocation,xAxisTitle_str,yAxisTitle_str, title_str, fontSize,fontSize_legend,legendBoolean,xTickArray,yTickArray);

    % Create arrow
    annotation(fig_handle,'arrow',[0.24400871459695 0.78649237472767],...
        [0.0855928954621513 0.0855928954621513],'LineWidth',3,'HeadWidth',30,...
        'HeadLength',20);
