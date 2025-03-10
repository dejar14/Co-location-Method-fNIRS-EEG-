% Define subject list
subjects = {'SS017', 'SS018', 'SS019', 'SS022', 'SS023', 'SS024', ...
            'SS025', 'SS028', 'SS029', 'SS031', 'SS032', 'SS033', 'SS034'}; 

% Define conditions
conditions = {'EasyHbO', 'HardHbO', 'EasyHbR', 'HardHbR'};

% Define regions (modify if needed)
region = {'LeftDLPFCLateral', 'RightDLPFCLateral'}; % Adjust this to match your data structure

% Define options
options = {'HbO', 'HbR'};

% Initialize storage for group results
groupMean = struct();
groupStdErr = struct();

% Loop through each condition
for j = 1:length(conditions)
    condition = conditions{j};
    
    % Initialize temporary storage for all subjects' data
    allSubjectsData = [];
    
    % Loop through each option (HbO, HbR)
    for opt = 1:length(options)
        % Initialize storage for current option's data
        optionData = [];
        
        % Loop through each subject
        for i = 1:length(subjects)
            subj = subjects{i};
            
            % Construct the correct field name based on the current option
            fieldName = sprintf('regionData%s.%s.%s.mean%s', options{opt}, subj, region{1}, condition);
            
            % Check if the field exists in the correct structure
            if isfield(eval(['regionData', options{opt}]), subj) && isfield(eval(['regionData', options{opt}]).(subj), region{1}) && isfield(eval(['regionData', options{opt}]).(subj).(region{1}), ['mean', condition])
                subjectData = eval(['regionData', options{opt}]).(subj).(region{1}).(['mean', condition]);
                
                % Store subject data in matrix (columns: subjects, rows: time points)
                optionData(:, i) = subjectData;
            else
                warning('Field %s not found.', fieldName);
            end
        end
        
        % Store the data from all subjects for the current option
        allSubjectsData{opt} = optionData;
    end
    
    % Compute group mean and standard error across subjects for each condition
    groupMean.(condition) = mean(cell2mat(allSubjectsData), 2, 'omitnan'); % Mean across subjects (column-wise)
    groupStdErr.(condition) = std(cell2mat(allSubjectsData), 0, 2, 'omitnan') / sqrt(size(cell2mat(allSubjectsData), 2)); % Standard error
end

% Save results
save('Group_Mean_StdErr.mat', 'groupMean', 'groupStdErr');

% Plot
% Load the group mean and standard error data if not already in workspace
load('Group_Mean_StdErr.mat');

% Define time vector (modify this based on your actual time course)
timeVector = time';

% Define conditions and titles for subplots
conditions = {'EasyHbO', 'HardHbO', 'EasyHbR', 'HardHbR'};
titles = {'AVG HRF in the Left DLPFC (Easy Level)', 'AVG HRF in the Left DLPFC (Hard Level)', 'AVG HRF in the Right DLPFC (Easy Level)', 'AVG HRF in the Right DLPFC (Hard Level)'};

% Colors for HbO (red) and HbR (blue)
colorHbO = [1 0 0]; % Red
colorHbR = [0 0 1]; % Blue

figure;
for j = 1:length(conditions)
    subplot(2,2,j); hold on;
    
    condition = conditions{j};

    % Extract group mean and standard error for both HbO and HbR
    meanHbO = groupMean.(strrep(condition, 'HbR', 'HbO')); % Replace HbR with HbO in the condition string for HbO data
    stderrHbO = groupStdErr.(strrep(condition, 'HbR', 'HbO')); % Similarly for HbO standard error
    meanHbR = groupMean.(strrep(condition, 'HbO', 'HbR')); % Replace HbO with HbR in the condition string for HbR data
    stderrHbR = groupStdErr.(strrep(condition, 'HbO', 'HbR')); % Similarly for HbR standard error

    % Plot the y=0 line first, and set it to be behind other plot elements
    plot(timeVector, zeros(length(timeVector),1), 'k', 'LineWidth', 1, 'HandleVisibility', 'off'); % y=0 line

    % Plot the mean time course for HbO
    plot(timeVector, meanHbO, 'Color', colorHbO, 'LineWidth', 2, 'DisplayName', ['HbO ', condition]);

    % Plot standard error for HbO as a shaded region
    fill([timeVector, fliplr(timeVector)], ...
         [meanHbO + stderrHbO; flipud(meanHbO - stderrHbO)], ...
         colorHbO, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

    % Plot the mean time course for HbR
    plot(timeVector, meanHbR, 'Color', colorHbR, 'LineWidth', 2, 'DisplayName', ['HbR ', condition]);

    % Plot standard error for HbR as a shaded region
    fill([timeVector, fliplr(timeVector)], ...
         [meanHbR + stderrHbR; flipud(meanHbR - stderrHbR)], ...
         colorHbR, 'FaceAlpha', 0.2, 'EdgeColor', 'none'); 

    % Formatting each subplot
    xlabel('Time (s)', 'FontSize', 18)
    ylabel('HRF (M mm)', 'FontSize', 18)
    title(titles{j}, 'FontSize', 18);
    ax = gca; % Get current axis
    xlim([-2 30]); % Set x-axis limit
    ylim([-3*10e-6 3*10e-6]); % Set y-axis limit
end


% Create one legend for all subplots
% Dummy lines for the legend
hold on;
plot(NaN, NaN, 'Color', colorHbO, 'LineWidth', 2); % Dummy HbO line
fill([NaN NaN], [NaN NaN], colorHbO, 'FaceAlpha', 0.2, 'EdgeColor', 'none'); % Dummy HbO shaded region
plot(NaN, NaN, 'Color', colorHbR, 'LineWidth', 2); % Dummy HbR line
fill([NaN NaN], [NaN NaN], colorHbR, 'FaceAlpha', 0.2, 'EdgeColor', 'none'); % Dummy HbR shaded region

% Legend entries
legend({'HbO Regional Average', 'HbO Standard Error Envelope', 'HbR Regional Average', 'HbR Standard Error Envelope'}, 'Location', 'bestoutside', 'FontSize', 18);

% Adjust spacing and set the font size of sgtitle
sgtitle('Group-Averaged Hemodynamic Response with Standard Error', 'FontSize', 18);

