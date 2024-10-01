%% Check for crosstalk 
% Objective: Check EEG data for crosstalk from fNIRS sources at the subject
% level.
% Author: De'Ja Rogers

%% Define folder and file

folderName='XXX';
fileName='XXX';

%% load file routine
global BTB  %<--- needs to be done for the BV functions to work
BTB=[];
BTB.TypeChecking=0;

FILE=[folderName,filesep,fileName];

[CNT, MRK, HDR]= file_readBV(FILE);
names=CNT.clab';
layout='CustomLayout';

%% create time vector
Ts=1/CNT.fs;
t=linspace(0,1,CNT.T)*CNT.T*Ts;

%% create stim vector

s=zeros(2,length(t));
for ki=1:length(MRK.time)-1
    [~,position]=min(abs(t-MRK.time(ki+1)/1000));
    indice=find(MRK.y(:,ki+1)==1)-1;
    s(indice,position)=-3;
end

%% inspect data

% Plot
figure(50)
plot(t,CNT.x(:,4:5))
title(['Raw data from Subject ',fileName])
xlabel('Time [s]')
ylabel(['Voltage [',CNT.yUnit,']'])
legend(CNT.clab(:,4:5))

%% plot data with stims

 figure(48) % however many co-located positions you have
 plot(t,CNT.x(:,1),'r');
 hold on
 plot(t,CNT.x(:,2),'b');
 hold on
 plot(t,CNT.x(:, 3), 'g');
 hold on
 plot(t,CNT.x(:, 4), 'm');
 hold on
 plot(t,CNT.x(:, 5), 'c');
 hold on
 plot(t,s(1,:)*1e4,t,s(2,:)*1e4);

 title(['Raw data from Subject ',fileName]);
 xlabel('Time [s]');
 ylabel(['Voltage [',CNT.yUnit,']']);
 legend([CNT.clab(:,1:5), 'Sources Off','Sources On']);

 % Separate into conditions (Sources Off vs On)
sOFF=s(1,:)'; 
offpoints=find((sOFF)==-3);
sON=s(2,:)';
onpoints=find((sON)==-3);
diff=offpoints-onpoints;

%% spectral analysis of Sources On vs Off

% first set

figure(51); %plot
lmo=tiledlayout(3,2,'TileSpacing','Compact');
onCNT1=CNT.x(onpoints(1):onpoints(1)+diff(1)-10,1:5); %extract timeframe (on)
psa1=abs(fft(onCNT1));
f=CNT.fs*linspace(0,1,length(psa1));

nexttile
semilogy(f,psa1(:,1),'r');
hold on
semilogy(f,psa1(:,2),'b');
hold on
offCNT1=CNT.x(offpoints(1):offpoints(1)+diff(1)-10,1:5); %extract timeframe %extract timeframe (off)
psa11=abs(fft(offCNT1));
f=CNT.fs*linspace(0,1,length(psa11));
semilogy(f,psa11(:,1),'Color','r','LineStyle','--');
hold on
semilogy(f,psa11(:,2),'Color','b','LineStyle','--');
hold on
xlim([0 25]);
title('Trial 1');
hold off

%second set
onCNT2=CNT.x(onpoints(2):onpoints(2)+diff(2)-10,1:5);
psa2=abs(fft(onCNT2));
f=CNT.fs*linspace(0,1,length(psa2));

nexttile
semilogy(f,psa2(:,1),'r');
hold on
semilogy(f,psa2(:,2),'b');
hold on
offCNT2=CNT.x(offpoints(2):offpoints(2)+diff(2)-10,1:5);
psa12=abs(fft(offCNT2));
f=CNT.fs*linspace(0,1,length(psa12));
semilogy(f,psa12(:,1),'Color','r','LineStyle','--');
hold on
semilogy(f,psa12(:,2),'Color','b','LineStyle','--');
hold on
xlim([0 25]);
title('Trial 2');
hold off

%set 3
onCNT3=CNT.x(onpoints(3):onpoints(3)+diff(3)-10,1:5);
psa3=abs(fft(onCNT3));
f=CNT.fs*linspace(0,1,length(psa3));

nexttile
semilogy(f,psa3(:,1),'r');
hold on
semilogy(f,psa3(:,2),'b');
hold on
offCNT3=CNT.x(offpoints(3):offpoints(3)+diff(3)-10,1:5);
psa13=abs(fft(offCNT3));
f=CNT.fs*linspace(0,1,length(psa13));
semilogy(f,psa13(:,1),'Color','r','LineStyle','--');
hold on
semilogy(f,psa13(:,2),'Color','b','LineStyle','--');
hold on
xlim([0 25]);
title('Trial 3');
hold off

% set 4
onCNT4=CNT.x(onpoints(4):onpoints(4)+diff(4)-10,1:5);
psa4=abs(fft(onCNT4));
f=CNT.fs*linspace(0,1,length(psa4));

nexttile
semilogy(f,psa4(:,1),'r');
hold on
semilogy(f,psa4(:,2),'b');
hold on
offCNT4=CNT.x(offpoints(4):offpoints(4)+diff(4)-10,1:5);
psa14=abs(fft(offCNT4));
f=CNT.fs*linspace(0,1,length(psa14));
semilogy(f,psa14(:,1),'Color','r','LineStyle','--');
hold on
semilogy(f,psa14(:,2),'Color','b','LineStyle','--');
hold on
xlim([0 25]);
title('Trial 4');
hold off

%set 5
onCNT5=CNT.x(onpoints(5):onpoints(5)+diff(5)-10,1:5);
psa5=abs(fft(onCNT5));
f=CNT.fs*linspace(0,1,length(psa5));

nexttile
semilogy(f,psa5(:,1),'r');
hold on
semilogy(f,psa5(:,2),'b');
hold on
offCNT5=CNT.x(offpoints(5):offpoints(5)+diff(5)-10,1:5);
psa15=abs(fft(offCNT5));
f=CNT.fs*linspace(0,1,length(psa15));
semilogy(f,psa15(:,1),'Color','r','LineStyle','--');
hold on 
semilogy(f,psa15(:,2),'Color','b','LineStyle','--');
hold on 
xlim([0 25]);
title('Trial 5');
hold off

% set6
onCNT6=CNT.x(onpoints(6):onpoints(6)+diff(6)-10,1:5);
psa6=abs(fft(onCNT6));
f=CNT.fs*linspace(0,1,length(psa6));

nexttile
semilogy(f,psa6(:,1),'r');
hold on
semilogy(f,psa6(:,2),'b');
hold on
offCNT6=CNT.x(offpoints(6):offpoints(6)+diff(6)-10,1:5);
psa16=abs(fft(offCNT6));
f=CNT.fs*linspace(0,1,length(psa16));
semilogy(f,psa16(:,1),'Color','r','LineStyle','--');
hold on
semilogy(f,psa16(:,2),'Color','b','LineStyle','--');
hold on
xlim([0 25]);
title('Trial 6');
hold off

title(lmo,'Power Spectral Density Plots of Subject #3 By Trial')
xlabel(lmo,'Frequency (Hz)')
ylabel(lmo,'log Power Spectral Density (uV^2/Hz)')
legend('af8 - Sources On', 'af8 - Sources On', 'af4 - Sources Off', 'af4 - Sources Off', 'afz - Sources On', 'afz - Sources On', 'fp1 - Sources Off', 'fp1 - Sources Off','af3 - Sources On', 'af3 - Sources On');

%% Averages 

%average the spectrograms ON
Z1 = nan(7551,6); % af8 location, on only, all trials
Z1(1:7441,1) = psa1(:,1);
Z1(1:7111,2) = psa2(:,1);
Z1(1:7480,3) = psa3(:,1);
Z1(1:7501,4) = psa4(:,1);
Z1(1:7551,5) = psa5(:,1);
Z1(1:7511,6) = psa6(:,1);
Z1=Z1';
psa_all_trials1=nanmean(Z1(:,:));
af8On=psa_all_trials1';

Z2 = nan(7551,6); % af4
Z2(1:7441,1) = psa1(:,2);
Z2(1:7111,2) = psa2(:,2);
Z2(1:7480,3) = psa3(:,2);
Z2(1:7501,4) = psa4(:,2);
Z2(1:7551,5) = psa5(:,2);
Z2(1:7511,6) = psa6(:,2);
Z2=Z2';
psa_all_trials2=nanmean(Z2(:,:));
af4On=psa_all_trials2';

Z3 = nan(7551,6); % afz
Z3(1:7441,1) = psa1(:,3);
Z3(1:7111,2) = psa2(:,3);
Z3(1:7480,3) = psa3(:,3);
Z3(1:7501,4) = psa4(:,3);
Z3(1:7551,5) = psa5(:,3);
Z3(1:7511,6) = psa6(:,3);
Z3=Z3';
pas_all_trials3=nanmean(Z3(:,:));
afzOn=pas_all_trials3';

Z4 = nan(7551,6); % fp1
Z4(1:7441,1) = psa1(:,4);
Z4(1:7111,2) = psa2(:,4);
Z4(1:7480,3) = psa3(:,4);
Z4(1:7501,4) = psa4(:,4);
Z4(1:7551,5) = psa5(:,4);
Z4(1:7511,6) = psa6(:,4);
Z4=Z4';
psa_all_trials4=nanmean(Z4(:,:));
fp1On=psa_all_trials4';

Z5 = nan(7551,6); % af3
Z5(1:7441,1) = psa1(:,5);
Z5(1:7111,2) = psa2(:,5);
Z5(1:7480,3) = psa3(:,5);
Z5(1:7501,4) = psa4(:,5);
Z5(1:7551,5) = psa5(:,5);
Z5(1:7511,6) = psa6(:,5);
Z5=Z5';
psa_all_trials5=nanmean(Z5(:,:));
af3On=psa_all_trials5';

%average the spectrograms OFF

Z6 = nan(7551,6); % af8
Z6(1:7441,1) = psa11(:,1);
Z6(1:7111,2) = psa12(:,1);
Z6(1:7480,3) = psa13(:,1);
Z6(1:7501,4) = psa14(:,1);
Z6(1:7551,5) = psa15(:,1);
Z6(1:7511,6) = psa16(:,1);
Z6=Z6';
psa_all_trials6=nanmean(Z6(:,:));
af8Off=psa_all_trials6';

Z7 = nan(7551,6); % af4
Z7(1:7441,1) = psa11(:,2);
Z7(1:7111,2) = psa12(:,2);
Z7(1:7480,3) = psa13(:,2);
Z7(1:7501,4) = psa14(:,2);
Z7(1:7551,5) = psa15(:,2);
Z7(1:7511,6) = psa16(:,2);
Z7=Z7';
psa_all_trials7=nanmean(Z7(:,:));
af4Off=psa_all_trials7';

Z8 = nan(7551,6); % afz
Z8(1:7441,1) = psa11(:,3);
Z8(1:7111,2) = psa12(:,3);
Z8(1:7480,3) = psa13(:,3);
Z8(1:7501,4) = psa14(:,3);
Z8(1:7551,5) = psa15(:,3);
Z8(1:7511,6) = psa16(:,3);
Z8=Z8';
psa_all_trials8=nanmean(Z8(:,:));
afzOff=psa_all_trials8';

Z9 = nan(7551,6); % fp1
Z9(1:7441,1) = psa11(:,4);
Z9(1:7111,2) = psa12(:,4);
Z9(1:7480,3) = psa13(:,4);
Z9(1:7501,4) = psa14(:,4);
Z9(1:7551,5) = psa15(:,4);
Z9(1:7511,6) = psa16(:,4);
Z9=Z9';
psa_all_trials9=nanmean(Z9(:,:));
fp1Off=psa_all_trials9';

Z10 = nan(7551,6); % af3
Z10(1:7441,1) = psa11(:,5);
Z10(1:7111,2) = psa12(:,5);
Z10(1:7480,3) = psa13(:,5);
Z10(1:7501,4) = psa14(:,5);
Z10(1:7551,5) = psa15(:,5);
Z10(1:7511,6) = psa16(:,5);
Z10=Z10';
psa_all_trials10=nanmean(Z10(:,:));
af3Off=psa_all_trials10';

%% Take AVG

% Store matrices in a cell array
matrices = {psa1, psa2, psa3, psa4, psa5, psa6};

% Find the maximum number of rows
maxRows = max(cellfun(@(x) size(x, 1), matrices));

% Pad matrices and store in a new array
paddedMatrices = NaN(maxRows, 5, numel(matrices)); % Assuming 4 columns

for i = 1:numel(matrices)
    rows = size(matrices{i}, 1);
    paddedMatrices(1:rows, :, i) = matrices{i};
end

% Calculate the average, ignoring NaNs
meanFon = nanmean(paddedMatrices, 3);
bands=[16 18];

% Store matrices in a cell array
matrices = {psa11, psa12, psa13, psa14, psa15, psa16};

% Find the maximum number of rows
maxRows = max(cellfun(@(x) size(x, 1), matrices));

% Pad matrices and store in a new array
paddedMatrices = NaN(maxRows, 5, numel(matrices)); % Assuming 4 columns

for i = 1:numel(matrices)
    rows = size(matrices{i}, 1);
    paddedMatrices(1:rows, :, i) = matrices{i};
end

% Calculate the average, ignoring NaNs
meanFoff = nanmean(paddedMatrices, 3);
bands=[16 18];

SubXavgON=(zz1+zz2+zz3+zz4+zz5)/5;
SubXavgOFF=(zz6+zz7+zz8+zz9+zz10)/5;

figure(61)
f=CNT.fs*linspace(0,1,length(meanFon));
semilogy(f,SubXavgON(:,1), 'r');
xlim([0 25]);
hold on
f=CNT.fs*linspace(0,1,length(meanFoff));
semilogy(f,SubXavgOFF(:,1), 'b');
xls=xlabel('Frequency (Hz)');
yls=ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize=14;
yls.FontSize=14;
ttl=title('AVG Source Sources On vs Off');
ttl.FontSize=14;
lgd=legend('Sources On', 'Sources Off', 'Crosstalk ROI');
lgd.FontSize=14;
hold off

save('SubXavg.mat','SubXavgOFF','SubXavgON', 'meanFon', 'meanFoff', 'af8On', 'af4On', 'afzOn', 'fp1On', 'af3On', 'af8Off', 'af4Off', 'afzOff', 'fp1Off', 'af3Off')

%% Find Peaks All Positions Averaged

% AF8
f=CNT.fs*linspace(0,1,length(af8On(:,1)));
maxPeakOn1=max(findpeaks(af8On(243:273,1))); % Aprrox 16-18Hz
frequencyOn1=f(af8On(:,1)==maxPeakOn1);

f=CNT.fs*linspace(0,1,length(af8Off(:,1)));
maxPeakOff1=max(findpeaks(af8Off(243:273,1))); % Aprrox 16-18Hz
frequencyOff1=f(af8Off(:,1)==maxPeakOff1);

% AF4
f=CNT.fs*linspace(0,1,length(af4On(:,1)));
maxPeakOn2=max(findpeaks(af4On(243:273,1))); % Aprrox 16-18Hz
frequencyOn2=f(af4On(:,1)==maxPeakOn2);

f=CNT.fs*linspace(0,1,length(af4Off(:,1)));
maxPeakOff2=max(findpeaks(af4Off(243:273,1))); % Aprrox 16-18Hz
frequencyOff2=f(af4Off(:,1)==maxPeakOff2);

% AFz
f=CNT.fs*linspace(0,1,length(afzOn(:,1)));
maxPeakOn3=max(findpeaks(afzOn(243:273,1))); % Aprrox 16-18Hz
frequencyOn3=f(afzOn(:,1)==maxPeakOn3);

f=CNT.fs*linspace(0,1,length(afzOff(:,1)));
maxPeakOff3=max(findpeaks(afzOff(243:273,1))); % Aprrox 16-18Hz
frequencyOff3=f(afzOff(:,1)==maxPeakOff3);

% FP1
f=CNT.fs*linspace(0,1,length(fp1On(:,1)));
maxPeakOn4=max(findpeaks(fp1On(243:273,1))); % Aprrox 16-18Hz
frequencyOn4=f(fp1On(:,1)==maxPeakOn4);

f=CNT.fs*linspace(0,1,length(fp1Off(:,1)));
maxPeakOff4=max(findpeaks(fp1Off(243:273,1))); % Aprrox 16-18Hz
frequencyOff4=f(fp1Off(:,1)==maxPeakOff4);

% AF3
f=CNT.fs*linspace(0,1,length(af3On(:,1)));
maxPeakOn5=max(findpeaks(af3On(243:273,1))); % Aprrox 16-18Hz
frequencyOn5=f(af3On(:,1)==maxPeakOn5);

f=CNT.fs*linspace(0,1,length(af3Off(:,1)));
maxPeakOff5=max(findpeaks(af3Off(243:273,1))); % Aprrox 16-18Hz
frequencyOff5=f(af3Off(:,1)==maxPeakOff5);

