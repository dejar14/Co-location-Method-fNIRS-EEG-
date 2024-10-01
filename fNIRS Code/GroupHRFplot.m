%% Stroop Task Group Results
% Author: De'Ja Rogers
% Objective: Create plot for the average HRF of the channels in the region
% of interest and determine if the differences between the easy and hard
% levels are significant (with Subject Intervariability Included).

%% Channel Space Plot Code
% n = 14
% Load HRF Data split in left and right ROIs
a=readtable('XXX.xlsx'); % Exported from Homer3
b=table2array(a(3:end,:));

bands = [5 18];  % the range that will be averaged for AV and to determine significange

figure(5)
subplot(1, 2, 1);
plot(b(:,1), b(:,2), 'color', 'red', 'LineWidth',2) % Easy Level
hold on
plot(b(:,1), b(:,4), 'color', 'red', 'LineStyle', '--', 'LineWidth',2) % Hard Level
hold on
title('AVG HRF in Left ROI Only', 'FontSize', 15)
xlabel('Time (s)', 'FontSize', 15)
ylabel('HbO (M mm)', 'FontSize', 15)
xlim([-2 23])
ylim([-1.5*10e-6 1.5*10e-6])
ax=gca;
ax.FontSize=15;
xp = [bands fliplr(bands)];    % Create a shaded region for AV                                                      
yp = ([[1;1]*min(ylim); [1;1]*max(ylim)]*ones(1,size(bands,1))).';               
for k = 1:size(bands,1)                                                             
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end
legend('Easy Level', 'Hard Level', 'Image Recon Range', 'Location', 'northwestoutside')
hold off

subplot(1, 2, 2);
plot(b(:,1), b(:,3), 'color', 'red', 'LineWidth',2) % Easy Level 
hold on
plot(b(:,1), b(:,5), 'color', 'red', 'LineStyle','--', 'LineWidth',2) % Hard Level
hold on
title('AVG HRF in Right ROI Only', 'FontSize', 15)
xlabel('Time (s)', 'FontSize', 15)
ylabel('HbO (M mm)', 'FontSize', 15)
xlim([-2 23])
ylim([-1.5*10e-6 1.5*10e-6])
ax=gca;
ax.FontSize=15;
xp = [bands fliplr(bands)];  % Create a shaded region for AV                                                        
yp = ([[1;1]*min(ylim); [1;1]*max(ylim)]*ones(1,size(bands,1))).';               
for k = 1:size(bands,1)                                                             
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end
hold off

%% Group Stats with Intersubject Variation

% Load the excel file
file=readcell('XXX.xlsx'); 

% Adjust for Left ROI
LGroup= file;

LGroup(:,684:end)=[]; % S24-DnonROIs, Source 25 removed
LGroup(:,675:680)=[]; % S24-DnonROIs removed
LGroup(:,660:666)=[]; % S24-DnonROIs removed
LGroup(:,453:656)=[]; % Sources 16-22, S23-DnonROIs removed
LGroup(:,3:438)=[]; % Sources 1-14, S15-DnonROIs removed 

LGroup2=LGroup(2:15,3:end);
LGroup2=LGroup2(:,1:3:end); % remove HbR and HbT

LGroupeasy=zeros(size(LGroup2)); % needed to make all elements the same type and convert to arrray
for j=1:length(LGroup2(1,:)) % j=1:length(LGroup2)
    data=LGroup2(:,j);
    data_double = zeros(size(data));
    for i = 1:numel(data)
        if ischar(data{i}) && strcmp(data{i}, 'NaN')
            data_double(i) = NaN;
        else
            data_double(i) = data{i};
        end
    end
    LGroupeasy(:,j)=data_double;
end 

LGroup3=LGroup(16:29,3:end);
LGroup3=LGroup3(:,1:3:end); % remove HbR and HbT

LGrouphard=zeros(size(LGroup3)); % needed to make all elements the same type and convert to arrray
for j=1:length(LGroup3(1,:)) % j=1:length(LGroup3)
    data=LGroup3(:,j);
    data_double = zeros(size(data));
    for i = 1:numel(data)
        if ischar(data{i}) && strcmp(data{i}, 'NaN')
            data_double(i) = NaN;
        else
            data_double(i) = data{i};
        end
    end
    LGrouphard(:,j)=data_double;
end 

% Adjust for Right ROI
RGroup=file;

RGroup(:,564:end)=[]; % S20-DnonROIs removed, Sources 21-25 removed
RGroup(:,552:560)=[]; % S20-DnonROIs removed
RGroup(:,546:548)=[]; % S19-DnonROIs removed
RGroup(:,534:539)=[]; % S19-DnonROIs removed
RGroup(:,306:530)=[]; % Sources 12-19, S19-DnonROIs removed
RGroup(:,273:293)=[]; % S11-DnonROIs removed
RGroup(:,3:269)=[]; % Sources 1-10 removed


RGroup2=RGroup(2:15,3:end);
RGroup2=RGroup2(:,1:3:end); % remove HbR and HbT

RGroupeasy=zeros(size(RGroup2)); % needed to make all elements the same type and convert to arrray
for j=1:length(RGroup2(1,:))% j=1:length(RGroup2)
    data=RGroup2(:,j);
    data_double = zeros(size(data));
    for i = 1:numel(data)
        if ischar(data{i}) && strcmp(data{i}, 'NaN')
            data_double(i) = NaN;
        else
            data_double(i) = data{i};
        end
    end
    RGroupeasy(:,j)=data_double;
end 

RGroup3=RGroup(16:29, 3:end);
RGroup3=RGroup3(:,1:3:end); % remove HbR and HbT

RGrouphard=zeros(size(RGroup3)); % needed to make all elements the same type and convert to arrray
for j=1:length(RGroup3(1,:))% j=1:length(RGroup3)
    data=RGroup3(:,j);
    data_double = zeros(size(data));
    for i = 1:numel(data)
        if ischar(data{i}) && strcmp(data{i}, 'NaN')
            data_double(i) = NaN;
        else
            data_double(i) = data{i};
        end
    end
    RGrouphard(:,j)=data_double;
end 

%% Calculate mean and std accross region and subjects
LGroupeasyMean=mean(LGroupeasy, 2, 'omitnan');
LGrouphardMean=mean(LGrouphard, 2, 'omitnan');
RGroupeasyMean=mean(RGroupeasy, 2, 'omitnan');
RGrouphardMean=mean(RGrouphard, 2, 'omitnan');
 
LGroupeasySTD=std(LGroupeasy, 0, 2, 'omitnan');
LGrouphardSTD=std(LGrouphard, 0, 2, 'omitnan');
RGroupeasySTD=std(RGroupeasy, 0, 2, 'omitnan');
RGrouphardSTD=std(RGrouphard, 0, 2, 'omitnan');

%% Plot Subject Differences

X=categorical({'Easy Level', 'Hard Level'});
X=reordercats(X,{'Easy Level', 'Hard Level'});
format shortg
M = [LGroupeasyMean(:) LGrouphardMean(:)];
figure; plot(X,M', 'o-')
colororder(turbo(14))
title('Left ROI Subject Means')
ylabel('uM mm')
legend({'SS017', 'SS018', 'SS019', 'SS022', 'SS023', 'SS024', 'SS025', 'SS026', ...
            'SS028', 'SS029', 'SS031', 'SS032', 'SS033', 'SS034'},'location', 'EastOutside');

X=categorical({'Easy Level', 'Hard Level'});
X=reordercats(X,{'Easy Level', 'Hard Level'});
format shortg
M = [RGroupeasyMean(:) RGrouphardMean(:)];
figure; plot(X,M', 'o-');
colororder(turbo(14))
title('Right ROI Subject Means')
ylabel('uM mm')
legend({'SS017', 'SS018', 'SS019', 'SS022', 'SS023', 'SS024', 'SS025', 'SS026', ...
            'SS028', 'SS029', 'SS031', 'SS032', 'SS033', 'SS034'},'location', 'EastOutside');
 
%% Perform pairwise t-tests
[hL,pL,ciL,statsL] = ttest(LGroupeasyMean, LGrouphardMean);
[hR,pR,ciR,statsR] = ttest(RGroupeasyMean, RGrouphardMean);
disp([' Left pvalue: ', num2str(pL), ' Right pvalue: ', num2str(pR)]);

%% Compute Cohen's d Effect Size for Paired Data

regions={'Left ROI', 'Right ROI'};
groupEasyMeans=[LGroupeasyMean, RGroupeasyMean];
groupHardMeans=[LGrouphardMean, RGrouphardMean];
groupEasySTDs=[LGroupeasySTD, RGroupeasySTD];
groupHardSTDs=[LGrouphardSTD, RGrouphardSTD];
for i=1:2
    cohensd = mean(groupHardMeans(:,i)-groupEasyMeans(:,i)) ./ std(groupHardMeans(:,i)-groupEasyMeans(:,i)); %cohensd for paired
    disp(['Cohens d Effect Size - ', regions{i}, ': ', num2str(cohensd)])
end


    

