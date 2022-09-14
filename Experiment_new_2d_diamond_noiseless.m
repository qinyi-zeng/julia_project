%% Square in R2, Noiseless measurements
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('####################################################################\n')
fprintf('#Reconstructing the diamond in R^2 from noiseless support fn evals.#\n')
fprintf('####################################################################\n\n')
rng(626)

%% Problem Parameters
n = 200;
d = 3;
sigma = 0.0;
[u_mat_all, h_vec_all] = gen_cvxsupp('diamond',n);
h_vec_all = h_vec_all + sigma * randn(size(h_vec_all));

%% Fit using AM Algorithm

q = 4;

for kk = 1

switch kk
    case 1
        n = 20;
    case 2
        n = 50;
    case 3
        n = 100;
    case 4
        n = 150;
    case 5
        n = 200;
end

h_vec = h_vec_all(:,1:n);
u_mat = u_mat_all(:,1:n);
    
%% Complexity Constrained Regression
fprintf('AM implementation. Number of measurements: %d\n',n)
A_am = vertexfit_lp(u_mat,h_vec,q);
cvxprinter_master(A_am,struct('savepath',strcat('figures/2D/L1_diamond/Exp_2d_diamond_AM_nl',int2str(n))));

end

for kk = 1

switch kk
    case 1
        n = 20;
    case 2
        n = 50;
    case 3
        n = 100;
    case 4
        n = 150;
    case 5
        n = 200;
end

h_vec = h_vec_all(:,1:n);
u_mat = u_mat_all(:,1:n);

%% Least Squares Estimate
fprintf('Least Squares Regression. Number of measurements: %d\n',n)
A_LS = vertexfit_LSE(u_mat,h_vec);
cvxprinter_master(A_LS,struct('savepath',strcat('figures/2D/L1_diamond/Exp_2d_diamond_LSE_nl',int2str(n))));

end