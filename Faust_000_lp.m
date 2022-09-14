%% Step 1a
% Add paths
clear; close all; clc; addpath('codes'); addpath('objmesh'); addpath('lungct')
fprintf('########################################################\n')
fprintf('#Reconstructing the Faust Dataset Scan 000 from supp fn evaluations#\n')
fprintf('########################################################\n\n')
rng(626)

%% Step 2: Warm Start
% Load the file if it is available on disk

load('lungct/tr_scan_000_vertices.mat')
load('lungct/tr_scan_000_random_unit_vectors.mat')
load('lungct/tr_scan_000_support_result.mat')
%% Step 3: Regression
params = {};
params.InnerIterates = 200;
params.OuterIterates = 20;
d = 3;          % Ambient dimension

q_range = [12];

for kk = 3 

    switch kk
        case 1
            n = 100;
        case 2
            n = 200;
        case 3
            n = 500;
    end

    for q = q_range

        fprintf('Complexity Constrained Regression with q = %d...\n',q)
        A_best = vertexfit_lp(unit_vectors(:,1:n),support_result(:,1:n),q);   % Regression Step
  %%  cvxprinter_master(A_best,struct('savepath',strcat('figures/Faust/Faust 000/Faust_000_nl_',int2str(n))));

        %% Step 3a: Print figure to screeen + Save to disk
        cvxprinter_3d(A_best)
        axis off
        pbaspect([1,2,1])
        view([144,12])
        filename = strcat('figures/Exp_Faust_lp',int2str(q),'_n',int2str(n));
        print(filename,'-dpdf')

    end

   

end