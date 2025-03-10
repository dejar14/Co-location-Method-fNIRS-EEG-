%% Stroop Task Group Results
% Author: De'Ja Rogers
% Objective: Create plot for the average HRF of the channels in the region
% of interest and determine if the differences between the easy and hard
% levels are significant (with Subject Intervariability Included).

%% Load Subject and Group .xlsx Files

% Group 
% Read the entire Excel file into a cell array
[~, ~, a] = xlsread('Co-Location Study_dataset_SplineSG_HRF.xlsx');

% Now you can manually access the second row, which should contain your variable names
variableNames = a(2, :);  % Extract the second row as variable names

time = cell2mat(a(3:end, 1)); % Time Vector

% Extract the first row (group identifiers) as a cell array
group_ids = a(1, 2:end); % Convert the first row into a cell array

group_ids_numeric = NaN(1, length(group_ids)); % Initialize an array to store numeric group IDs

for i = 1:length(group_ids)
    % Check if the element is already numeric
    if isnumeric(group_ids{i})
        group_ids_numeric(i) = group_ids{i}; % If numeric, store directly
    else
        % If it's a string, convert it to a numeric value using str2double
        group_ids_numeric(i) = str2double(group_ids{i}); 
    end
end

% Extract the table values (from row 2 onwards, excluding the first column)
a_values = a(2:end, 2:end); 

% Find indices of columns where group_ids_numeric equals 2 (Easy Level)
columns_with_2 = (group_ids_numeric == 2); % Logical index of columns with 2 (Easy Level)
columns_with_3 = (group_ids_numeric == 3); % Logical index of columns with 3 (Hard Level)

% Extract those columns from the a_values
groupEasy = a_values(:, columns_with_2);
groupHard = a_values(:, columns_with_3);

% Separate Columns into HbO and HbR
groupEasyHbO = groupEasy(:, 1:3:end);
groupEasyHbR = groupEasy(:, 2:3:end);

groupHardHbO = groupHard(:, 1:3:end);
groupHardHbR = groupHard(:, 2:3:end);

% Define the subject numbers (non-sequential)
subject_list = {'SS017', 'SS018', 'SS019', 'SS022', 'SS023', 'SS024', ...
                'SS025', 'SS028', 'SS029', 'SS031', 'SS032', 'SS033', 'SS034'};

% Initialize a structure to store subject data
subjectData = struct();

% Loop through each subject in the subject list
for idx = 1:length(subject_list)
    subject_str = subject_list{idx}; % Get the subject string, e.g., 'SS017'
    
    % Construct the filename dynamically for each subject
    filename = sprintf('sub-%s_HRF.xlsx', subject_str); % Assuming each subject has a separate file
    
    % Load the table for the current subject
    [~, ~, a] = xlsread(filename);
    
    % Extract the first row (subject identifiers) as a cell array
    subject_ids = a(1, 2:end); % Convert the first row into a cell array
    
    % Convert subject IDs to numeric values
    subject_ids_numeric = NaN(1, length(subject_ids)); % Initialize array
    for i = 1:length(subject_ids)
        if isnumeric(subject_ids{i})
            subject_ids_numeric(i) = subject_ids{i};
        else
            subject_ids_numeric(i) = str2double(subject_ids{i});
        end
    end

    % Extract the table values (from row 2 onwards, excluding the first column)
    a_values = a(2:end, 2:end);
    
    % Find indices of columns where subject_ids_numeric equals 2 (Easy Level)
    columns_with_2 = (subject_ids_numeric == 2); % Easy Level
    columns_with_3 = (subject_ids_numeric == 3); % Hard Level

    % Extract those columns from the a_values
    subjectEasy = a_values(:, columns_with_2);
    subjectHard = a_values(:, columns_with_3);

    % Separate Columns into HbO and HbR (adjust column indices if necessary)
    subjectEasyHbO = subjectEasy(:, 1:3:end);
    subjectEasyHbR = subjectEasy(:, 2:3:end);
    
    subjectHardHbO = subjectHard(:, 1:3:end);
    subjectHardHbR = subjectHard(:, 2:3:end);
    
    % Store the subject data in the structure
    subjectData.(subject_str).EasyHbO = subjectEasyHbO;
    subjectData.(subject_str).HardHbO = subjectHardHbO;
    subjectData.(subject_str).EasyHbR = subjectEasyHbR;
    subjectData.(subject_str).HardHbR = subjectHardHbR;
end

%% Initialize the region names and corresponding column indices

% Define Region column labels for HbO and HbR
left_dlpfc_lateral_HbO = {'HRF HbO,15,44', 'HRF HbO,15,45', 'HRF HbO,15,46', 'HRF HbO,15,47', 'HRF HbO,15,56', ...
    'HRF HbO,23,56', 'HRF HbO,24,32', 'HRF HbO,24,45', 'HRF HbO,24,46', 'HRF HbO,24,56'};

right_dlpfc_lateral_HbO = {'HRF HbO,11,3', 'HRF HbO,11,37', 'HRF HbO,11,38', 'HRF HbO,11,39', 'HRF HbO,11,52', ...
    'HRF HbO,19,27', 'HRF HbO,19,37', 'HRF HbO,19,38', 'HRF HbO,19,52', 'HRF HbO,20,37'};

dlpfc_dorsal_anteriorPFC_HbO = {'HRF HbO,4,4','HRF HbO,4,5', 'HRF HbO,4,15','HRF HbO,4,16','HRF HbO,4,17',...
    'HRF HbO,4,18', 'HRF HbO,4,29', 'HRF HbO,5,5', 'HRF HbO,5,6','HRF HbO,5,17','HRF HbO,5,18','HRF HbO,5,19', 'HRF HbO,5,20' ...
    'HRF HbO,5,30', 'HRF HbO,12,4', 'HRF HbO,12,14','HRF HbO,12,15' 'HRF HbO,12,16', 'HRF HbO,12,17', 'HRF HbO,12,28',...
    'HRF HbO,12,29', 'HRF HbO,12,38', 'HRF HbO,12,39', 'HRF HbO,12,40','HRF HbO,12,41','HRF HbO,12,53','HRF HbO,13,5', ...
    'HRF HbO,13,16','HRF HbO,13,17', 'HRF HbO,13,18' 'HRF HbO,13,19', 'HRF HbO,13,29','HRF HbO,13,30','HRF HbO,13,40', ...
    'HRF HbO,13,41','HRF HbO,13,42','HRF HbO,13,43','HRF HbO,13,54','HRF HbO,14,6','HRF HbO,14,18', 'HRF HbO,14,19',...
    'HRF HbO,14,20', 'HRF HbO,14,21','HRF HbO,14,30','HRF HbO,14,31','HRF HbO,14,42','HRF HbO,14,43','HRF HbO,14,44',...
    'HRF HbO,14,45','HRF HbO,14,55'};

left_temporal_HbO = {'HRF HbO,25,33','HRF HbO,25,47','HRF HbO,25,48','HRF HbO,25,49','HRF HbO,25,57','HRF HbO,25,58'};

right_temporal_HbO = {'HRF HbO,18,26','HRF HbO,18,34','HRF HbO,18,35','HRF HbO,18,36','HRF HbO,18,50','HRF HbO,18,51'};

left_dlpfc_lateral_HbR = {'HRF HbR,15,44', 'HRF HbR,15,45', 'HRF HbR,15,46', 'HRF HbR,15,47', 'HRF HbR,15,56', ...
    'HRF HbR,23,56', 'HRF HbR,24,32', 'HRF HbR,24,45', 'HRF HbR,24,46', 'HRF HbR,24,56'};

right_dlpfc_lateral_HbR = {'HRF HbR,11,3', 'HRF HbR,11,37', 'HRF HbR,11,38', 'HRF HbR,11,39', 'HRF HbR,11,52', ...
    'HRF HbR,19,27', 'HRF HbR,19,37', 'HRF HbR,19,38', 'HRF HbR,19,52', 'HRF HbR,20,37'};

dlpfc_dorsal_anteriorPFC_HbR = {'HRF HbR,4,4','HRF HbR,4,5', 'HRF HbR,4,15','HRF HbR,4,16','HRF HbR,4,17',...
    'HRF HbR,4,18', 'HRF HbR,4,29', 'HRF HbR,5,5', 'HRF HbR,5,6','HRF HbR,5,17','HRF HbR,5,18','HRF HbR,5,19', 'HRF HbR,5,20' ...
    'HRF HbR,5,30', 'HRF HbR,12,4', 'HRF HbR,12,14','HRF HbR,12,15' 'HRF HbR,12,16', 'HRF HbR,12,17', 'HRF HbR,12,28',...
    'HRF HbR,12,29', 'HRF HbR,12,38', 'HRF HbR,12,39', 'HRF HbR,12,40','HRF HbR,12,41','HRF HbR,12,53','HRF HbR,13,5', ...
    'HRF HbR,13,16','HRF HbR,13,17', 'HRF HbR,13,18' 'HRF HbR,13,19', 'HRF HbR,13,29','HRF HbR,13,30','HRF HbR,13,40', ...
    'HRF HbR,13,41','HRF HbR,13,42','HRF HbR,13,43','HRF HbR,13,54','HRF HbR,14,6','HRF HbR,14,18', 'HRF HbR,14,19',...
    'HRF HbR,14,20', 'HRF HbR,14,21','HRF HbR,14,30','HRF HbR,14,31','HRF HbR,14,42','HRF HbR,14,43','HRF HbR,14,44',...
    'HRF HbR,14,45','HRF HbR,14,55'};

left_temporal_HbR = {'HRF HbR,25,33','HRF HbR,25,47','HRF HbR,25,48','HRF HbR,25,49','HRF HbR,25,57','HRF HbR,25,58'};

right_temporal_HbR = {'HRF HbR,18,26','HRF HbR,18,34','HRF HbR,18,35','HRF HbR,18,36','HRF HbR,18,50','HRF HbR,18,51'};

% Group 

% Define the regions and their labels
regionsHbO = {left_dlpfc_lateral_HbO, right_dlpfc_lateral_HbO, dlpfc_dorsal_anteriorPFC_HbO, left_temporal_HbO, right_temporal_HbO};

regionsHbR = {left_dlpfc_lateral_HbR, right_dlpfc_lateral_HbR, dlpfc_dorsal_anteriorPFC_HbR, left_temporal_HbR, right_temporal_HbR};

groupData = {groupEasyHbO, groupEasyHbR, groupHardHbO, groupHardHbR};
labels = {'EasyHbO', 'EasyHbR', 'HardHbO', 'HardHbR'};
regionNames = {'LeftDLPFCLateral', 'RightDLPFCLateral', 'DLPFCDorsalAnteriorPFC', 'LeftTemporal', 'RightTemporal'};

% Initialize the structures
regionDataHbO = struct('Group', struct());
regionDataHbR = struct('Group', struct());

% Loop over each group (Easy/Hard, HbO/HbR)
for g = 1:length(groupData)
    currentGroup = groupData{g};  % Select current group (Easy or Hard)
    currentGroupLabel = labels{g};  % Label for current group
    
    % Ensure the first row contains the labels
    currentLabels = currentGroup(1, :);
    
    % Loop over each region
    for r = 1:length(regionsHbO)
        % Check if the region exists in the current group data
        regionLabelHbO = regionsHbO{r};
        regionLabelHbR = regionsHbR{r};
        
        % Find the indices of the region in the labels
        [~, idxHbO] = ismember(regionLabelHbO, currentLabels);  
        [~, idxHbR] = ismember(regionLabelHbR, currentLabels);  

        % Remove zero indices (regions not found)
        idxHbO = idxHbO(idxHbO > 0);
        idxHbR = idxHbR(idxHbR > 0);
        
        % Extract the data for each region
        matchingLabelsHbO = currentLabels(idxHbO);
        matchingDataHbO = currentGroup(2:end, idxHbO);
        matchingLabelsHbR = currentLabels(idxHbR);
        matchingDataHbR = currentGroup(2:end, idxHbR);
        
        % Store the labels and data in regionData for HbO or HbR
        if contains(currentGroupLabel, 'HbO')  % Focused on HbO group
            % regionDataHbO.Group.(regionNames{r}).currentGroupLabel(g).Labels = matchingLabelsHbO;
            regionDataHbO.Group.(regionNames{r}).(currentGroupLabel) = matchingDataHbO;
        elseif contains(currentGroupLabel, 'HbR')  % Focused on HbR group
            % regionDataHbR.Group.(regionNames{r}).currentGroupLabel(g).Labels = matchingLabelsHbR;
            regionDataHbR.Group.(regionNames{r}).(currentGroupLabel) = matchingDataHbR;
        end
    end
end


% Subject Level

subjectNames = fieldnames(subjectData);  % Get the field names of the subject data
for sub=1:length(subjectNames)
    currentSubjectName = subjectNames{sub};  % Get the current subject name (e.g., SS017)

    % Access the data for this subject (EasyHbO, EasyHbR, HardHbO, HardHbR)
    subjectDataFull = {subjectData.(currentSubjectName).EasyHbO, subjectData.(currentSubjectName).EasyHbR, ...
        subjectData.(currentSubjectName).HardHbO, subjectData.(currentSubjectName).HardHbR};
    
    % Loop over each group (Easy/Hard, HbO/HbR)
    for g = 1:length(groupData)
        currentGroup = subjectDataFull{g};  % Select current group (Easy or Hard)
        currentGroupLabel = labels{g};  % Label for current group
    
        % Ensure the first row contains the labels
        currentLabels = currentGroup(1, :);
    
        % Loop over each region
        for r = 1:length(regionsHbO)
            % Check if the region exists in the current group data
            regionLabelHbO = regionsHbO{r};
            regionLabelHbR = regionsHbR{r};
        
            % Find the indices of the region in the labels
            [~, idxHbO] = ismember(regionLabelHbO, currentLabels);  
            [~, idxHbR] = ismember(regionLabelHbR, currentLabels);  

            % Remove zero indices (regions not found)
            idxHbO = idxHbO(idxHbO > 0);
            idxHbR = idxHbR(idxHbR > 0);
        
            % Extract the data for each region
            matchingLabelsHbO = currentLabels(idxHbO);
            matchingDataHbO = currentGroup(2:end, idxHbO);
            matchingLabelsHbR = currentLabels(idxHbR);
            matchingDataHbR = currentGroup(2:end, idxHbR);
            
            % Store the labels and data for the group (HbO or HbR)
            if contains(currentGroupLabel, 'HbO')  % Focused on HbO group
                % regionDataHbO.(currentSubjectName).(regionNames{r}).Labels = matchingLabelsHbO;
                regionDataHbO.(currentSubjectName).(regionNames{r}).(currentGroupLabel) = matchingDataHbO;
            elseif contains(currentGroupLabel, 'HbR')  % Focused on HbR group
                % regionDataHbR.(currentSubjectName).(regionNames{r}).Labels = matchingLabelsHbR;
                regionDataHbR.(currentSubjectName).(regionNames{r}).(currentGroupLabel) = matchingDataHbR;
            end
        end
    end
end

%% Take means and standard deviations

% Initialize variables
subjects = {'Group', 'SS017', 'SS018', 'SS019', 'SS022', 'SS023', 'SS024', ...
                'SS025', 'SS028', 'SS029', 'SS031', 'SS032', 'SS033', 'SS034'};

regions =  {'LeftDLPFCLateral', 'RightDLPFCLateral', 'DLPFCDorsalAnteriorPFC', ...
    'LeftTemporal', 'RightTemporal'};

dataType = {'HbO', 'HbR'}; % Specify the data type

% Process each subject and region
for i = 1:length(subjects)
    subject = subjects{i};
    for j = 1:length(regions)
        region = regions{j};
        for m = 1:length(labels)
            label = labels{m};
            for k = 1:length(dataType)
            type = dataType{k};

                % Construct the variable name dynamically
                variableName = sprintf('regionData%s.%s.%s.%s', type, subject, region, label);
                
                try
                    % Load the variable dynamically if it exists
                    data = eval(variableName); % Load the data  
                    for idx = 1:numel(data)
                        if ischar(data{idx}) && any(strcmp(strtrim(data{idx}), {'NaN', '         NaN'}))
                            data{idx} = NaN;  % Convert string 'NaN' to numeric NaN
                        end
                    end 

                    data=cell2mat(data);

                    % Calculate the mean and standard deviation
                    meanFieldName = sprintf('mean%s', label);
                    stdFieldName = sprintf('std%s', label);

                    if strcmp(type, 'HbO')
                        % Store the results in the same structure
                        regionDataHbO.(subject).(region).(meanFieldName) = mean(data, 2, 'omitnan');
                        regionDataHbO.(subject).(region).(stdFieldName) = std(data, 0, 2, 'omitnan');
                    else
                        % Store the results in the same structure
                        regionDataHbR.(subject).(region).(meanFieldName) = mean(data, 2, 'omitnan');
                        regionDataHbR.(subject).(region).(stdFieldName) = std(data, 0, 2, 'omitnan');
                    end
            
                catch ME
                    % Handle error if the variable does not exist
                    fprintf('Error at (%d, %d, %d): %s\n', i, j, k, ME.message);
                    continue; % Skip iteration if error occurs
                end
            end
         end
     end
 end

%% Main Figure: Channel Space Plot Code

% Easy
% LeftDLPFCLateral
subjectEasyHbOs_LeftDLPFCLateral = [regionDataHbO.SS017.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS018.LeftDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS019.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS022.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS023.LeftDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS024.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS025.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS028.LeftDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS029.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS031.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS032.LeftDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS033.LeftDLPFCLateral.meanEasyHbO, regionDataHbO.SS034.LeftDLPFCLateral.meanEasyHbO];

subjectEasyHbRs_LeftDLPFCLateral = [regionDataHbR.SS017.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS018.LeftDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS019.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS022.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS023.LeftDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS024.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS025.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS028.LeftDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS029.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS031.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS032.LeftDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS033.LeftDLPFCLateral.meanEasyHbR, regionDataHbR.SS034.LeftDLPFCLateral.meanEasyHbR];

% RightDLPFCLateral
subjectEasyHbOs_RightDLPFCLateral = [regionDataHbO.SS017.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS018.RightDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS019.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS022.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS023.RightDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS024.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS025.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS028.RightDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS029.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS031.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS032.RightDLPFCLateral.meanEasyHbO, ...
    regionDataHbO.SS033.RightDLPFCLateral.meanEasyHbO, regionDataHbO.SS034.RightDLPFCLateral.meanEasyHbO];

subjectEasyHbRs_RightDLPFCLateral = [regionDataHbR.SS017.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS018.RightDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS019.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS022.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS023.RightDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS024.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS025.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS028.RightDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS029.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS031.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS032.RightDLPFCLateral.meanEasyHbR, ...
    regionDataHbR.SS033.RightDLPFCLateral.meanEasyHbR, regionDataHbR.SS034.RightDLPFCLateral.meanEasyHbR];

% Hard
% LeftDLPFCLateral
subjectHardHbOs_LeftDLPFCLateral = [regionDataHbO.SS017.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS018.LeftDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS019.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS022.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS023.LeftDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS024.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS025.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS028.LeftDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS029.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS031.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS032.LeftDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS033.LeftDLPFCLateral.meanHardHbO, regionDataHbO.SS034.LeftDLPFCLateral.meanHardHbO];

subjectHardHbRs_LeftDLPFCLateral = [regionDataHbR.SS017.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS018.LeftDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS019.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS022.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS023.LeftDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS024.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS025.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS028.LeftDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS029.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS031.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS032.LeftDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS033.LeftDLPFCLateral.meanHardHbR, regionDataHbR.SS034.LeftDLPFCLateral.meanHardHbR];

% RightDLPFCLateral
subjectHardHbOs_RightDLPFCLateral = [regionDataHbO.SS017.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS018.RightDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS019.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS022.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS023.RightDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS024.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS025.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS028.RightDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS029.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS031.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS032.RightDLPFCLateral.meanHardHbO, ...
    regionDataHbO.SS033.RightDLPFCLateral.meanHardHbO, regionDataHbO.SS034.RightDLPFCLateral.meanHardHbO];

subjectHardHbRs_RightDLPFCLateral = [regionDataHbR.SS017.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS018.RightDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS019.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS022.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS023.RightDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS024.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS025.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS028.RightDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS029.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS031.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS032.RightDLPFCLateral.meanHardHbR, ...
    regionDataHbR.SS033.RightDLPFCLateral.meanHardHbR, regionDataHbR.SS034.RightDLPFCLateral.meanHardHbR];

%% Perform pairwise t-tests
% ROIs Only
HRFPeakTime=time(60:133,:);

% Left
[hLHbO,pLHbO,ciLHbO,statsLHbO] = ttest(mean(subjectEasyHbOs_LeftDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbOs_LeftDLPFCLateral(60:133,:), 'omitnan'));
[hLHbR,pLHbR,ciLHbR,statsLHbR] = ttest(mean(subjectEasyHbRs_LeftDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbRs_LeftDLPFCLateral(60:133, :), 'omitnan'));

% Right
[hRHbO,pRHbO,ciRHbO,statsRHbO] = ttest(mean(subjectEasyHbOs_RightDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbOs_RightDLPFCLateral(60:133, :), 'omitnan'));
[hRHbR,pRHbR,ciRHbR,statsRHbR] = ttest(mean(subjectEasyHbRs_RightDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbRs_RightDLPFCLateral(60:133, :), 'omitnan'));

disp(['Left HbO pvalue: ', num2str(pLHbO), ' Right HbO pvalue: ', num2str(pLHbR)]);
disp(['Left HbR pvalue: ', num2str(pRHbO), ' Right HbR pvalue: ', num2str(pRHbR)]);

%% Compute Cohen's d Effect Size for Paired a

% HbO
% Compute subject-level differences
subjectDiffsHbO_Left = subjectHardHbOs_LeftDLPFCLateral(60:133, :) - subjectEasyHbOs_LeftDLPFCLateral(60:133, :);
subjectDiffsHbO_Right = subjectHardHbOs_RightDLPFCLateral(60:133, :) - subjectEasyHbOs_RightDLPFCLateral(60:133, :);

% Compute mean difference and standard deviation of the differences
meanDiffHbO_Left = mean(mean(subjectDiffsHbO_Left, 1));  % Average across subjects and time
stdDiffHbO_Left = std(mean(subjectDiffsHbO_Left, 1));    % Standard deviation across subjects

meanDiffHbO_Right = mean(mean(subjectDiffsHbO_Right, 1));
stdDiffHbO_Right = std(mean(subjectDiffsHbO_Right, 1));

% Compute Cohen's d for each ROI
cohensd_Left = meanDiffHbO_Left / stdDiffHbO_Left;
cohensd_Right = meanDiffHbO_Right / stdDiffHbO_Right;

% Display results
disp(['Cohen''s d (HbO) - Left ROI: ', num2str(cohensd_Left)])
disp(['Cohen''s d (HbO) - Right ROI: ', num2str(cohensd_Right)])

% HbR
% Compute subject-level differences
subjectDiffsHbR_Left = subjectHardHbRs_LeftDLPFCLateral(60:133, :) - subjectEasyHbRs_LeftDLPFCLateral(60:133, :);
subjectDiffsHbR_Right = subjectHardHbRs_RightDLPFCLateral(60:133, :) - subjectEasyHbRs_RightDLPFCLateral(60:133, :);

% Compute mean difference and standard deviation of the differences
meanDiffHbR_Left = mean(mean(subjectDiffsHbR_Left, 1));  % Average across subjects and time
stdDiffHbR_Left = std(mean(subjectDiffsHbR_Left, 1));    % Standard deviation across subjects

meanDiffHbR_Right = mean(mean(subjectDiffsHbR_Right, 1));
stdDiffHbR_Right = std(mean(subjectDiffsHbR_Right, 1));

% Compute Cohen's d for each ROI
cohensd_LeftHBR = meanDiffHbR_Left / stdDiffHbR_Left;
cohensd_RightHBR = meanDiffHbR_Right / stdDiffHbR_Right;

% Display results
disp(['Cohen''s d (HbR) - Left ROI: ', num2str(cohensd_LeftHBR)])
disp(['Cohen''s d (HbR) - Right ROI: ', num2str(cohensd_RightHBR)])

%% Perform pairwise t-test against rest

restTime=time(1:10,:);

% ROIs Only
% Left HbO
[hLHbO1EasyLeft,pLHbO1EasyLeft,ciLHbO1EasyLeft,statsLHbO1EasyLeft] = ttest(mean(subjectEasyHbOs_LeftDLPFCLateral(60:133, :), 'omitnan'), mean(subjectEasyHbOs_LeftDLPFCLateral(1:10,:), 'omitnan'));
[hLHbO1HardLeft,pLHbO1HardLeft,ciLHbO1HardLeft,statsLHbO1HardLeft] = ttest(mean(subjectHardHbOs_LeftDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbOs_LeftDLPFCLateral(1:10,:), 'omitnan'));

% Left HbR
[hLHbR1EasyLeft,pLHbR1EasyLeft,ciLHbR1EasyLeft,statsLHbR1EasyLeft] = ttest(mean(subjectEasyHbRs_LeftDLPFCLateral(60:133, :), 'omitnan'), mean(subjectEasyHbRs_LeftDLPFCLateral(1:10,:), 'omitnan'));
[hLHbR1HardLeft,pLHbR1HardLeft,ciLHbR1HardLeft,statsLHbR1HardLeft] = ttest(mean(subjectHardHbRs_LeftDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbRs_LeftDLPFCLateral(1:10,:), 'omitnan'));

% Right HbO
[hRHbO1EasyRight,pRHbO1EasyRight,ciRHbO1EasyRight,statsRHbO1EasyRight] = ttest(mean(subjectEasyHbOs_RightDLPFCLateral(60:133, :), 'omitnan'), mean(subjectEasyHbOs_RightDLPFCLateral(1:10,:), 'omitnan'));
[hRHbO1HardRight,pRHbO1HardRight,ciRHbO1HardRight,statsRHbO1HardRight] = ttest(mean(subjectHardHbOs_RightDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbOs_RightDLPFCLateral(1:10,:), 'omitnan'));

% Right HbR
[hRHbR1EasyRight,pRHbR1EasyRight,ciRHbR1EasyRight,statsRHbR1EasyRight] = ttest(mean(subjectEasyHbRs_RightDLPFCLateral(60:133, :), 'omitnan'), mean(subjectEasyHbRs_RightDLPFCLateral(1:10,:), 'omitnan'));
[hRHbR1HardRight,pRHbR1HardRight,ciRHbR1HardRight,statsRHbR1HardRight] = ttest(mean(subjectHardHbRs_RightDLPFCLateral(60:133, :), 'omitnan'), mean(subjectHardHbRs_RightDLPFCLateral(1:10,:), 'omitnan'));


disp(['Left HbO pvalue (Easy): ', num2str(pLHbO1EasyLeft), 'Left HbO pvalue (Hard): ', num2str(pLHbO1HardLeft), ...
    ' Right HbO pvalue (Easy): ', num2str(pRHbO1EasyRight), 'Right HbO pvalue (Hard): ', num2str(pRHbO1HardRight)]);

disp(['Left HbR pvalue (Easy): ', num2str(pLHbR1EasyLeft), 'Left HbR pvalue (Hard): ', num2str(pLHbR1HardLeft), ...
    ' Right HbR pvalue (Easy): ', num2str(pRHbR1EasyRight), 'Right HbR pvalue (Hard): ', num2str(pRHbR1HardRight)]);

%% Compute Cohen's d Effect Size for pairwise comparison against rest

% HbO
% Compute subject-level differences
subjectDiffsHbO_LeftEasy = mean(subjectEasyHbOs_LeftDLPFCLateral(60:133, :), 1) - mean(subjectEasyHbOs_LeftDLPFCLateral(1:10, :), 1);
subjectDiffsHbO_LeftHard = mean(subjectHardHbOs_LeftDLPFCLateral(60:133, :), 1) - mean(subjectHardHbOs_LeftDLPFCLateral(1:10, :), 1);

subjectDiffsHbO_RightEasy = mean(subjectEasyHbOs_RightDLPFCLateral(60:133, :), 1) - mean(subjectEasyHbOs_RightDLPFCLateral(1:10, :), 1);
subjectDiffsHbO_RightHard = mean(subjectHardHbOs_RightDLPFCLateral(60:133, :), 1) - mean(subjectHardHbOs_RightDLPFCLateral(1:10, :), 1);

% Compute mean difference and standard deviation of the differences
meanDiffHbO_LeftEasy = mean(subjectDiffsHbO_LeftEasy);
stdDiffHbO_LeftEasy = std(subjectDiffsHbO_LeftEasy);

meanDiffHbO_LeftHard = mean(subjectDiffsHbO_LeftHard);
stdDiffHbO_LeftHard = std(subjectDiffsHbO_LeftHard);

meanDiffHbO_RightEasy = mean(subjectDiffsHbO_RightEasy);
stdDiffHbO_RightEasy = std(subjectDiffsHbO_RightEasy);

meanDiffHbO_RightHard = mean(subjectDiffsHbO_RightHard);
stdDiffHbO_RightHard = std(subjectDiffsHbO_RightHard);

% Compute Cohen's d for each ROI (handling division by zero)
cohensd_LeftEasy = meanDiffHbO_LeftEasy / (stdDiffHbO_LeftEasy + (stdDiffHbO_LeftEasy == 0));
cohensd_LeftHard = meanDiffHbO_LeftHard / (stdDiffHbO_LeftHard + (stdDiffHbO_LeftHard == 0));

cohensd_RightEasy = meanDiffHbO_RightEasy / (stdDiffHbO_RightEasy + (stdDiffHbO_RightEasy == 0));
cohensd_RightHard = meanDiffHbO_RightHard / (stdDiffHbO_RightHard + (stdDiffHbO_RightHard == 0));

% Display results
disp(['Cohen''s d (HbO) - Left Easy ROI: ', num2str(cohensd_LeftEasy)])
disp(['Cohen''s d (HbO) - Left Hard ROI: ', num2str(cohensd_LeftHard)])
disp(['Cohen''s d (HbO) - Right Easy ROI: ', num2str(cohensd_RightEasy)])
disp(['Cohen''s d (HbO) - Right Hard ROI: ', num2str(cohensd_RightHard)])

% HbR
% Compute subject-level differences
subjectDiffsHbR_LeftEasy = mean(subjectEasyHbRs_LeftDLPFCLateral(60:133, :), 1) - mean(subjectEasyHbRs_LeftDLPFCLateral(1:10, :), 1);
subjectDiffsHbR_LeftHard = mean(subjectHardHbRs_LeftDLPFCLateral(60:133, :), 1) - mean(subjectHardHbRs_LeftDLPFCLateral(1:10, :), 1);

subjectDiffsHbR_RightEasy = mean(subjectEasyHbRs_RightDLPFCLateral(60:133, :), 1) - mean(subjectEasyHbRs_RightDLPFCLateral(1:10, :), 1);
subjectDiffsHbR_RightHard = mean(subjectHardHbRs_RightDLPFCLateral(60:133, :), 1) - mean(subjectHardHbRs_RightDLPFCLateral(1:10, :), 1);

% Compute mean difference and standard deviation of the differences
meanDiffHbR_LeftEasy = mean(subjectDiffsHbR_LeftEasy);
stdDiffHbR_LeftEasy = std(subjectDiffsHbR_LeftEasy);

meanDiffHbR_LeftHard = mean(subjectDiffsHbR_LeftHard);
stdDiffHbR_LeftHard = std(subjectDiffsHbR_LeftHard);

meanDiffHbR_RightEasy = mean(subjectDiffsHbR_RightEasy);
stdDiffHbR_RightEasy = std(subjectDiffsHbR_RightEasy);

meanDiffHbR_RightHard = mean(subjectDiffsHbR_RightHard);
stdDiffHbR_RightHard = std(subjectDiffsHbR_RightHard);

% Compute Cohen's d for each ROI (handling division by zero)
cohensd_LeftEasy = meanDiffHbR_LeftEasy / (stdDiffHbR_LeftEasy + (stdDiffHbR_LeftEasy == 0));
cohensd_LeftHard = meanDiffHbR_LeftHard / (stdDiffHbR_LeftHard + (stdDiffHbR_LeftHard == 0));

cohensd_RightEasy = meanDiffHbR_RightEasy / (stdDiffHbR_RightEasy + (stdDiffHbR_RightEasy == 0));
cohensd_RightHard = meanDiffHbR_RightHard / (stdDiffHbR_RightHard + (stdDiffHbR_RightHard == 0));

% Display results
disp(['Cohen''s d (HbR) - Left Easy ROI: ', num2str(cohensd_LeftEasy)])
disp(['Cohen''s d (HbR) - Left Hard ROI: ', num2str(cohensd_LeftHard)])
disp(['Cohen''s d (HbR) - Right Easy ROI: ', num2str(cohensd_RightEasy)])
disp(['Cohen''s d (HbR) - Right Hard ROI: ', num2str(cohensd_RightHard)])
