%% Group Analysis
% Objective: Analyze the Stroop Task of the Colocation Study as
% a Group (P300 ERP and Stats)
% Author: De'Ja Rogers

%% Load data and layout
layout='CustomLayout';

a=load('SS017_Stroop_data_AVGref_Fred.mat');
SS017_Stroop_data=a.data;

a=load('SS018_Stroop_data_AVGref_Fred.mat');
SS018_Stroop_data=a.data;

a=load('SS019_Stroop_data_AVGref_Fred.mat');
SS019_Stroop_data=a.data;

a=load('SS022_Stroop_data_AVGref_Fred.mat');
SS022_Stroop_data=a.data;

a=load('SS023_Stroop_data_AVGref_Fred.mat');
SS023_Stroop_data=a.data;

a=load('SS024_Stroop_data_AVGref_Fred.mat');
SS024_Stroop_data=a.data;

a=load('SS025_Stroop_data_AVGref_Fred.mat');
SS025_Stroop_data=a.data;

a=load('SS026_Stroop_data_AVGref_Fred.mat');
SS026_Stroop_data=a.data;

a=load('SS028_Stroop_data_AVGref_Fred.mat');
SS028_Stroop_data=a.data;

a=load('SS029_Stroop_data_AVGref_Fred.mat');
SS029_Stroop_data=a.data;

a=load('SS031_Stroop_data_AVGref_Fred.mat');
SS031_Stroop_data=a.data;

a=load('SS033_Stroop_data_AVGref_Fred.mat');
SS033_Stroop_data=a.data;

a=load('SS034_Stroop_data_AVGref_Fred.mat');
SS034_Stroop_data=a.data;

%% Separate Data

% SS017
cfg = [];
cfg.trials = find(SS017_Stroop_data.trialinfo(:,2)==2);
SS017_easy = ft_timelockanalysis(cfg, SS017_Stroop_data);

cfg = [];
cfg.trials = find(SS017_Stroop_data.trialinfo(:,2)==3);
SS017_hard = ft_timelockanalysis(cfg, SS017_Stroop_data);

% SS018
cfg = [];
cfg.trials = find(SS018_Stroop_data.trialinfo(:,2)==2);
SS018_easy = ft_timelockanalysis(cfg, SS018_Stroop_data);

cfg = [];
cfg.trials = find(SS018_Stroop_data.trialinfo(:,2)==3);
SS018_hard = ft_timelockanalysis(cfg, SS018_Stroop_data);

% SS019
cfg = [];
cfg.trials = find(SS019_Stroop_data.trialinfo(:,2)==2);
SS019_easy = ft_timelockanalysis(cfg, SS019_Stroop_data);

cfg = [];
cfg.trials = find(SS019_Stroop_data.trialinfo(:,2)==3);
SS019_hard = ft_timelockanalysis(cfg, SS019_Stroop_data);

% SS022
cfg = [];
cfg.trials = find(SS022_Stroop_data.trialinfo(:,2)==2);
SS022_easy = ft_timelockanalysis(cfg, SS022_Stroop_data);

cfg = [];
cfg.trials = find(SS022_Stroop_data.trialinfo(:,2)==3);
SS022_hard = ft_timelockanalysis(cfg, SS022_Stroop_data);

% SS023
cfg = [];
cfg.trials = find(SS023_Stroop_data.trialinfo(:,2)==2);
SS023_easy = ft_timelockanalysis(cfg, SS023_Stroop_data);

cfg = [];
cfg.trials = find(SS023_Stroop_data.trialinfo(:,2)==3);
SS023_hard = ft_timelockanalysis(cfg, SS023_Stroop_data);


% SS024
cfg = [];
cfg.trials = find(SS024_Stroop_data.trialinfo(:,2)==2);
SS024_easy = ft_timelockanalysis(cfg, SS024_Stroop_data);

cfg = [];
cfg.trials = find(SS024_Stroop_data.trialinfo(:,2)==3);
SS024_hard = ft_timelockanalysis(cfg, SS024_Stroop_data);


% SS025
cfg = [];
cfg.trials = find(SS025_Stroop_data.trialinfo(:,2)==2);
SS025_easy = ft_timelockanalysis(cfg, SS025_Stroop_data);

cfg = [];
cfg.trials = find(SS025_Stroop_data.trialinfo(:,2)==3);
SS025_hard = ft_timelockanalysis(cfg, SS025_Stroop_data);


% SS026
cfg = [];
cfg.trials = find(SS026_Stroop_data.trialinfo(:,2)==2);
SS026_easy = ft_timelockanalysis(cfg, SS026_Stroop_data);

cfg = [];
cfg.trials = find(SS026_Stroop_data.trialinfo(:,2)==3);
SS026_hard = ft_timelockanalysis(cfg, SS026_Stroop_data);


% SS028
cfg = [];
cfg.trials = find(SS028_Stroop_data.trialinfo(:,2)==2);
SS028_easy = ft_timelockanalysis(cfg, SS028_Stroop_data);

cfg = [];
cfg.trials = find(SS028_Stroop_data.trialinfo(:,2)==3);
SS028_hard = ft_timelockanalysis(cfg, SS028_Stroop_data);

% SS029
cfg = [];
cfg.trials = find(SS029_Stroop_data.trialinfo(:,2)==2);
SS029_easy = ft_timelockanalysis(cfg, SS029_Stroop_data);

cfg = [];
cfg.trials = find(SS029_Stroop_data.trialinfo(:,2)==3);
SS029_hard = ft_timelockanalysis(cfg, SS029_Stroop_data);

% SS031
cfg = [];
cfg.trials = find(SS031_Stroop_data.trialinfo(:,2)==2);
SS031_easy = ft_timelockanalysis(cfg, SS031_Stroop_data);

cfg = [];
cfg.trials = find(SS031_Stroop_data.trialinfo(:,2)==3);
SS031_hard = ft_timelockanalysis(cfg, SS031_Stroop_data);

% SS033
cfg = [];
cfg.trials = find(SS033_Stroop_data.trialinfo(:,2)==2);
SS033_easy = ft_timelockanalysis(cfg, SS033_Stroop_data);

cfg = [];
cfg.trials = find(SS033_Stroop_data.trialinfo(:,2)==3);
SS033_hard = ft_timelockanalysis(cfg, SS033_Stroop_data);

% SS034
cfg = [];
cfg.trials = find(SS034_Stroop_data.trialinfo(:,2)==2);
SS034_easy = ft_timelockanalysis(cfg, SS034_Stroop_data);

cfg = [];
cfg.trials = find(SS034_Stroop_data.trialinfo(:,2)==3);
SS034_hard = ft_timelockanalysis(cfg, SS034_Stroop_data);

%% Group ERP

% cfg=[];
% easy_Group_avg=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS023_easy, SS024_easy, ...
%     SS025_easy, SS026_easy, SS028_easy, SS029_easy, SS031_easy, SS033_easy, SS034_easy);
% 
% cfg=[];
% hard_Group_avg=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS023_hard, SS024_hard, ...
%     SS025_hard, SS026_hard, SS028_hard, SS029_hard, SS031_hard, SS033_hard, SS034_hard);

% Group minus excluded subject data
cfg=[];
easy_Group_avgM=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
     SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);

cfg=[];
hard_Group_avgM=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
    SS025_easy, SS028_hard, SS029_hard, SS033_hard, SS034_hard);

%% All subject data

% allsubjEasy={SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS023_easy, SS024_easy, ...
%     SS025_easy, SS026_easy, SS028_easy, SS029_easy, SS031_easy, SS033_easy, SS034_easy};
% 
% allsubjHard={SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS023_hard, SS024_hard, ...
%     SS025_hard, SS026_hard, SS028_hard, SS029_hard, SS031_hard, SS033_hard, SS034_hard};

% minus excluded subject data
allsubjEasyM={SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
   SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy};

allsubjHardM={SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
    SS025_easy, SS028_hard, SS029_hard, SS033_hard, SS034_hard};

%% Compute the ERP difference

cfg                 = [];
cfg.parameter       = 'avg'; % make sure this represents ERPs - lookup 
cfg.operation       = 'x1-x2';
diff_Group_ERP      = ft_math(cfg,hard_Group_avgM, easy_Group_avgM);

%% Find Significant Epochs for Each Condition at the Group Level

channel=[8, 20]; % FCz and Pz
significant_epochs1=[];
significant_epochs2=[];
timeline=diff_Group_ERP.time;

for i=1:2
    % Calculate mean and standard deviation of the baseline for each condition
    diff_baseline_mean=mean(diff_Group_ERP.avg(channel(i), 151:251));
    diff_baseline_sd=std(diff_Group_ERP.avg(channel(i), 151:251));

    baseline_mean1 = mean(easy_Group_avgM.avg(channel(i), 151:251));
    baseline_sd1 = std(easy_Group_avgM.avg(channel(i), 151:251));

    baseline_mean2 = mean(hard_Group_avgM.avg(channel(i), 151:251));
    baseline_sd2 = std(hard_Group_avgM.avg(channel(i), 151:251));

    % Compute the difference wave for each condition
    difference_wave = diff_Group_ERP.avg(channel(i), :) - diff_baseline_mean;
    difference_wave1 = easy_Group_avgM.avg(channel(i), :) - baseline_mean1;
    difference_wave2 = hard_Group_avgM.avg(channel(i), :) - baseline_mean2;

    % Define thresholds for each condition
    threshold_2sd = 2 * diff_baseline_sd;
    threshold_3sd = 3 * diff_baseline_sd;

    threshold_2sd1 = 2 * baseline_sd1;
    threshold_3sd1 = 3 * baseline_sd1;

    threshold_2sd2 = 2 * baseline_sd2;
    threshold_3sd2 = 3 * baseline_sd2;

    % Sampling rate and minimum duration
    fs = 500; % Sampling rate in Hz
    min_duration = 50 / 1000 * fs; % Convert 50 ms to samples

    % Find significant epochs for each condition
    significant_epochs = find_significant_epochs(difference_wave, threshold_2sd, threshold_3sd, min_duration, timeline);    
    significant_epochs1 = find_significant_epochs(difference_wave1, threshold_2sd1, threshold_3sd1, min_duration, timeline);
    significant_epochs2 = find_significant_epochs(difference_wave2, threshold_2sd2, threshold_3sd2, min_duration, timeline);

    % Display or process significant epochs for each condition
    disp('Significant epochs for diff (start, end indices):');
    disp(significant_epochs);

    disp('Significant epochs for condition 1 (start, end indices):');
    disp(significant_epochs1);

    disp('Significant epochs for condition 2 (start, end indices):');
    disp(significant_epochs2);
end

% Regions
pRegion=[19, 20, 25, 31, 32];
fcRegion=6:13;
afRegion=1:5;
ftRegion=[15, 16, 29, 30];
groupedChannels = {fcRegion, pRegion, afRegion, ftRegion};
significant_epochs_group=[];
significant_epochs1_group=[];
significant_epochs2_group=[];

for i=1:4
    % Calculate mean and standard deviation of the baseline for each condition
    diff_baseline_mean=mean(mean(diff_Group_ERP.avg(groupedChannels{1}, 151:251)));
    diff_baseline_sd=std(mean(diff_Group_ERP.avg(groupedChannels{1}, 151:251)));

    baseline_mean1 = mean(mean(easy_Group_avgM.avg(groupedChannels{i}, 151:251)));
    baseline_sd1 = std(mean(easy_Group_avgM.avg(groupedChannels{i}, 151:251)));

    baseline_mean2 = mean(mean(hard_Group_avgM.avg(groupedChannels{i}, 151:251)));
    baseline_sd2 = std(mean(hard_Group_avgM.avg(groupedChannels{i}, 151:251)));

    % Compute the difference wave for each condition
    difference_wave = mean(diff_Group_ERP.avg(groupedChannels{i}, :)) - diff_baseline_mean;
    difference_wave1 = mean(easy_Group_avgM.avg(groupedChannels{i}, :)) - baseline_mean1;
    difference_wave2 = mean(hard_Group_avgM.avg(groupedChannels{i}, :)) - baseline_mean2;

    % Define thresholds for each condition
    threshold_2sd = 2 * diff_baseline_sd;
    threshold_3sd = 3 * diff_baseline_sd;

    threshold_2sd1 = 2 * baseline_sd1;
    threshold_3sd1 = 3 * baseline_sd1;

    threshold_2sd2 = 2 * baseline_sd2;
    threshold_3sd2 = 3 * baseline_sd2;

    % Sampling rate and minimum duration
    fs = 500; % Sampling rate in Hz
    min_duration = 50 / 1000 * fs; % Convert 50 ms to samples

    % Find significant epochs for each condition
    significant_epochs_group = find_significant_epochs(difference_wave, threshold_2sd, threshold_3sd, min_duration, timeline);    
    significant_epochs1_group = find_significant_epochs(difference_wave1, threshold_2sd1, threshold_3sd1, min_duration, timeline);
    significant_epochs2_group = find_significant_epochs(difference_wave2, threshold_2sd2, threshold_3sd2, min_duration, timeline);

    % Display or process significant epochs for each condition
    disp('Significant epochs for diff (start, end indices):');
    disp(significant_epochs_group);

    disp('Significant epochs for condition 1 (start, end indices):');
    disp(significant_epochs1_group);

    disp('Significant epochs for condition 2 (start, end indices):');
    disp(significant_epochs2_group);
end

%% Subject Level for stats

% Finding Epochs SubLevel
% channel = [8, 20]; % FCz and Pz
timeline = diff_Group_ERP.time;
numSubjects = 10; % Number of subjects

allsubjDiffM = cell(1, numSubjects);

cfg                 = [];
cfg.parameter       = 'avg'; % make sure this represents ERPs - lookup 
cfg.operation       = 'x1-x2';

% Calculate the difference waves for each subject
for sub = 1:numSubjects
    allsubjDiffM{sub} = ft_math(cfg, allsubjHardM{1,sub}, allsubjEasyM{1,sub});
end

for subj = 1:numSubjects
    significant_epochs1 = [];
    significant_epochs2 = [];

    for i = 1:2
        % Access the data for the current subject using curly braces
        diff_data = allsubjDiffM{subj}.avg(channel(i), :);
        easy_data = allsubjEasyM{1,subj}.avg(channel(i), :);
        hard_data = allsubjHardM{1,subj}.avg(channel(i), :);

        % Calculate mean and standard deviation of the baseline for each condition
        diff_baseline_mean = mean(diff_data(151:251));
        diff_baseline_sd = std(diff_data(151:251));

        baseline_mean1 = mean(easy_data(151:251));
        baseline_sd1 = std(easy_data(151:251));

        baseline_mean2 = mean(hard_data(151:251));
        baseline_sd2 = std(hard_data(151:251));

        % Compute the difference wave for each condition
        difference_wave = diff_data - diff_baseline_mean;
        difference_wave1 = easy_data - baseline_mean1;
        difference_wave2 = hard_data - baseline_mean2;

        % Define thresholds for each condition
        threshold_2sd = 2 * diff_baseline_sd;
        threshold_3sd = 3 * diff_baseline_sd;

        threshold_2sd1 = 2 * baseline_sd1;
        threshold_3sd1 = 3 * baseline_sd1;

        threshold_2sd2 = 2 * baseline_sd2;
        threshold_3sd2 = 3 * baseline_sd2;

        % Sampling rate and minimum duration
        fs = 500; % Sampling rate in Hz
        min_duration = 50 / 1000 * fs; % Convert 50 ms to samples

        % Find significant epochs for each condition
        significant_epochs = find_significant_epochs(difference_wave, threshold_2sd, threshold_3sd, min_duration, timeline);
        significant_epochs1 = find_significant_epochs(difference_wave1, threshold_2sd1, threshold_3sd1, min_duration, timeline);
        significant_epochs2 = find_significant_epochs(difference_wave2, threshold_2sd2, threshold_3sd2, min_duration, timeline);

        % Display or process significant epochs for each condition
        disp(['Subject ' num2str(subj) ' Significant epochs for diff (start, end indices):']);
        disp(significant_epochs);

        disp(['Subject ' num2str(subj) ' Significant epochs for condition 1 (start, end indices):']);
        disp(significant_epochs1);

        disp(['Subject ' num2str(subj) ' Significant epochs for condition 2 (start, end indices):']);
        disp(significant_epochs2);
    end

    % Regions
    pRegion = [19, 20, 25, 31, 32];
    fcRegion = 6:13;
    afRegion = 1:5;
    ftRegion = [15, 16, 29, 30];
    groupedChannels = {fcRegion, pRegion, afRegion, ftRegion};
    significant_epochs_group = [];
    significant_epochs1_group = [];
    significant_epochs2_group = [];

    for i = 1:4
        % Access the data for the current subject using curly braces
        diff_data_group = mean(allsubjDiffM{subj}.avg(groupedChannels{i}, :), 1);
        easy_data_group = mean(allsubjEasyM{1,subj}.avg(groupedChannels{i}, :), 1);
        hard_data_group = mean(allsubjHardM{1,subj}.avg(groupedChannels{i}, :), 1);

        % Calculate mean and standard deviation of the baseline for each condition
        diff_baseline_mean = mean(diff_data_group(151:251));
        diff_baseline_sd = std(diff_data_group(151:251));

        baseline_mean1 = mean(easy_data_group(151:251));
        baseline_sd1 = std(easy_data_group(151:251));

        baseline_mean2 = mean(hard_data_group(151:251));
        baseline_sd2 = std(hard_data_group(151:251));

        % Compute the difference wave for each condition
        difference_wave = diff_data_group - diff_baseline_mean;
        difference_wave1 = easy_data_group - baseline_mean1;
        difference_wave2 = hard_data_group - baseline_mean2;

        % Define thresholds for each condition
        threshold_2sd = 2 * diff_baseline_sd;
        threshold_3sd = 3 * diff_baseline_sd;

        threshold_2sd1 = 2 * baseline_sd1;
        threshold_3sd1 = 3 * baseline_sd1;

        threshold_2sd2 = 2 * baseline_sd2;
        threshold_3sd2 = 3 * baseline_sd2;

        % Sampling rate and minimum duration
        fs = 500; % Sampling rate in Hz
        min_duration = 50 / 1000 * fs; % Convert 50 ms to samples

        % Find significant epochs for each condition
        significant_epochs_group = find_significant_epochs(difference_wave, threshold_2sd, threshold_3sd, min_duration, timeline);
        significant_epochs1_group = find_significant_epochs(difference_wave1, threshold_2sd1, threshold_3sd1, min_duration, timeline);
        significant_epochs2_group = find_significant_epochs(difference_wave2, threshold_2sd2, threshold_3sd2, min_duration, timeline);

        % Display or process significant epochs for each condition
        disp(['Subject ' num2str(subj) ' Significant epochs for diff (start, end indices):']);
        disp(significant_epochs_group);

        disp(['Subject ' num2str(subj) ' Significant epochs for condition 1 (start, end indices):']);
        disp(significant_epochs1_group);

        disp(['Subject ' num2str(subj) ' Significant epochs for condition 2 (start, end indices):']);
        disp(significant_epochs2_group);
    end
end

%% Create onset time list for easy and hard

% Could be automated if code is edited
% Significant Epochs Chosen at the subject level were 1) the closest ephoch
% within 200 ms of the 300ms time mark and 2) the third positive going peak 
% in the ERP. Subjects/locations with values that did not meet the criteria
% were entered as a 'NaN' value. 

% FCz
easyEpochsFCz=['XXX'];
hardEpochsFCz=['XXX'];

% Pz
easyEpochsPz=['XXX'];
hardEpochsPz=['XXX'];

% FC Region
easyEpochsFC=['XXX'];
hardEpochsFC=['XXX'];

% P Region
easyEpochsP=['XXX'];
hardEpochsP=['XXX'];

% AF Rgion
easyEpochsAF=['XXX'];
hardEpochsAF=['XXX'];

% FT Region
easyEpochsFT=['XXX'];
hardEpochsFT=['XXX'];

% t-tests
[hFCz,pFCz,ciFCz,statsFCz]=ttest(easyEpochsFCz, hardEpochsFCz);
[hPz,pPz,ciPz,statsPz]=ttest(easyEpochsPz, hardEpochsPz);
[hFC,pFC,ciFC,statsFC]=ttest(easyEpochsFC, hardEpochsFC);
[hP,pP,ciP,statsP]=ttest(easyEpochsP, hardEpochsP);
[hAF,pAF,ciAF,statsAF]=ttest(easyEpochsAF, hardEpochsAF);
[hFT,pFT,ciFT,statsFT]=ttest(easyEpochsFT, hardEpochsFT);


%% Plot All ERPs
% Use the latencies around P300 for the shaded regions for FCz and Pz
cfg = [];
cfg.layout = 'CustomLayout';
cfg.interactive = 'yes';
cfg.showoutline = 'yes';
cfg.hlim    =   [-0.5 1];
ft_multiplotER(cfg, easy_Group_avg, hard_Group_avg)

% Co-Located Positions
cfg = [];
cfg.layout='CustomLayout';
cfg.title = 'Co-Located Positions in AF Region';
cfg.channel = {'af3', 'af4', 'aff1h', 'aff2h', 'afz'};
cfg.xlim   =   [-0.2 1];
cfg.ylim = [-7.5 4.5];
ft_singleplotER_frontal(cfg, easy_Group_avgM, hard_Group_avgM) 

cfg = [];
cfg.layout='CustomLayout';
cfg.title = 'Co-Located Positions in FT Region';
cfg.channel = {'fft7', 'fft8', 'ttp7h', 'ttp8h'};
cfg.xlim   =   [-0.2 1];
cfg.ylim = [-2 4];
ft_singleplotER_parietal(cfg, easy_Group_avgM, hard_Group_avgM) 

% Plot Target Electrodes
cfg = [];
cfg.layout='CustomLayout';
cfg.title = 'Target Location (FCz)';
cfg.channel = {'fcz'};
cfg.xlim   =   [-0.2 1];
cfg.ylim = [-2.5 7.5];
ft_singleplotER_frontal(cfg, easy_Group_avgM, hard_Group_avgM) %trade with one versions to compare baseline and nonbaseline corrected

cfg = [];
cfg.title = 'Target Location (Pz)';
cfg.channel = {'pz'};
cfg.xlim    =   [-0.2 1];
cfg.ylim = [-2.5 7.5];
ft_singleplotER_parietal(cfg, easy_Group_avgM, hard_Group_avgM)

% Plot Avg ROI ERPs
cfg = [];
cfg.title = 'Average Frontal Region of Interest';
cfg.channel = {'fz', 'fcz', 'fc2', 'fc1', 'c1', 'c2', 'c3', 'c4'};
cfg.xlim   =   [-0.2 1];
cfg.ylim = [-2.5 7.5];
ft_singleplotER_frontal(cfg, easy_Group_avgM, hard_Group_avgM)

cfg = [];
cfg.title = 'Average Parietal Region of Interest';
cfg.channel = {'cp1', 'cp2', 'p3', 'pz', 'p4'};
cfg.xlim    =   [-0.2 1];
cfg.ylim = [-2.5 7.5];
ft_singleplotER_parietal(cfg, easy_Group_avgM, hard_Group_avgM)

% Remove EOGs for topoplotting
% Manual trial and channel rejection using summary statistics
cfg             = [];
cfg.method      = 'summary';
cfg.channels    = 'all';
cfg.ylim        = 100;
diff            = ft_rejectvisual(cfg,diff_Group_ERP);

cfg=[];
cfg.layout='CustomLayout';
cfg.title='P3a Topoplot';
cfg.xlim=[0.2860 0.5080];
cfg.zlim=[-1.5 1.5];
cfg.colorbar='yes';
ft_topoplotER(cfg, diff)

cfg=[];
cfg.layout='CustomLayout';
cfg.title='P3b Topoplot';
cfg.xlim=[.4 .762];
cfg.zlim=[-1.5 1.5];
cfg.colorbar='yes';
ft_topoplotER(cfg, diff)

%% Paired t-tests (Mean)

% FCz
time = [0.2860    0.5080; 0.4000    0.7620]; % use the diff interval for Pz if not significant 
for i=1:2
    % define the parameters for the statistical comparison
    cfg = [];
    cfg.channel     = {'fcz'};
    cfg.latency     = time(i,:);
    cfg.avgovertime = 'yes';
    cfg.parameter   = 'avg';
    cfg.method      = 'analytic';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'no'; % same results as no correction

    Nsub = 10; %13;
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    statFCzBC{i} = ft_timelockstatistics(cfg, allsubjHardM{:}, allsubjEasyM{:});
end
disp(['pFCzP3a: ',num2str(statFCzBC{1,1}.prob)]);
disp(['pFCzP3b: ',num2str(statFCzBC{1,2}.prob)]);

% Pz
for i=1:2
    % define the parameters for the statistical comparison
    cfg = [];
    cfg.channel     = {'pz'};
    cfg.latency     = time(i,:);
    cfg.avgovertime = 'yes';
    cfg.parameter   = 'avg';
    cfg.method      = 'analytic';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'no'; % same results as no correction

    Nsub = 10; %13;
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    statPzBC{i} = ft_timelockstatistics(cfg, allsubjHardM{:}, allsubjEasyM{:});
end
disp(['pPzP3a: ',num2str(statPzBC{1,1}.prob)]);
disp(['pPzP3b: ',num2str(statPzBC{1,2}.prob)]);

% Frontal-Central Region
for i=1:2
    % define the parameters for the statistical comparison
    cfg = [];
    cfg.channel     = {'fz', 'fcz', 'fc2', 'fc1', 'c1', 'c2', 'c3', 'c4'};
    cfg.latency     = time(i,:);
    cfg.avgovertime = 'yes';
    cfg.avgoverchan = 'yes';
    cfg.parameter   = 'avg';
    cfg.method      = 'analytic';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'bonferroni'; % same results as no correction

    Nsub = 10; %13;
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    statFBC{i} = ft_timelockstatistics(cfg, allsubjHardM{:}, allsubjEasyM{:});
end
disp(['pF3a: ',num2str(statFBC{1,1}.prob)]);
disp(['pF3b: ',num2str(statFBC{1,2}.prob)]);

% Parietal Region
for i=1:2
    % define the parameters for the statistical comparison
    cfg = [];
    cfg.channel     = {'pz','p3','p4', 'cp1', 'cp2'};
    cfg.latency     = time(i,:);
    cfg.avgovertime = 'yes';
    cfg.avgoverchan = 'yes';
    cfg.parameter   = 'avg';
    cfg.method      = 'analytic';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'bonferroni'; % same results as no correction

    Nsub = 10; %13;
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    statPBC{i} = ft_timelockstatistics(cfg, allsubjHardM{:}, allsubjEasyM{:});
end
disp(['pP3a: ',num2str(statPBC{1,1}.prob)]);
disp(['pP3b: ',num2str(statPBC{1,2}.prob)]);

% Co-Located Regions
for i=1:2
    % define the parameters for the statistical comparison
    cfg = [];
    cfg.channel     = {'af3', 'af4', 'aff1h', 'aff2h', 'afz'};
    cfg.latency     = time(i,:);
    cfg.avgovertime = 'yes';
    cfg.avgoverchan = 'yes';
    cfg.parameter   = 'avg';
    cfg.method      = 'analytic';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'bonferroni'; % same results as no correction

    Nsub = 10; %13;
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    statAFBC{i} = ft_timelockstatistics(cfg, allsubjHardM{:}, allsubjEasyM{:});
end
disp(['pF3a: ',num2str(statAFBC{1,1}.prob)]);
disp(['pF3b: ',num2str(statAFBC{1,2}.prob)]);

for i=1:2
    % define the parameters for the statistical comparison
    cfg = [];
    cfg.channel     = {'fft7', 'fft8', 'ttp7h', 'ttp8h'};
    cfg.latency     = time(i,:);
    cfg.avgovertime = 'yes';
    cfg.avgoverchan = 'yes';
    cfg.parameter   = 'avg';
    cfg.method      = 'analytic';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'bonferroni'; % same results as no correction

    Nsub = 10; %13;
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    statFTBC{i} = ft_timelockstatistics(cfg, allsubjHardM{:}, allsubjEasyM{:});
end
disp(['pF3a: ',num2str(statFTBC{1,1}.prob)]);
disp(['pF3b: ',num2str(statFTBC{1,2}.prob)]);
%% Cohen's d Effect Size for Paired Stats (Mean)

plotLatency={'P3a','P3b'};

% FCz
for i=1:2
    cfg = [];
    cfg.channel   = {'fcz'};
    cfg.latency   = time(i,:); % time frame of interest out of 3s
    cfg.parameter = 'avg';
    cfg.keepindividual='yes';
    hard_Group_avgMTrial  = ft_timelockgrandaverage(cfg, allsubjHardM{:});
    easy_Group_avgMTrial   = ft_timelockgrandaverage(cfg, allsubjEasyM{:});

    cfg = [];
    cfg.channel = {'fcz'}; 
    cfg.latency = time(i,:);
    % cfg.avgoverchan = 'yes';
    cfg.avgovertime = 'yes';
    roiEasy=ft_selectdata(cfg, easy_Group_avgMTrial);
    roiHard=ft_selectdata(cfg, hard_Group_avgMTrial);

    cfg=[];
    cfg.method = 'analytic';
    cfg.statistic = 'cohensd'; % see FT_STATFUN_COHENSD
    cfg.ivar = 1;
    cfg.uvar = 2;
    cfg.design = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 
     1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10];
%     cfg.design = [1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 
%      1 2 3 4 5 6 7 8 9 10 11 12 13 1 2 3 4 5 6 7 8 9 10 11 12 13];
    effect_FCz = ft_timelockstatistics(cfg, roiEasy, roiHard);
    disp(['FCz Effect Size - ', plotLatency{i}, ': ',num2str(effect_FCz.cohensd)])
end

% Pz
for i=1:2
    cfg = [];
    cfg.channel   = {'pz'};
    cfg.latency   = time(i,:); % time frame of interest out of 3s
    cfg.parameter = 'avg';
    cfg.keepindividual='yes';
    hard_Group_avgMTrial  = ft_timelockgrandaverage(cfg, allsubjHardM{:});
    easy_Group_avgMTrial   = ft_timelockgrandaverage(cfg, allsubjEasyM{:});

    cfg = [];
    cfg.channel = {'pz'}; % 
    cfg.latency = time(i,:);
    % cfg.avgoverchan = 'yes';
    cfg.avgovertime = 'yes';
    roiEasy=ft_selectdata(cfg, easy_Group_avgMTrial);
    roiHard=ft_selectdata(cfg, hard_Group_avgMTrial);

    cfg=[];
    cfg.method = 'analytic';
    cfg.statistic = 'cohensd'; % see FT_STATFUN_COHENSD
    cfg.ivar = 1;
    cfg.uvar = 2;
    cfg.design = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 
     1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10];
%     cfg.design = [1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 
%      1 2 3 4 5 6 7 8 9 10 11 12 13 1 2 3 4 5 6 7 8 9 10 11 12 13];
    effect_Pz = ft_timelockstatistics(cfg, roiEasy, roiHard);
    disp(['Pz  Effect Size - ', plotLatency{i}, ': ',num2str(effect_Pz.cohensd)])
end

% Colocated regions
for i=1:2
    cfg = [];
    cfg.channel   = {'af3', 'af4', 'aff1h', 'aff2h', 'afz'};
    cfg.latency   = time(i,:); % time frame of interest out of 3s
    cfg.parameter = 'avg';
    cfg.keepindividual='yes';
    hard_Group_avgMTrial  = ft_timelockgrandaverage(cfg, allsubjHardM{:});
    easy_Group_avgMTrial   = ft_timelockgrandaverage(cfg, allsubjEasyM{:});

    cfg = [];
    cfg.channel = {'af3', 'af4', 'aff1h', 'aff2h', 'afz'};
    cfg.latency = time(i,:);
    cfg.avgoverchan = 'yes';
    cfg.avgovertime = 'yes';
    roiEasy=ft_selectdata(cfg, easy_Group_avgMTrial);
    roiHard=ft_selectdata(cfg, hard_Group_avgMTrial);

    cfg=[];
    cfg.method = 'analytic';
    cfg.statistic = 'cohensd'; % see FT_STATFUN_COHENSD
    cfg.ivar = 1;
    cfg.uvar = 2;
    cfg.design = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 
     1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10];
%     cfg.design = [1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 
%      1 2 3 4 5 6 7 8 9 10 11 12 13 1 2 3 4 5 6 7 8 9 10 11 12 13];
    effect_F = ft_timelockstatistics(cfg, roiEasy, roiHard);
    disp(['AF Effect Size - ', num2str(effect_F.cohensd)])
end

for i=1:2
    cfg = [];
    cfg.channel   = {'fft7', 'fft8', 'ttp7h', 'ttp8h'};
    cfg.latency   = time(i,:); % time frame of interest out of 3s
    cfg.parameter = 'avg';
    cfg.keepindividual='yes';
    hard_Group_avgMTrial  = ft_timelockgrandaverage(cfg, allsubjHardM{:});
    easy_Group_avgMTrial   = ft_timelockgrandaverage(cfg, allsubjEasyM{:});

    cfg = [];
    cfg.channel = {'fft7', 'fft8', 'ttp7h', 'ttp8h'};
    cfg.latency = time(i,:);
    cfg.avgoverchan = 'yes';
    cfg.avgovertime = 'yes';
    roiEasy=ft_selectdata(cfg, easy_Group_avgMTrial);
    roiHard=ft_selectdata(cfg, hard_Group_avgMTrial);

    cfg=[];
    cfg.method = 'analytic';
    cfg.statistic = 'cohensd'; % see FT_STATFUN_COHENSD
    cfg.ivar = 1;
    cfg.uvar = 2;
    cfg.design = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 
     1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10];
%     cfg.design = [1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 
%      1 2 3 4 5 6 7 8 9 10 11 12 13 1 2 3 4 5 6 7 8 9 10 11 12 13];
    effect_P = ft_timelockstatistics(cfg, roiEasy, roiHard);
    disp(['FT Effect Size - ',num2str(effect_P.cohensd)])
end

% Frontal-Central Region
for i=1:2
    cfg = [];
    cfg.channel   = {'fz', 'fcz', 'fc2', 'fc1', 'c1', 'c2', 'c3', 'c4'};
    cfg.latency   = time(i,:); % time frame of interest out of 3s
    cfg.parameter = 'avg';
    cfg.keepindividual='yes';
    hard_Group_avgMTrial  = ft_timelockgrandaverage(cfg, allsubjHardM{:});
    easy_Group_avgMTrial   = ft_timelockgrandaverage(cfg, allsubjEasyM{:});

    cfg = [];
    cfg.channel = {'fz', 'fcz', 'fc2', 'fc1', 'c1', 'c2', 'c3', 'c4'};
    cfg.latency = time(i,:);
    cfg.avgoverchan = 'yes';
    cfg.avgovertime = 'yes';
    roiEasy=ft_selectdata(cfg, easy_Group_avgMTrial);
    roiHard=ft_selectdata(cfg, hard_Group_avgMTrial);

    cfg=[];
    cfg.method = 'analytic';
    cfg.statistic = 'cohensd'; % see FT_STATFUN_COHENSD
    cfg.ivar = 1;
    cfg.uvar = 2;
    cfg.design = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 
     1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10];
%     cfg.design = [1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 
%      1 2 3 4 5 6 7 8 9 10 11 12 13 1 2 3 4 5 6 7 8 9 10 11 12 13];
    effect_F = ft_timelockstatistics(cfg, roiEasy, roiHard);
    disp(['Frontal - Central Region Effect Size - ', plotLatency{i}, ': ',num2str(effect_F.cohensd)])
end

% Parietal Region
for i=1:2
    cfg = [];
    cfg.channel   = {'p4', 'p3', 'pz', 'cp1', 'cp2'};
    cfg.latency   = time(i,:); % time frame of interest out of 3s
    cfg.parameter = 'avg';
    cfg.keepindividual='yes';
    hard_Group_avgMTrial  = ft_timelockgrandaverage(cfg, allsubjHardM{:});
    easy_Group_avgMTrial   = ft_timelockgrandaverage(cfg, allsubjEasyM{:});

    cfg = [];
    cfg.channel = {'p4', 'p3', 'pz', 'cp1', 'cp2'};
    cfg.latency = time(i,:);
    cfg.avgoverchan = 'yes';
    cfg.avgovertime = 'yes';
    roiEasy=ft_selectdata(cfg, easy_Group_avgMTrial);
    roiHard=ft_selectdata(cfg, hard_Group_avgMTrial);

    cfg=[];
    cfg.method = 'analytic';
    cfg.statistic = 'cohensd'; % see FT_STATFUN_COHENSD
    cfg.ivar = 1;
    cfg.uvar = 2;
    cfg.design = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 
     1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10];
%     cfg.design = [1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 
%      1 2 3 4 5 6 7 8 9 10 11 12 13 1 2 3 4 5 6 7 8 9 10 11 12 13];
    effect_P = ft_timelockstatistics(cfg, roiEasy, roiHard);
    disp(['Parietal Region Effect Size - ', plotLatency{i}, ': ',num2str(effect_P.cohensd)])
end

