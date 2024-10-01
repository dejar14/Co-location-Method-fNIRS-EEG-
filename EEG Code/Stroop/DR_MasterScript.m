%% DR_MasterScript
% Objective: Extract, Analyze, and Save the ERP Signatures at the subject
% level
% Author: De'Ja Rogers and Shrey Grover

%% Initializations

% dataFolder:   folder where the raw EEG data is located
% saveloc:      location where processed data can be stored
% eegfilename:  essentially a single element from a vector consisting of EEG file names stored in the dataFolder
% sublabel:     if any particular labeling scheme needs to be used for saving data 
% layout:       probe design created/used

dataFolder       = 'XXX';
saveloc          = 'XXX';
eeg_filename     = 'XXX.eeg';
fileName         = 'XXX';
layout           = 'CustomLayout'; 

%% Step 1. Preprocessing: Re-referencing, detrending and filtering, and trial definition

cfg             = [];
cfg.dataset     = [dataFolder filesep eeg_filename];
cfg.eventfile = 'XXX';
cfg.trialfun    = 'DR_DefineTrial'; 
defs            = ft_definetrial(cfg);

% Remove the trl matrix prior to other preprocessing steps
fullcfg         = rmfield(defs,'trl');
data            = ft_preprocessing(fullcfg);

% Perform Detrending and Filtering
cfg              = [];
cfg.demean       = 'yes';
cfg.bpfilter     = 'yes';       % enable band-pass filtering
cfg.bpfilttype   = 'firws';
cfg.bpfreq       = [.1 30];      % bandpass: [High-pass freq, Low-pass freq];
cfg.detrend      = 'yes';
data             = ft_preprocessing(cfg, data);

% look at refs and determine implicit for each subject
cfg             = [];
cfg.continuous  = 'yes';
cfg.layout      = layout;
review=ft_databrowser(cfg, data);

cfg             = [];
cfg.channel     = {'all','-hEOG','-vEOG','-Trigger'};
data_noeog      = ft_preprocessing(cfg,data);

% EOG referencing
cfg              = [];
cfg.channel      = 'vEOG';
eogv             = ft_preprocessing(cfg, data);

cfg              = [];
cfg.channel      = {'vEOG'};
eogv             = ft_selectdata(cfg, eogv);
eogv.label       = {'vEOG'};
eogv.senstype    = 'EOG';

cfg              = [];
cfg.channel      = {'hEOG'};
eogh             = ft_preprocessing(cfg, data);

cfg              = [];
cfg.channel      = 'hEOG';
eogh             = ft_selectdata(cfg, eogh);
eogh.label       = {'hEOG'};
eogh.senstype    = 'EOG';

% Put eogs back in
data             = ft_appenddata([], data_noeog, eogv, eogh);

% Reapply trial definition to the data
cfg              = [];
cfg.trl          = defs.trl;
data             = ft_redefinetrial(cfg,data);

% Baseline-correction options
cfg              = [];
cfg.demean       = 'yes';
cfg.baselinewindow  = [-0.2 0];
data = ft_preprocessing(cfg, data);

% Perform re-referencing
% re-referencing to the average of the two mastoids
cfg             = [];
cfg.channel     = {'all','-eogh','-eogv'};
cfg.reref       = 'yes';
cfg.refchannel  = {'XXX' 'XXX'}; % electrodes used as the mastoid references
cfg.implicitref = 'XXX';
data      = ft_preprocessing(cfg,data);

%% Step 2. Trial Rejection

% Look at the data to determine if there are still artifacts
cfg             = [];
cfg.continuous  = 'no';
cfg.layout      = layout;
review=ft_databrowser(cfg, data);

% Manual trial and channel rejection using summary statistics
cfg             = [];
cfg.method      = 'summary';
cfg.channels    = 'EEG';
cfg.ylim        = 100;
temp_data       = ft_rejectvisual(cfg,data);

trials2remove   = setdiff(data.trialinfo(:,1),temp_data.trialinfo(:,1));
channels2remove = setdiff(data.label,temp_data.label);

% Remove channels, if any
if ~isempty(channels2remove)
    %find channel indices
    for i = 1:length(channels2remove)
        ind2remove(i) = find(strcmp(data.label,channels2remove{i}));
    end
    temp_labels             = data.label;
    temp_labels(ind2remove) = [];

    cfg                     = [];
    cfg.channel             = temp_labels;
    data                    = ft_selectdata(cfg,data);
end

% Remove trials, if any
data.trialinfo(trials2remove,:)     = [];
data.sampleinfo(trials2remove,:)    = [];
data.trial(:,trials2remove)         = [];
data.time(:,trials2remove)          = [];
data.rejected_trials                = trials2remove;
data.rejected_channels              = channels2remove;

% Show how much data remains
disp(' ')
disp('---Automatic Trial Rejection Applied---')
disp(['Rejected ' num2str(length(trials2remove)) ' trials'])
disp(['Rejected Trial #s ' num2str(trials2remove(:)')])
disp(['Remaining ' num2str(length(data.trial)) ' trials'])
disp(['Remaining ' num2str((length(data.trial)/(size(data.trialinfo,1)+numel(data.rejected_trials)))*100) '% trials'])
disp(' ')

%% Step 3: Perform ICA and ICA Component Rejection

tic
cfg_ica         = [];
cfg_ica.method  = 'runica';
cfg_ica.channel = {'all','XXX'}; % Including both references leads to several components consisting of mastoid signals. Using only one seems to avoid this issue.
data_ica        = rmfield(ft_componentanalysis(cfg_ica, data),'cfg');
disp(['ICA took ' num2str(toc) ' seconds to complete'])

% Selecting ICs to remove
cfg             = [];
cfg.continuous  = 'no';
cfg.viewmode    = 'component';
cfg.layout      = layout;
component_rej   = ft_databrowser(cfg, data_ica);

prompt          = {'Enter ICs that may need to be removed separated by a space'};
title           = 'ICs to Remove';
dims            = [1 50];
defaults        = {' '};
answer          = inputdlg(prompt,title,dims,defaults);
IC2remove       = str2num(answer{1,:}); % Gets ICs that need to be remove and ICs that require further inspection 

% Generate ERPimage for each component in question after locking to feedback onset
for IC = 1:numel(IC2remove)
    tmp_comp = [];
    for i = 1:length((data_ica.trial))
        tmp_comp = [tmp_comp;data_ica.trial{i}(IC2remove(IC),:)];
    end
    ERPimages{IC} = tmp_comp;
end

% Generate power spectrum for each IC being inspected
cfg              = [];
cfg.output       = 'pow';
cfg.channel      = IC2remove; %'all'; %compute the power spectrum in all ICs
cfg.method       = 'mtmfft';
cfg.taper        = 'hanning';
cfg.foi          = 0:1:45;
freq             = ft_freqanalysis(cfg, data_ica);

% Plot
for IC = 1: length(ERPimages)
    %plot ERPimage for each IC in question
    fig = figure('Position', [100 100 600 400],'Name',['IC #' num2str(IC2remove(IC))]);
    t = tiledlayout(2,1);
    t.TileSpacing = 'compact';
    t.Title.String = ['IC #' num2str(IC2remove(IC))];

    nexttile;
    plot([data_ica.trial{1}(IC2remove(IC),:), data_ica.trial{2}(IC2remove(IC),:),data_ica.trial{3}(IC2remove(IC),:)])
    xlabel('time [ms]');
    ylabel('Amp [\muV]')
    set(gca,'xticklabel',{[-0.5, 0, 0.5 1]});

    nexttile;
    imagesc(ERPimages{IC});
    colorbar;
    xticks([800,1000,1200,1400,1600])
    xticklabels({'','0','200','400','600'})
    ylabel('trial #');
    xlabel('time [ms] from onset');
    xline(1000,'--w','LineWidth',2)
    
    figure;
    cfg.channel = IC;
    ft_singleplotER(cfg,freq);
    plot(freq.freq,10*log10(freq.powspctrm(IC,:)))
    xlabel('Freq [Hz]');
    ylabel('Power 10*log10');
    xlim([1 45]);
    
    figure;
    cfg = [];
    cfg.component = IC2remove(IC); % specify the component(s) that should be removed
    cfg.layout    = layout;
    cfg.comment   = 'no';
    cfg.colorbar  = 'yes';
    ft_topoplotIC(cfg, data_ica);

    pause(1)
    %continue to next trial or break
    a = input('Should this IC be removed (y/n)? ','s');
    if strcmpi(a,'y')
         close all;
    else
        IC2remove(IC) = nan;
        close all;
    end
end

IC2remove       = IC2remove(~isnan(IC2remove));

% Remove the bad components and backproject the data
cfg             = [];
cfg.component   = IC2remove; % to be removed component(s)
clean_data      = ft_rejectcomponent(cfg, data_ica);
clean_data.rejected_ICs = IC2remove;

%% Step 4. Channel Rejection

% Look at the data to determine if there are still artifacts
cfg             = [];
cfg.continuous  = 'no';
cfg.layout      = layout;
review=ft_databrowser(cfg, clean_data);

% Manual trial and channel rejection using summary statistics
cfg             = [];
cfg.method      = 'summary';
cfg.channels    = 'EEG';
cfg.ylim        = 100;
clean_temp_data       = ft_rejectvisual(cfg,clean_data);

trials2remove   = setdiff(clean_data.trialinfo(:,1),clean_temp_data.trialinfo(:,1));
channels2remove = setdiff(clean_data.label,clean_temp_data.label);

% Remove channels, if any
if ~isempty(channels2remove)
    %find channel indices
    for i = 1:length(channels2remove)
        ind2remove(i) = find(strcmp(clean_data.label,channels2remove{i}));
    end
    temp_labels             = clean_data.label;
    temp_labels(ind2remove) = [];

    cfg                     = [];
    cfg.channel             = temp_labels;
    clean_data              = ft_selectdata(cfg,clean_data);
end

% Remove trials, if any
clean_data.trialinfo(trials2remove,:)     = [];
clean_data.sampleinfo(trials2remove,:)    = [];
clean_data.trial(:,trials2remove)         = [];
clean_data.time(:,trials2remove)          = [];
clean_data.rejected_trials                = trials2remove;
clean_data.rejected_channels              = channels2remove;

% Show how much data remains
disp(' ')
disp('---Automatic Trial Rejection Applied---')
disp(['Rejected ' num2str(length(trials2remove)) ' trials'])
disp(['Rejected Trial #s ' num2str(trials2remove(:)')])
disp(['Remaining ' num2str(length(clean_data.trial)) ' trials'])
disp(['Remaining ' num2str((length(clean_data.trial)/(size(clean_data.trialinfo,1)+numel(clean_data.rejected_trials)))*100) '% trials'])
disp(' ')

%% Step 5: Channel interpolation

% First Call the laplacian function on a copy of the data to
% extract the elecinfo. 
lap_data        = clean_data;
cfg             = [];
cfg.method      = 'spline';
cfg.layout      = layout;
cfg.trials      = 'all';
lap_data        = ft_scalpcurrentdensity(cfg,lap_data);
elecinfo        = lap_data.elec;
clear lap_data

% Interpolate removed electrodes
if ~isempty(channels2remove)
    disp(['interpolating over ' num2str(numel(channels2remove)) ' removed channels'])

    cfg_neighb          = [];
    cfg_neighb.feedback = 'no';
    cfg_neighb.method   = 'triangulation';
    cfg_neighb.layout   = layout;
    neighbours          = ft_prepare_neighbours(cfg_neighb);

    cfg=[];
    cfg.channel         = [clean_data.label];
    temp_data           = ft_selectdata(cfg, clean_data);
    temp_data.layout    = layout;
    temp_data.elec      = elecinfo;
    
    cfg = [];
    cfg.method          = 'average';
    cfg.layout          = layout;
    cfg.missingchannel  = channels2remove;
    cfg.neighbours      = neighbours;  
    cfg.senstype        = 'eeg';
    data      = ft_channelrepair(cfg,temp_data);    
end

cd('XXX'); % Path where you want the file saved
save("XXX","data");

