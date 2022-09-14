%% Step 1a
% Add paths
clear; close all; clc; addpath('codes'); addpath('objmesh'); addpath('lungct')
fprintf('########################################################\n')
fprintf('#Reconstructing the Faust Dataset Scan 003 from supp fn evaluations#\n')
fprintf('########################################################\n\n')
rng(626)

%% Step 2: Warm Start
% Load the file if it is available on disk

load('faust scans\tr_scan_003_vertices.mat')
load('faust scans\tr_scan_003_random_unit_vectors.mat')
load('faust scans\tr_scan_003_support_result.mat')
%% Step 3: Regression
params = {};
params.InnerIterates = 200;
params.OuterIterates = 20;
d = 3;          % Ambient dimension

q_range = [12];

for kk = 1 : 2

    switch kk
        case 1
            n = 500;
        case 2
            n = 1000;
    end

    for q = q_range

        fprintf('Complexity Constrained Regression with q = %d...\n',q)
        A_best = vertexfit_lp(unit_vectors(:,1:n),support_result(:,1:n),q);   % Regression Step

        %% Step 3a: Print figure to screeen + Save to disk
        cvxprinter_3d(A_best);
        axis off
        pbaspect([1,2,1])
        view([144,12])
        filename = strcat('figures/Faust/Faust 003/Exp_Faust_003_lp',int2str(q),'_n',int2str(n));
        print(filename,'-dpdf')

    end
    %% Step 3b : Least Squares Regression
    %%A_LS = vertexfit_LSE(unit_vectors(:,1:n), support_result(:,1:n) );

    %% Save to disk
    %%cvxprinter_3d(A_LS);
    %%filename = strcat('figures/Exp_Faust_001_LS_n',int2str(n));
    %%print(filename,'-dpdf')
   

end
 %%Step 3b : Least Squares Regression
    m=500;
    A_LS = vertexfit_LSE(unit_vectors(:,1:m), support_result(:,1:m) );

    %% Save to disk
    cvxprinter_3d(A_LS);
    filename = strcat('figures/Faust/Faust 003/Exp_Faust_003_LS_n',int2str(m));
    print(filename,'-dpdf')