%% Create EEG Probe Layout
% Objective: Create a Customized EEG Probe Layout
% Author: De'Ja Rogers

% 
cd('XXX') % Go to Path
tbl = readtable('CustomLayout'); % Read in .txt file with your probe name and coordinates

lay=[];
lay(1).pos=table2array(tbl(:,2:3));
lay(1).label=table2array(tbl(:,6));
lay(1).width=table2array(tbl(:,4));
lay(1).height=table2array(tbl(:,5));
save('CustomLayout.mat', 'lay', '-v7.3' ) % Save Custom Layout