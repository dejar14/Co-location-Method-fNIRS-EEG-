%% Finding Epochs at the Group Level
% Objective: Find Significant Epochs for the Co-location Dataset at the
% group level. This code is to be ran after the
% [Stroop_Group_PlotsStats_Published.m] code. 
% Author: De'Ja Rogers

%% Step 1: Calculate the difference waves and significant epochs for each location

channel=[8, 20]; % Channel represents the FCz electrode position (8) and the Pz electrode position (20)

for i=1:2
    % Identify the data and baseline
    data1=easy_Group_avgM.avg(channel(i), :); % 8 for FCz and 20 for Pz
    data2=hard_Group_avgM.avg(channel(i), :);
    baseline1=easy_Group_avgM.avg(channel(i), 151:251); % number varies based on desired baseline 
    baseline2=hard_Group_avgM.avg(channel(i), 151:251);

    % Calculate mean and standard deviation of the baseline for each condition
    baseline_mean1 = mean(baseline1);
    baseline_sd1 = std(baseline1);

    baseline_mean2 = mean(baseline2);
    baseline_sd2 = std(baseline2);

    % Compute the difference wave for each condition
    difference_wave1 = data1 - baseline_mean1;
    difference_wave2 = data2 - baseline_mean2;

    % Define thresholds for each condition
    threshold_2sd1 = 2 * baseline_sd1;
    threshold_3sd1 = 3 * baseline_sd1;

    threshold_2sd2 = 2 * baseline_sd2;
    threshold_3sd2 = 3 * baseline_sd2;

    % Sampling rate and minimum duration
    fs = 1000; % Sampling rate in Hz
    min_duration = 50 / 1000 * fs; % Convert 50 ms to samples

    time=easy_Group_avgM.time;
    % Find significant epochs and their corresponding times for each condition
    significant_epochs1 = find_significant_epochs(difference_wave1, threshold_2sd1, threshold_3sd1, min_duration, time);
    significant_epochs2 = find_significant_epochs(difference_wave2, threshold_2sd2, threshold_3sd2, min_duration, time);

    % Display or process significant epochs for each condition
    disp('Significant epochs for condition 1 (start_idx, end_idx, start_time, end_time):');
    disp(significant_epochs1);

    disp('Significant epochs for condition 2 (start_idx, end_idx, start_time, end_time):');
    disp(significant_epochs2);

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
        % Identify the data and baseline
        data1_region = mean(allsubjEasyM.avg(groupedChannels{i}, :), 1);
        data2_region = mean(allsubjHardM.avg(groupedChannels{i}, :), 1);
        baseline1_region=easy_Group_avgM.avg(groupedChannel(i), 151:251); % number varies based on desired baseline 
        baseline2_region=hard_Group_avgM.avg(groupedChannel(i), 151:251);

        % Calculate mean and standard deviation of the baseline for each condition
        baseline_mean1_region = mean(baseline1_region);
        baseline_sd1_region = std(baseline1_region);

        baseline_mean2_region = mean(baseline2_region);
        baseline_sd2_region = std(baseline2_region);

        % Compute the difference wave for each condition
        difference_wave1_region = data1_region - baseline_mean1_region;
        difference_wave2_region = data2_region - baseline_mean2_region;

        % Define thresholds for each condition
        threshold_2sd1_region = 2 * baseline_sd1_region;
        threshold_3sd1_region = 3 * baseline_sd1_region;

        threshold_2sd2_region = 2 * baseline_sd2_region;
        threshold_3sd2_region = 3 * baseline_sd2_region;

        % Sampling rate and minimum duration
        fs = 500; % Sampling rate in Hz
        min_duration = 50 / 1000 * fs; % Convert 50 ms to samples

        % Find significant epochs and their corresponding times for each condition
        significant_epochs1_region = find_significant_epochs(difference_wave1_region, threshold_2sd1_region, threshold_3sd1_region, min_duration, time);
        significant_epochs2_region = find_significant_epochs(difference_wave2_region, threshold_2sd2_region, threshold_3sd2_region, min_duration, time);

        % Display or process significant epochs for each condition
        disp('Significant epochs for condition 1 (start_idx, end_idx, start_time, end_time):');
        disp(significant_epochs1_region);

        disp('Significant epochs for condition 2 (start_idx, end_idx, start_time, end_time):');
        disp(significant_epochs2_region);
    end
end


