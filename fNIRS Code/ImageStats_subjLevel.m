%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Image Recon Stats
% Author: De'Ja Rogers and Laura Carlton
% Objective: Calculate the t-statistic for subject in the Co-location Study
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Go to folders and load the necessary data files 

load('Co-Location Study_Dataset_SplineSG/fw/Adot.mat') % scalp data file
load('Co-Location Study_Dataset_SplineSG/fw/mesh_brain.mat') % brain data file
load('Co-Location Study_Dataset_SplineSG/fw/Adot_scalp.mat') % brain mesh data file
load('Co-Location Study_Dataset_SplineSG/fw/mesh_scalp.mat') % scalp mesh data file
load("probeIm.SD", "-mat") % SD file from collected data

%% Calculate and save conc for all subjects

load('sub-XXX.mat') % Avg Subject Data File
ml_SD=SD.MeasList;
[dcAvg, tHRF, ml_dcAvg] = output.dcAvg.GetDataTimeSeries('reshape:matrix');
dcAvg(:,:,:,1)=[];

[activeChLst_SDpairs, activeChLst_OD] = GetActiveChannels(dcAvg, ml_dcAvg, ml_SD, SD, 15); 

%% CONVERT TO OD 

dodAvg2 = hmrConc2OD(squeeze(dcAvg(:,:,:,2)), SD, [1,1]); % easy
dodAvg3 = hmrConc2OD(squeeze(dcAvg(:,:,:,3)), SD, [1,1]); % hard
dodAvg2 = dodAvg2(:,activeChLst_OD);
dodAvg3 = dodAvg3(:,activeChLst_OD);

%% GET VALUE OVER T RANGE 
trange = [5,18];
tHRF = output.dcAvg.time;

img2 = hmrImageHrfMeanTwin(dodAvg2, tHRF, trange);
img2(isnan(img2)) = 0;

img3 = hmrImageHrfMeanTwin(dodAvg3, tHRF, trange);
img3(isnan(img3)) = 0;

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
% img2 =  Amatrix' * (inv(B + alpha * eigs(B,1) * eye(size(Amatrix,1))) * img2);  % Custo2010NI; BoasDale2005; typical alpha = 0.01
% img3 =  Amatrix' * (inv(B + alpha * eigs(B,1) * eye(size(Amatrix,1))) * img3);  % Custo2010NI; BoasDale2005; typical alpha = 0.01

pAinv = A' * (inv(B + alpha * eigs(B,1) * eye(size(A,1))));
img2 = pAinv * img2;
img3 = pAinv * img3;

img2_hbo_masked = img2(1:nV_brain);
img2_hbr_masked = img2(nV_brain+1:end);
img3_hbo_masked = img3(1:nV_brain);
img3_hbr_masked = img3(nV_brain+1:end);

img2_hbo = zeros(size(mesh.vertices, 1),1);
img3_hbo = zeros(size(mesh.vertices, 1),1);
img2_hbo(M.mask_brain) = img2_hbo_masked;
img3_hbo(M.mask_brain) = img3_hbo_masked;

save('XXX_EasyImg', 'img2', 'img2_hbo', 'img2_hbo_masked', 'img2_hbr_masked')
save('XXX_HardImg', 'img3', 'img3_hbo', 'img3_hbo_masked', 'img3_hbr_masked')
% Break Here and repeat for all subjects

%% Load all the saved subeject Img data
% Easy
SS017Easy=load('SS017_EasyImg.mat').img2_hbo;
SS018Easy=load('SS018_EasyImg.mat').img2_hbo;
SS019Easy=load('SS019_EasyImg.mat').img2_hbo;
SS022Easy=load('SS022_EasyImg.mat').img2_hbo;
SS023Easy=load('SS023_EasyImg.mat').img2_hbo;
SS024Easy=load('SS024_EasyImg.mat').img2_hbo;
SS025Easy=load('SS025_EasyImg.mat').img2_hbo;
SS026Easy=load('SS026_EasyImg.mat').img2_hbo;
SS028Easy=load('SS028_EasyImg.mat').img2_hbo;
SS029Easy=load('SS029_EasyImg.mat').img2_hbo;
SS031Easy=load('SS031_EasyImg.mat').img2_hbo;
SS032Easy=load('SS032_EasyImg.mat').img2_hbo;
SS033Easy=load('SS033_EasyImg.mat').img2_hbo;
SS034Easy=load('SS034_EasyImg.mat').img2_hbo;

groupEasy=horzcat(SS017Easy, SS018Easy, SS019Easy, SS022Easy, SS023Easy, SS024Easy, ...
    SS025Easy, SS026Easy, SS028Easy, SS029Easy, SS031Easy, SS032Easy, SS033Easy, SS034Easy);

% Hard
SS017Hard=load('SS017_HardImg.mat').img3_hbo;
SS018Hard=load('SS018_HardImg.mat').img3_hbo;
SS019Hard=load('SS019_HardImg.mat').img3_hbo;
SS022Hard=load('SS022_HardImg.mat').img3_hbo;
SS023Hard=load('SS023_HardImg.mat').img3_hbo;
SS024Hard=load('SS024_HardImg.mat').img3_hbo;
SS025Hard=load('SS025_HardImg.mat').img3_hbo;
SS026Hard=load('SS026_HardImg.mat').img3_hbo;
SS028Hard=load('SS028_HardImg.mat').img3_hbo;
SS029Hard=load('SS029_HardImg.mat').img3_hbo;
SS031Hard=load('SS031_HardImg.mat').img3_hbo;
SS032Hard=load('SS032_HardImg.mat').img3_hbo;
SS033Hard=load('SS033_HardImg.mat').img3_hbo;
SS034Hard=load('SS034_HardImg.mat').img3_hbo;

groupHard=horzcat(SS017Hard, SS018Hard, SS019Hard, SS022Hard, SS023Hard, SS024Hard, ...
    SS025Hard, SS026Hard, SS028Hard, SS029Hard, SS031Hard, SS032Hard, SS033Hard, SS034Hard);

%% Calculate t-stats

n=14;
easyMean=mean(groupEasy, 2);
stdEasy=std(groupEasy, 0, 2);
hardMean=mean(groupHard, 2);
stdHard=std(groupHard, 0, 2);
diffMean=hardMean-easyMean;
stdDiff=stdHard-stdEasy;

tstat_hard=hardMean./(stdHard/sqrt(n));
tstat_hard(isnan(tstat_hard)) = 0;
tstat_easy=easyMean./(stdEasy/sqrt(n));
tstat_easy(isnan(tstat_easy)) = 0;

tstat_group1=(hardMean-easyMean)./sqrt(((stdHard.^2)/n)+((stdEasy.^2)/n));
tstat_group1(isnan(tstat_group1)) = 0;

tstat_group2=diffMean./(stdDiff/sqrt(n));
tstat_group2(isnan(tstat_group2)) = 0;

max_val = max( [max(tstat_hard), max(tstat_hard)]);
cbar_rangeH =  [-max_val, max_val];
plot_images_on_mesh_JEA(mesh, tstat_hard, cbar_rangeH, 2.16) % t-stat significant
plot_images_on_mesh_JEA(mesh, tstat_easy, cbar_rangeH, 2.16)  
