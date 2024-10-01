%% Finding Epochs SubLevel
% Objective: Find Significant Epochs for the Co-location Dataset at the
% subject level. This code is to be ran after the
% [Stroop_Group_PlotsStats_Published.m] code. 
% Author: De'Ja Rogers

%% Step 1: Initialize variables (time and subjects)

Channel=[8, 20]; % Channel represents the FCz electrode position (8) and the Pz electrode position (20)

timeline = diff_Group_ERP.time;
numSubjects = 10; % Number of subjects

allsubjDiffM = cell(1, numSubjects); 

cfg                 = [];
cfg.parameter       = 'avg';
cfg.operation       = 'x1-x2';

for sub = 1:numSubjects
    allsubjDiffM{sub} = ft_math(cfg, allsubjHardM{1,sub}, allsubjEasyM{1,sub});
end

%% Step 2: Calculate the difference waves and significant epochs for each location and subject

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

%% Step 2B: Create onset time list for easy and hard for each location using the results from Step 2A
% Could be automated if code is edited
% Significant Epochs Chosen at the subject level were 1) the closest ephoch
% within 200 ms of 300ms and 2) the third positive going peak in the ERP.
% Subjects/locations with values that did not meet the criteria were
% entered as a 'NaN' value. 

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

%% Step 3: Perform t-tests

[hFCz,pFCz,ciFCz,statsFCz]=ttest(easyEpochsFCz, hardEpochsFCz);
[hPz,pPz,ciPz,statsPz]=ttest(easyEpochsPz, hardEpochsPz);
[hFC,pFC,ciFC,statsFC]=ttest(easyEpochsFC, hardEpochsFC);
[hP,pP,ciP,statsP]=ttest(easyEpochsP, hardEpochsP);
[hAF,pAF,ciAF,statsAF]=ttest(easyEpochsAF, hardEpochsAF);
[hFT,pFT,ciFT,statsFT]=ttest(easyEpochsFT, hardEpochsFT);
