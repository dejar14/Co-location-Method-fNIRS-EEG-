%% Manuscript Plot
% Load Data
% Load Data
a=load('S3avg.mat');
b=load('S4avg.mat');
c=load('S5avg.mat');
d=load('S6avg.mat');
e=load('S7avg.mat');
g=load('S3Oldavg.mat');

% frequencies 
fload=load('f.mat');
f=fload.f; % to be used for plots?

S3f=load('S3f.mat').f;
S4f=load('S4f.mat').f;
S5f=load('S5f.mat').f;
S6f=load('S6f.mat').f;
S7f=load('S7f.mat').f;
S3Oldf=load('S3Oldf.mat').f;


% Name off and on
S3avgON=[a.af3On, a.af4On, a.af8On, a.afzOn, a.fp1On, a.S3NC_on];
S3avgOFF=[a.af3Off, a.af4Off, a.af8Off, a.afzOff, a.fp1Off, a.S3NC_off];

S4avgON=[b.af3On, b.af4On, b.af8On, b.afzOn, b.fp1On, b.S4NC_on];
S4avgOFF=[b.af3Off, b.af4Off, b.af8Off, b.afzOff, b.fp1Off, b.S4NC_off];

S5avgON=[c.af3On, c.af4On, c.af8On, c.afzOn, c.fp1On, c.S5NC_on];
S5avgOFF=[c.af3Off, c.af4Off, c.af8Off, c.afzOff, c.fp1Off, c.S5NC_off];

S6avgON=[d.af3On, d.af4On, d.af8On, d.afzOn, d.fp1On, d.S6NC_on];
S6avgOFF=[d.af3Off, d.af4Off, d.af8Off, d.afzOff, d.fp1Off, d.S6NC_off];

S7avgON=[e.af3On, e.af4On, e.af8On, e.afzOn, e.fp1On, e.S7NC_on];
S7avgOFF=[e.af3Off, e.af4Off, e.af8Off, e.afzOff, e.fp1Off, e.S7NC_off];

S3OldavgON=[g.S3OldC3_on, g.S3OldT7_on, g.S3OldNC_on];
S3OldavgOFF=[g.S3OldC3_off, g.S3OldT7_off, g.S3OldNC_off];

%% Crosstalk Present
% Plot average of c3 position with faded out trials after
bands=[16 18];

figure(62);
subplot(2,2,1); % S3Old On and Off
semilogy(S3Oldf,S3OldavgON(:,1),'r','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3Oldf,S3OldavgON(:,2),'b','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3Oldf,S3OldavgON(:,3),'g','LineWidth',1); % Solid red, thicker line
hold on

xp=[bands fliplr(bands)];
yp = ([[1;1]*10^0; [1;1]*max(ylim)]*ones(1,size(bands,1))).'; 

% Plot the bands with modified y-limits
for k = 1:size(bands,1)                                                             % Plot Bands
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end

xlim([0 25]);
ylim([1 10e6]);

xls = xlabel('Frequency (Hz)');
yls = ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize = 18;
yls.FontSize = 18;
ttl = title('Induced Crosstalk Present - Sources On');
ttl.FontSize = 20;

subplot(2,2,2); % S3Old On and Off
semilogy(S3Oldf,S3OldavgOFF(:,1),'r','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3Oldf,S3OldavgOFF(:,2),'b','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3Oldf,S3OldavgOFF(:,3),'g','LineWidth',1); % Solid blue, thicker line
hold on

xp=[bands fliplr(bands)];
yp = ([[1;1]*10^0; [1;1]*max(ylim)]*ones(1,size(bands,1))).'; 

% Plot the bands with modified y-limits
for k = 1:size(bands,1)                                                             % Plot Bands
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end

xlim([0 25]);
ylim([1 10e6]);

xls = xlabel('Frequency (Hz)');
yls = ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize = 18;
yls.FontSize = 18;
ttl = title('Induced Crosstalk Present - Sources Off');
ttl.FontSize = 20;

% Add a global legend
legendHandles = [
    plot(NaN, NaN, 'r', 'LineWidth', 3, 'LineStyle', '-'); ... % Dummy red line for C3
    plot(NaN, NaN, 'b', 'LineWidth', 3, 'LineStyle', '-');  ... % Dummy blue line for T7
    plot(NaN, NaN, 'k', 'LineWidth', 3, 'LineStyle', '-'); ... % Dummy red line for NC
    fill([NaN NaN NaN NaN], [NaN NaN NaN NaN], [1 1 1]*0.15, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
];

legend(legendHandles, {'C3','T7', 'NC', 'Crosstalk ROI'}, 'FontSize', 18, 'Location', 'south', 'Orientation', 'vertical');


%% Plot 5 Locations for 5 Subjects No Crosstalk Present
% Plot average of c3 position with faded out trials after
bands=[16 18];

subplot(2,2,3); % 5 subejcts
semilogy(S3f,S3avgON(:,1),'r','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3f,S3avgON(:,2),'b','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3f,S3avgON(:,3),'g','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3f,S3avgON(:,4),'m','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3f,S3avgON(:,5),'c','LineWidth',1); % Solid red, thicker line
hold on
semilogy(S3f,S3avgON(:,6),'k','LineWidth',1); % Solid red, thicker line
hold on

xp=[bands fliplr(bands)];
yp = ([[1;1]*10^0; [1;1]*max(ylim)]*ones(1,size(bands,1))).'; 

% Plot the bands with modified y-limits
for k = 1:size(bands,1)                                                             % Plot Bands
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end

xlim([0 25]);
ylim([1 10e6]);

xls = xlabel('Frequency (Hz)');
yls = ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize = 18;
yls.FontSize = 18;
ttl = title('No Crosstalk Present - Sources On');
ttl.FontSize = 20;

subplot(2,2,4); % 5 subejcts
semilogy(S3f,S3avgOFF(:,1),'r','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3f,S3avgOFF(:,2),'b','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3f,S3avgOFF(:,3),'g','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3f,S3avgOFF(:,4),'m','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3f,S3avgOFF(:,5),'c','LineWidth',1); % Solid blue, thicker line
hold on
semilogy(S3f,S3avgOFF(:,6),'k','LineWidth',1); % Solid blue, thicker line
hold on

xp=[bands fliplr(bands)];
yp = ([[1;1]*10^0; [1;1]*max(ylim)]*ones(1,size(bands,1))).'; 

% Plot the bands with modified y-limits
for k = 1:size(bands,1)                                                             % Plot Bands
    patch(xp(k,:), yp(k,:), [1 1 1]*0.15, 'FaceAlpha',0.2, 'EdgeColor','none')
end

xlim([0 25]);
ylim([1 10e6]);

xls = xlabel('Frequency (Hz)');
yls = ylabel('log Power Spectral Density (uV^2/Hz)');
xls.FontSize = 18;
yls.FontSize = 18;
ttl = title('No Crosstalk Present - Sources Off');
ttl.FontSize = 20;

% Add a global legend
legendHandles = [
    plot(NaN, NaN, 'r', 'LineWidth', 3, 'LineStyle', '-'); ... % Dummy red line for AF3
    plot(NaN, NaN, 'b', 'LineWidth', 3, 'LineStyle', '-');  ... % Dummy blue line for AF4
    plot(NaN, NaN, 'g', 'LineWidth', 3, 'LineStyle', '-'); ... % Dummy red line for AF8
    plot(NaN, NaN, 'm', 'LineWidth', 3, 'LineStyle', '-'); ... % Dummy red line for AFz
    plot(NaN, NaN, 'c', 'LineWidth', 3, 'LineStyle', '-');  ... % Dummy blue line for FP1
    plot(NaN, NaN, 'k', 'LineWidth', 3, 'LineStyle', '-'); ... % Dummy red line for NC
    fill([NaN NaN NaN NaN], [NaN NaN NaN NaN], [1 1 1]*0.15, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
];

legend(legendHandles, {'AF3', 'AF4', 'AF8', 'AFz', 'FP1', 'NC', 'Crosstalk ROI'}, 'FontSize', 18, 'Location', 'south', 'Orientation', 'vertical');

%% T-test for Sources On in No Crosstalk Present
% Load NC for Participants
S3NCall=load('S3noncolocated.mat').S3NC_on(248:278, :);
S4NCall=load('S4noncolocated.mat').S4NC_on(243:272, :);
S5NCall=load('S5noncolocated.mat').S5NC_on(249:278, :);
S6NCall=load('S6noncolocated.mat').S6NC_on(251:282, :);
S7NCall=load('S7noncolocated.mat').S7NC_on(242:272, :);



colocatedPositionValues = [max(findpeaks(max(S3avgON(248:278, :), [], 2))); 
                           max(findpeaks(max(S4avgON(243:272, :), [], 2))); 
                           max(findpeaks(max(S5avgON(249:278, :), [], 2))); 
                           max(findpeaks(max(S6avgON(251:282, :), [], 2))); 
                           max(findpeaks(max(S7avgON(242:272, :), [], 2)))];

nonColocatedPositionValues = [max(findpeaks(max(S3NCall(:, :), [], 2))); 
                              max(findpeaks(max(S4NCall(:, :), [], 2))); 
                              max(findpeaks(max(S5NCall(:, :), [], 2))); 
                              max(findpeaks(max(S6NCall(:, :), [], 2))); 
                              max(findpeaks(max(S7NCall(:, :), [], 2)))];


[h, p, ci, stats] = ttest2(colocatedPositionValues(:), nonColocatedPositionValues(:), 'Vartype', 'unequal');