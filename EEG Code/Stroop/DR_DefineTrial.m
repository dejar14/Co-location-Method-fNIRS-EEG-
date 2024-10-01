function trl = DR_DefineTrial(cfg)
%% Define Trials
% Objective: Define the task trials using the code created event files from
% the [CreateEventFile.m] code.
% Author: De'Ja Rogers

%% Step 1: Read in Events
cd('XXX') % Path for the code created event files
tbl = readtable('XXX.txt', 'HeaderLines', 1); 

%% Step 2: Create events in readable format

event_data=tbl{:, :}; % Initialize Table

event = ft_read_event(cfg.eventfile, 'format', 'ascii');
event(1).value = event_data(:,3);
event(1).sample = event_data(:,2);
event(1).duration = event_data(:,4);
event(1).type = 'trigger';
event(1).offset = -1; % set Offset
event(1).times = event_data(:,5);

events      = event; 
values      = {events.value};
samples     = {events.sample};
times       = {events.times};

%% Step3: Initiate the time desired before and after the stimulus
prestim    = .5;
poststim   = 1;

pretrig    = -round(prestim * 500);
posttrig   = round(poststim * 500);

for i = 1:length(samples{1})
    trlnum(i)    = i;
    trlType(i)   = values{1}(i);
    begsample(i) = samples{1}(i) + pretrig;
    endsample(i) = samples{1}(i) + posttrig;
    offset(i)    = pretrig;
end
%% Step 4: Return Trial Data to Master Code

trl = [begsample' endsample' offset' trlnum' trlType']; % Return Value to Master Code
end

