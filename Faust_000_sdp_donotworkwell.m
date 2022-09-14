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

q_range = [3,4];

for kk = 1 : 2

    switch kk
        case 1
            n = 50;
        case 2
            n = 300;
    end

    for q = q_range

        fprintf('Complexity Constrained Regression with q = %d...\n',q)
        A_best = vertexfit_sdp(unit_vectors(:,1:n),support_result(:,1:n),q,params);   % Regression Step

        %% Step 3a: Print figure to screeen + Save to disk
        cvxprinter_3d(A_best);
        axis auto
        pbaspect([1,1,1])
        view([144,12])
        filename = strcat('figures/Exp_Faust',int2str(q),'_n',int2str(n));
        print(filename,'-dpdf')

    end

    %% Step 3b : Least Squares Regression
    A_LS = vertexfit_LSE(unit_vectors(:,1:n), support_result(:,1:n) );

    %% Save to disk
    cvxprinter_3d(A_LS);
    filename = strcat('figures/Exp_Faust_LS_n',int2str(n));
    print(filename,'-dpdf')

end