%% Function to Find Significant Epochs
% Objective: Find significant epochs and their corresponding times
% Author: De'Ja Rogers

function significant_epochs = find_significant_epochs(difference_wave, threshold_2sd, threshold_3sd, min_duration, time)
    deviation_indices = find(abs(difference_wave) > threshold_2sd);
    significant_epochs = [];
    if ~isempty(deviation_indices)
        start_idx = deviation_indices(1);
        for i = 2:length(deviation_indices)
            if deviation_indices(i) ~= deviation_indices(i-1) + 1
                if deviation_indices(i-1) - start_idx + 1 >= min_duration
                    if any(abs(difference_wave(start_idx:deviation_indices(i-1))) > threshold_3sd)
                        significant_epochs = [significant_epochs; start_idx, deviation_indices(i-1), time(start_idx), time(deviation_indices(i-1))];
                    end
                end
                start_idx = deviation_indices(i);
            end
        end
        if deviation_indices(end) - start_idx + 1 >= min_duration
            if any(abs(difference_wave(start_idx:deviation_indices(end))) > threshold_3sd)
                significant_epochs = [significant_epochs; start_idx, deviation_indices(end), time(start_idx), time(deviation_indices(end))];
            end
        end
    end
end
