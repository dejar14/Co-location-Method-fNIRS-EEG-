%% Creating Event Files
% Objective: For data collected using BrainVision LiveAmp 32 elecrode system with the
% trigger extension, the trigger is recorded as an auxilary channel. This
% code converts the channel of triggers into a Fieldtrip Program compatible
% event file, with only the correct (trials the subject answered correctly)
% trials remaining.
% Author: De'Ja Rogers

%% Step 1: Set Up File Location

folderName='XXX'; % Input Desired Path
fileName='XXX'; % Input Desired EEG File Name

%% Step 2: Load File Routine

% Make sure the supporting functions folder and subfolders are added to
% path
global BTB  %<--- needs to be done for the BV functions to work
BTB=[];
BTB.TypeChecking=0;

FILE=[folderName,filesep,fileName];

[CNT, MRK, HDR]= file_readBV(FILE);

%% Step 3: Create Time Vector

Ts=1/CNT.fs;
t=linspace(0,1,CNT.T)*CNT.T*Ts;
%% Step 4: Load Behavioral Data from PsychoPy File

cd('XXX'); % Insert Path

file=readtable('XXX'); % Insert Name of File
triggers=CNT.x(:,33); % Trigger is read as channel 33

%% Step 5: Plot the Triggers to Confirm its Presence and that Total Trigger Amount is Correct

 figure(1)
 plot(t,CNT.x(:,33),'r');
 title(['Trigger Channel Visualized ',fileName]);
 xlabel('Time [s]');
 ylabel(['Voltage [',CNT.yUnit,']']);

 %% Extract Trigger Times, Correctness, and Response Times

triggerData = CNT.x(:,33); % Trigger Channel
risingEdges = diff(triggerData) > 1*10^6; % Find trigger locations
triggerTimes = find(risingEdges); % find the rising edges of the triggers
triggerTimesMs = t(triggerTimes); % record these times

% Find the indices where adjacent values differ by less 3 (Stroop)
indices_to_remove = find(diff(triggerTimesMs) < 3) + 1;
ir= find(diff(triggerTimes) < 3) + 1;

% Remove the second value at each index where adjacent values are too close
triggerTimesMs(indices_to_remove) = [];
triggerTimes(ir)=[];

% Correct Trials
% Choose the column and rows that correspond to whether the subject
% answered correctly for the trials
trialsCorr=table2array(file(11:end,100)); % cols and rows vary based on PsychoPy setup
trialsCorr(isnan(trialsCorr)) = [];

% Record the Response Times
% Choose the column and rows that correspond to the response time
rtimes=table2array(file(11:end,101)); % cols and rows vary based on PsychoPy setup
rtimes(61:7:end)=[];  % col and rows vary based on PsychoPy setup
rtimes(isnan(rtimes)) = 2;

%% Create Event Data
event_duration = 0.1; % set event duration 
eventData = cell(length(triggerTimesMs), 6); % Create Cell for the event data
event_codes=table2array(file(11:end,3)); % cols and rows vary based on PsychoPy setup
event_codes(61:7:end)=[]; % cols and rows vary based on PsychoPy setup
event_codes(isnan(event_codes)) = [];

% Code for Correcting the Stroop Value (Easy (2) and Hard (3) Levels)
for j = 1:length(event_codes)
    if event_codes(j)==2
        event_codes(j)=3;
    end
     if event_codes(j)==1
        event_codes(j)=2;
    end   
end

% Fill Event Data Cell
for i = 1:length(triggerTimesMs)
    eventData{i, 1} = i; % trial number
    eventData{i, 2} = triggerTimes(i); % idx
    eventData{i, 3} = event_codes(i); % event code
    eventData{i, 4} = event_duration; % duration
    eventData{i, 5} = triggerTimesMs(i); % onset time 
    eventData{i, 6} = rtimes(i); % response onset time
end

eventData=cell2mat(eventData);

% Keep only the Trials that the Subject answered correctly
for i = length(trialsCorr):-1:1
     if trialsCorr(i)==0
         eventData(i,:)=[];
     end 
end

eventData=num2cell(eventData,6);

cd('XXX'); % Input Desired Path Location 

%% Save Event Data as a Text File

fid = fopen('XXX_eventfile_correctOnly.txt', 'w'); % Set event file name
fprintf(fid, 'trialNum\tsample_number\tvalue\tduration\tOnsetTime\tResponseTime\n');
for i = 1:length(eventData)
    fprintf(fid, '%d\t%d\t%d\t%f\t%f\t%f\n', eventData{i, :});
end
fclose(fid);