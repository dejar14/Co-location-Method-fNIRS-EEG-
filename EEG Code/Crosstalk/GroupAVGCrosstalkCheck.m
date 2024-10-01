%% Average Crosstalk Check
% Objective: Compare new subject's crosstalk results with old crosstalk
% present result.
% Author: De'Ja Rogers

% Load Data
a=load('SubXavg.mat');
b=load('SubXavg.mat');
c=load('SubXavg.mat');
d=load('SubXavg.mat');
e=load('SubXavg.mat');
fload=load('f.mat');
g=load('SubXOldavg.mat');

% Name off and on
f=fload.f;

SubXavgON=a.SubXavgON;
SubXavgOFF=a.SubXavgOFF;

SubXavgON=b.SubXavgON;
SubXavgOFF=b.SubXavgOFF;

SubXavgON=c.SubXavgON;
SubXavgOFF=c.SubXavgOFF;

SubXavgON=d.SubXavgON;
SubXavgOFF=d.SubXavgOFF;

SubXavgON=e.SubXavgON;
SubXavgOFF=e.SubXavgOFF;

SubXOldavgON=g.SubXOldavgON;
SubXOldavgOFF=g.SubXOldavgOFF;


% average the spectrograms ON
Z1 = nan(7811,5); 
Z1(1:7711,1) = SubXavgON;
Z1(1:7551,2) = SubXavgON;
Z1(1:7721,3) = SubXavgON;
Z1(1:7811,4) = SubXavgON;
Z1(1:7530,5) = SubXavgON;
Z1=Z1';
all_on=nanmean(Z1(:,:));

%average the spectrograms OFF

Z10 = nan(7811,5);
Z10(1:7711,1) = SubXavgOFF;
Z10(1:7551,2) = SubXavgOFF;
Z10(1:7721,3) = SubXavgOFF;
Z10(1:7811,4) = SubXavgOFF;
Z10(1:7530,5) = SubXavgOFF;
Z10=Z10';
all_off=nanmean(Z10(:,:));

%% Plot Results

bands=[16 18];

% Plot
figure(64)
subplot(1,2,1);
semilogy(SubXOldF,g.SubXOldavgON, 'r');
xlim([0 25]);
ylim([1 10e8]);
hold on
semilogy(SubXOldF,g.SubXOldavgOFF, 'b');
hold off
ttl=title('Induced Crosstalk Present');
xls=xlabel('Frequency (Hz)');
yls=ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize=14;
yls.FontSize=14;
ttl.FontSize=14;

hold on
xp=[bands fliplr(bands)];
yp = ([[1;1]*min(ylim); [1;1]*max(ylim)]*ones(1,size(bands,1))).'; 
for k = 1:size(bands,1)                                                             % Plot Bands
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end
lgd=legend('Sources On', 'Sources Off', 'Crosstalk ROI');
lgd.FontSize=14;
hold off

subplot(1,2,2);
semilogy(S6F,all_on, 'r');
xlim([0 25]);
ylim([1 10e8]);
hold on
semilogy(S6F,all_off, 'b');
ttl=title('No Crosstalk Present');
xls=xlabel('Frequency (Hz)');
yls=ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize=14;
yls.FontSize=14;
ttl.FontSize=14;
hold on
xp=[bands fliplr(bands)];
yp = ([[1;1]*min(ylim); [1;1]*max(ylim)]*ones(1,size(bands,1))).'; 
for k = 1:size(bands,1)                                                             % Plot Bands
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end
lgd=legend('Sources On', 'Sources Off', 'Crosstalk ROI');
lgd.FontSize=14;
hold off

% find peaks
% TIMEFRAME=SubXF(267:283), SubXOldF(178:188)

maxPeakNoCrosstalkOn=max(findpeaks(all_on(267:283)));
frequencyOnNC=S6F(all_on==maxPeakNoCrosstalkOn);
maxPeakNoCrosstalkOff=max(findpeaks(zz10(267:283)));
frequencyOffNC=S6F(zz10==maxPeakNoCrosstalkOff);

maxPeakCrosstalkOn=max(findpeaks(g.S3OldavgON(178:188)));
frequencyOnC=S3OldF(g.S3OldavgON==maxPeakCrosstalkOn);
maxPeakCrosstalkOff=max(findpeaks(g.S3OldavgOFF(178:188)));
frequencyOffC=S3OldF(g.S3OldavgOFF==maxPeakCrosstalkOff);

crosscheckValueleftOn=g.SubXOldavgON(182);
crosscheckValueleftOff=g.SubXOldavgOFF(182);
crosscheckValuerightOn=all_on(273);
crosscheckValuerightOff=all_off(273);
