%% Image Recon Script
% Objective: Conduct image reconstruction with AtlasViewer functions via
% script on the co-location study group data.
% Author: De'Ja Rogers, Yuanyuan Gao, and Laura Carlton

%% Set Paths
cd XXX % Path to AtlasViewer
setpaths
cd XXX % Path to Image Recon
path(path,cd)
cd XXX % Path to SSDOT Folder
path(path,cd)
cd XXX % Path to data

%% Load datasets and probe

load('Co-Location Study_Dataset_SplineSG.mat')
load('Co-Location Study_Dataset_SplineSG/fw/Adot.mat')
load('Co-Location Study_Dataset_SplineSG/fw/mesh_brain.mat')
load('Co-Location Study_Dataset_SplineSG/fw/Adot_scalp.mat')
load('Co-Location Study_Dataset_SplineSG/fw/mesh_scalp.mat')
load("probeIm.SD", "-mat")

%% Find active Channels

ml_SD=SD.MeasList;
[dcAvg, tHRF, ml_dcAvg] = output.dcAvg.GetDataTimeSeries('reshape:matrix');

[activeChLst_SDpairs, activeChLst_OD] = GetActiveChannels(dcAvg, ml_dcAvg, ml_SD, SD, 15); 

%% CONVERT TO OD 

dodAvg2 = hmrConc2OD(squeeze(dcAvg(:,:,:,2)), SD, [1,1]); % easy
dodAvg3 = hmrConc2OD(squeeze(dcAvg(:,:,:,3)), SD, [1,1]); % hard
dodAvg2 = dodAvg2(:,activeChLst_OD);
dodAvg3 = dodAvg3(:,activeChLst_OD);

%% GET VALUE OVER T RANGE 
trange = [5,18];
tHRF = output.dcAvg.time;

dodimg2 = hmrImageHrfMeanTwin(dodAvg2, tHRF, trange);
dodimg2(isnan(dodimg2)) = 0;

dodimg3 = hmrImageHrfMeanTwin(dodAvg3, tHRF, trange);
dodimg3(isnan(dodimg3)) = 0;

%% MASK ACCORDING TO ACTIVE CHANNELS AND SENSITIVE VERTICES
Adot = Adot(activeChLst_SDpairs,:,:);
Adot_scalp = Adot_scalp(activeChLst_SDpairs, :,:);

M = Make_mask(-2, Adot, Adot_scalp); % gives you only the sensitive vertices
E = GetExtinctions([760 850]);

E = E/10; %convert from /cm to /mm  E raws: wavelength, columns 1:HbO, 2:HbR

A = Make_A_matrix(Adot, Adot_scalp, E,  M);
calculated_mat.A = A;

A_hbo_brain = [A.Amatrix_brain.w1_HbO; A.Amatrix_brain.w2_HbO];
A_hbr_brain = [A.Amatrix_brain.w1_HbR; A.Amatrix_brain.w2_HbR];
A_hbo_scalp = [A.Amatrix_scalp.w1_HbO; A.Amatrix_scalp.w2_HbO];
A_hbr_scalp = [A.Amatrix_scalp.w1_HbR; A.Amatrix_scalp.w2_HbR];

A = double([A_hbo_brain, A_hbr_brain]);

%% BRAIN ONLY RECON 
nV_brain = size(A,2)/2;

% B = Amatrix*Amatrix';
B = A*A';
alpha = 0.01;
% Tikhonov regularization
% solution to arg min ||Y-Ax||^2 + lamda * ||x||^2 (prior only on state estimate)
% img2 =  Amatrix' * (inv(B + alpha * eigs(B,1) * eye(size(Amatrix,1))) * dodimg2);  % Custo2010NI; BoasDale2005; typical alpha = 0.01
% img3 =  Amatrix' * (inv(B + alpha * eigs(B,1) * eye(size(Amatrix,1))) * dodimg3);  % Custo2010NI; BoasDale2005; typical alpha = 0.01

pAinv = A' * (inv(B + alpha * eigs(B,1) * eye(size(A,1))));
img2 = pAinv * dodimg2;
img3 = pAinv * dodimg3;


img2_hbo_masked = img2(1:nV_brain);
img2_hbr_masked = img2(nV_brain+1:end);
img3_hbo_masked = img3(1:nV_brain);
img3_hbr_masked = img3(nV_brain+1:end);

img2_hbo = zeros(size(mesh.vertices, 1),1);
img3_hbo = zeros(size(mesh.vertices, 1),1);
img2_hbo(M.mask_brain) = img2_hbo_masked;
img3_hbo(M.mask_brain) = img3_hbo_masked;

max_val = max( [max(img2_hbo), max(img2_hbo)]);
cbar_range = [-1.5e-6, 1.5e-6];
% cbar_range =  [-max_val*0.5, max_val*0.5];
plot_images_on_mesh_JEA(mesh, img2_hbo, cbar_range)
plot_images_on_mesh_JEA(mesh, img3_hbo,  cbar_range)