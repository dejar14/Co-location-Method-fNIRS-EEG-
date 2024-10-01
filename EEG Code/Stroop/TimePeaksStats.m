%% Finding group level Peaks
% Objective: Find the group level peak values and conduct peak amplitude
% statistics (t-test)
% Author: De'Ja Rogers

%% Initialize Variables

time = [0.2860    0.5080; 0.4000    0.7620]; 
plotLatency={'P3a'; 'P3b'};
fcRegion={'fz', 'fcz' 'fc2', 'fc1', 'c1', 'c2', 'c3', 'c4'};
pRegion={'pz', 'p3', 'p4', 'cp1', 'cp2'};
afRegion={'af3', 'af4', 'aff1h', 'aff2h', 'afz'};
ftRegion={'fft7', 'fft8', 'ttp7h', 'ttp8h'};
ROIs={{'fcz'}, {'pz'}, fcRegion, pRegion, afRegion, ftRegion};

peakMaxEASY=[];
peakMaxHARD=[];
meanEasy=[];
meanHard=[];

for j=1:6
    if j==1
        cfg=[];
        cfg.latency=time(1, :);
        cfg.channel=ROIs{j};
        [timelockEASY(j,1)]=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
             SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);
         [timelockHARD(j,1)]=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
             SS025_hard, SS028_hard, SS029_hard, SS033_hard, SS034_hard);
            
         meanEasy(j,1)=mean(timelockEASY(j,1).avg);
         meanHard(j,1)=mean(timelockHARD(j,1).avg);

         peakMaxEASY(j,1)=max(findpeaks(timelockEASY(j,1).avg));
         peakMaxHARD(j,1)=max(findpeaks(timelockHARD(j,1).avg));
    elseif j==2
         cfg=[];
         cfg.latency=time(2, :);
         cfg.channel=ROIs{j};
         [timelockEASY(j,2)]=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
              SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);
          [timelockHARD(j,2)]=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
              SS025_hard, SS028_hard, SS029_hard, SS033_hard, SS034_hard);
            
          meanEasy(j,2)=mean(timelockEASY(j,2).avg);
          meanHard(j,2)=mean(timelockHARD(j,2).avg);

          peakMaxEASY(j,2)=max(findpeaks(timelockEASY(j,2).avg));
          peakMaxHARD(j,2)=max(findpeaks(timelockHARD(j,2).avg));
    elseif j==3
          cfg=[];
          cfg.latency=time(1, :);
          cfg.channel=ROIs{j};
          [timelockEASY(j,1)]=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
              SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);
          [timelockHARD(j,1)]=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
              SS025_hard, SS028_hard, SS029_hard, SS033_hard, SS034_hard);
            
          meanEasy(j,1)=mean(mean(timelockEASY(j,1).avg));
          meanHard(j,1)=mean(mean(timelockHARD(j,1).avg));

          peakMaxEASY(j,1)=max(findpeaks(mean(timelockEASY(j,1).avg)));
          peakMaxHARD(j,1)=max(findpeaks(mean(timelockHARD(j,1).avg)));
    elseif j==4 
          cfg=[];
          cfg.latency=time(2, :);
          cfg.channel=ROIs{j};
          [timelockEASY(j,2)]=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
              SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);
          [timelockHARD(j,2)]=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
              SS025_hard, SS028_hard, SS029_hard, SS033_hard, SS034_hard);
            
          meanEasy(j,2)=mean(mean(timelockEASY(j,2).avg));
          meanHard(j,2)=mean(mean(timelockHARD(j,2).avg));

          peakMaxEASY(j,2)=max(findpeaks(mean(timelockEASY(j,2).avg)));
          peakMaxHARD(j,2)=max(findpeaks(mean(timelockHARD(j,2).avg)));
    elseif j==5
          cfg=[];
          cfg.latency=time(1, :);
          cfg.channel=ROIs{j};
          [timelockEASY(j,1)]=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
              SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);
          [timelockHARD(j,1)]=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
              SS025_hard, SS028_hard, SS029_hard, SS033_hard, SS034_hard);
            
          meanEasy(j,1)=mean(mean(timelockEASY(j,1).avg));
          meanHard(j,1)=mean(mean(timelockHARD(j,1).avg));

          peakMaxEASY(j,1)=max(findpeaks(mean(timelockEASY(j,1).avg)));
          peakMaxHARD(j,1)=max(findpeaks(mean(timelockHARD(j,1).avg)));
      elseif j==6
          cfg=[];
          cfg.latency=time(2, :);
          cfg.channel=ROIs{j};
          [timelockEASY(j,2)]=ft_timelockgrandaverage(cfg, SS017_easy, SS018_easy, SS019_easy, SS022_easy, SS024_easy, ...
              SS025_easy, SS028_easy, SS029_easy, SS033_easy, SS034_easy);
          [timelockHARD(j,2)]=ft_timelockgrandaverage(cfg, SS017_hard, SS018_hard, SS019_hard, SS022_hard, SS024_hard, ...
              SS025_hard, SS028_hard, SS029_hard, SS033_hard, SS034_hard);
            
          meanEasy(j,2)=mean(mean(timelockEASY(j,2).avg));
          meanHard(j,2)=mean(mean(timelockHARD(j,2).avg));

          peakMaxEASY(j,2)=max(findpeaks(mean(timelockEASY(j,2).avg)));
          peakMaxHARD(j,2)=max(findpeaks(mean(timelockHARD(j,2).avg)));
    end
end

%% Find subject level peaks for stats

% Initialize variables
peakMaxEASY = NaN(6, 10);  % Preallocate arrays for 6 regions and 10 subjects
peakMaxHARD = NaN(6, 10);

for j = 1:6
    cfg = [];
    if j == 1 || j == 3 || j == 5
        cfg.latency = time(1, :);
    else
        cfg.latency = time(2, :);
    end
    cfg.channel = ROIs{j};

    for subj = 1:length(allsubjEasyM)
        % Extract the subject data
        timelockEASY = ft_timelockgrandaverage(cfg, allsubjEasyM{subj});  % Get the data for the current subject
        timelockHARD = ft_timelockgrandaverage(cfg, allsubjHardM{subj});  % Get the data for the current subject
        if j==3|| j==4|| j==5||j==6
            timelockEASY.avg=mean(timelockEASY.avg);
            timelockHARD.avg=mean(timelockHARD.avg);
        end

        % Extract the time indices within the specified latency window
        time_idx_EASY = timelockEASY.time >= cfg.latency(1) & timelockEASY.time <= cfg.latency(2);
        time_idx_HARD = timelockHARD.time >= cfg.latency(1) & timelockHARD.time <= cfg.latency(2);

        % Find the peaks within the specified latency window
        [peaksEasy, ~] = findpeaks(timelockEASY.avg(time_idx_EASY));
        [peaksHard, ~] = findpeaks(timelockHARD.avg(time_idx_HARD));

        % Filter out non-positive peaks (if needed)
        peaksEasy = peaksEasy(peaksEasy > 0);
        peaksHard = peaksHard(peaksHard > 0);

        % Store the maximum positive peak within the specified window
        if ~isempty(peaksEasy)
            peakMaxEASY(j, subj) = max(peaksEasy);
        else
            peakMaxEASY(j, subj) = NaN;
        end

        if ~isempty(peaksHard)
            peakMaxHARD(j, subj) = max(peaksHard);
        else
            peakMaxHARD(j, subj) = NaN;
        end
    end
end

%% T-test
h=[];
p=[];
ci=[];
stats=[];
for trials=1:6
    [h,p,ci,stats] = ttest(peakMaxEASY',peakMaxHARD','Alpha',0.05);
end