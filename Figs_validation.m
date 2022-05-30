%--------------------------------
% Code to reproduce figures 2-4 
%--------------------------------

%% Figure 2
% Male-to-female relative abundance of mRNAs for controls and shifters, 
% normalized by control male-to-female ratios.
% Data was obtained using EngaugeDigitizer on Hadden et al. 2012 article's plots
y = [1 1.31; 
   1 0.552; 
   1 0.724; 
   1 6.50]; % data from excel file, normalized by control male-to-female ratios.
clr = [0 0 1;
   0.929 0.694 0.125];
colormap(clr);

b = bar(y,'FaceColor','flat');
set(gca,'FontSize',16,'XTickLabel',{'Bmal1','Per2','Cry2','Rev-Erb\alpha'})
for k = 1:size(y,2)
    b(k).CData = k;
end
legend('Control male-to-female ratio','CJL male-to-female ratio','location','northwest')

%% Figure 3
% Predicted clock gene time profiles
% ------------------------------------
% import clock genes data
% ------------------------------------
    filename = 'lung_sorted.xlsx';
    delimiterIn = ' ';
    headerlinesIn = 1;
    raw = importdata(filename,delimiterIn,headerlinesIn);

% extract numeric entries
    num = raw.data; 

    % only keep data (remove time column)
    % skip first row of headers
    normNum = num(:,2:end)/200; %rescaling

    % experimental data starts at time 18 until time 64 and so this will be our benchmark
    % that's a total of 46h for the purpose of simulations
    expTime = 0:2:46;

    % lung data has 7 columns: 1)time, 2) Arntl (Bmal1), 3)Per2
    % 4)Cry1, 5)Cry2, 6)nr1d1(rev-erb alpha), 7)rorc
    % we won't need cry2, i.e., column 4 in "normNum"
    lung = normNum(:,[1,2,3,5,6]);
    Bmal1 = lung(:,1);
    Per = lung(:,2);
    Cry = lung(:,3);
    Rev = lung(:,4);
    Ror = lung(:,5);
%-------------------------------------------------------------------------- 
% plotting
%-------------------------------------------------------------------------- 
[T,Y] = callclock(); 
sz = 100;
RGB=[0.6350, 0.0780, 0.1840];

figure(3)
tiledlayout(3,2)

% Tile 1
nexttile
plot(T,Y(:,1),'-k','linewidth',4)  % model 
ylim([0 5])
hold on
scatter(expTime, Per, sz,'filled','MarkerFaceColor',RGB)  % data
patch([0 6 6 0], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([6 18 18 6], [max(ylim) max(ylim) 0 0], 'w')
patch([18 30 30 18], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([30 42 42 30], [max(ylim) max(ylim) 0 0], 'w') 
patch([42 48 48 42], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
set(gca,'children',flipud(get(gca,'children')))
hold off
ylabel('Per2 mRNA')
xlabel('Circadian Time (h)')
xlim([0 48])
xticks(0:6:48)
xticklabels({'18','24','6','12','18','24','6','12','18'})
% legend('Predicted', 'Experimental','Orientation','vertical','Location','northoutside')


% Tile 2
nexttile
plot(T,Y(:,2),'-k','linewidth',4) % model 
ylim([0 2])
hold on
scatter(expTime,Cry, sz,'filled','MarkerFaceColor',RGB) % data  
patch([0 6 6 0], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([6 18 18 6], [max(ylim) max(ylim) 0 0], 'w')
patch([18 30 30 18], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([30 42 42 30], [max(ylim) max(ylim) 0 0], 'w') 
patch([42 48 48 42], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)  
set(gca,'children',flipud(get(gca,'children')))
hold off
ylabel('Cry1 mRNA')
xlabel('Circadian Time (h)')
xlim([0 48])
xticks(0:6:48)
xticklabels({'18','24','6','12','18','24','6','12','18'})
% legend('Predicted', 'Experimental')

% Tile 3
nexttile
plot(T,Y(:,3),'-k','linewidth',4) % model 
ylim([0 15])
hold on
scatter(expTime,Rev, sz,'filled','MarkerFaceColor',RGB) % data 
patch([0 6 6 0], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([6 18 18 6], [max(ylim) max(ylim) 0 0], 'w')
patch([18 30 30 18], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([30 42 42 30], [max(ylim) max(ylim) 0 0], 'w') 
patch([42 48 48 42], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)  
set(gca,'children',flipud(get(gca,'children')))
hold off
ylabel('Rev-Erb{\alpha} mRNA')
xlabel('Circadian Time (h)')
xlim([0 48])
xticks(0:6:48)
xticklabels({'18','24','6','12','18','24','6','12','18'})

% Tile 4
nexttile
plot(T,Y(:,4),'-k','linewidth',4) % model 
ylim([0 4.5])
hold on
scatter(expTime,Ror, sz,'filled','MarkerFaceColor',RGB) % data   
patch([0 6 6 0], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([6 18 18 6], [max(ylim) max(ylim) 0 0], 'w')
patch([18 30 30 18], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([30 42 42 30], [max(ylim) max(ylim) 0 0], 'w') 
patch([42 48 48 42], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)  
set(gca,'children',flipud(get(gca,'children')))
hold off
ylabel('Rorc mRNA')
xlabel('Circadian Time (h)')
xlim([0 48])
xticks(0:6:48)
xticklabels({'18','24','6','12','18','24','6','12','18'})
% legend('Predicted', 'Experimental')

% Tile 5
nexttile
plot(T,Y(:,5),'-k','linewidth',4) % model 
ylim([0 2.5])
hold on
scatter(expTime,Bmal1, sz,'filled','MarkerFaceColor',RGB) % data   
patch([0 6 6 0], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([6 18 18 6], [max(ylim) max(ylim) 0 0], 'w')
patch([18 30 30 18], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)
patch([30 42 42 30], [max(ylim) max(ylim) 0 0], 'w') 
patch([42 48 48 42], [max(ylim) max(ylim) 0 0], [0 0 0]+0.9)  
set(gca,'children',flipud(get(gca,'children')))
hold off
ylabel('Bmal1 mRNA')
xlabel('Circadian Time (h)')
xlim([0 48])
xticks(0:6:48)
xticklabels({'18','24','6','12','18','24','6','12','18'})
% legend('Predicted', 'Experimental')

%% Figure 4
% Predicted cytokine time profiles
%--------------------------------------------------------------------------
% import cytokine data 
% obtained from: Roy et al. 2007
% Data was obtained using EngaugeDigitizer 
%--------------------------------------------------------------------------
% Experimental cytokine data at t=0,1,2,4,8,12,24h
expTime2 = [0,1,2,4,8,12,24];
% each data set has 3 columns: 
    % 1)results after 3mg/kg  endotoxin administration,
    % 2)results after 6mg/kg  endotoxin administration,
    % 3)results after 12mg/kg  endotoxin administration,
filename = 'tIL6.xlsx';
IL6 = readmatrix(filename,'Sheet','IL6','NumHeaderLines',1);
errIL6 = readmatrix(filename,'Sheet','err','NumHeaderLines',1);

filename = 'tTNF.xlsx';
TNF = readmatrix(filename,'Sheet','TNF','NumHeaderLines',1);
errTNF = readmatrix(filename,'Sheet','err','NumHeaderLines',1);

filename = 'tIL10.xlsx';
IL10 = readmatrix(filename,'Sheet','IL10','NumHeaderLines',1);
errIL10 = readmatrix(filename,'Sheet','err','NumHeaderLines',1);

%--------------------------------------------------------------------------
% plot cytokine data
%--------------------------------------------------------------------------
figure(4)
tiledlayout(3,3,'TileSpacing','Compact','TileIndexing','columnmajor')

% Endotoxin dose: 3mg/kg
[T,Y] = callclock2(2);  
sz = 8;
RGB=[0.6350, 0.0780, 0.1840];

% Tile 1
% IL6
nexttile
errorbar(expTime2,IL6(:,1),errIL6(:,1),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,16),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('IL6 (pg/mL)')
title('Endotoxin dose: 3mg/kg')
legend('Experimental','Predicted')

% Tile 2
% TNF
nexttile
errorbar(expTime2,TNF(:,1),errTNF(:,1),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,17),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('TNF (pg/mL)')

% Tile 3
% IL10
nexttile
errorbar(expTime2,IL10(:,1),errIL10(:,1),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,18),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('IL10 (pg/mL)')

% Endotoxin dose: 12mg/kg 
[T,Y] = callclock2(4);

% Tile 4
% IL6
nexttile
errorbar(expTime2,IL6(:,3),errIL6(:,3),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,16),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('IL6 (pg/mL)')
title('Endotoxin dose: 12mg/kg')
legend('Experimental','Predicted')

% Tile 5
% TNF
nexttile
errorbar(expTime2,TNF(:,3),errTNF(:,3),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,17),'-k','linewidth',2.5)
hold off
xlabel('Time (hour)')
ylabel('TNF (pg/mL)')

% Tile 6
% IL10
nexttile
errorbar(expTime2,IL10(:,3),errIL10(:,3),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,18),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('IL10 (pg/mL)')

% Endotoxin dose: 6mg/kg; used for model validation
[T,Y] = callclock2(3);

% Tile 7
% IL6
nexttile
errorbar(expTime2,IL6(:,2),errIL6(:,2),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,16),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('IL6 (pg/mL)')
title('Endotoxin dose: 6mg/kg')
legend('Experimental','Predicted')

% Tile 8
% TNF
nexttile
errorbar(expTime2,TNF(:,2),errTNF(:,2),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,17),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('TNF (pg/mL)')

% Tile 9
% IL10
nexttile
errorbar(expTime2,IL10(:,2),errIL10(:,2),'o','MarkerSize',sz,...
    'Color',RGB,'MarkerEdgeColor',RGB,'MarkerFaceColor',RGB,'linewidth',1)
hold on
plot(T,Y(:,18),'-k','linewidth',2.5)
hold off
xlabel('Time (h)')
ylabel('IL10 (pg/mL)')


%% Associated function calls
%-------------------------------------------------------------------------
function [T,Y] = callclock()

tSpan = 0:0.1:48;

% ICs in accordance with experimental data
% these correspond to CT18 per Circa DB
y1_0  = 2.7545;
y2_0  = 1.4965;
y3_0  = 0.9735;
y4_0  = 3.7375;
y5_0  = 1.2370;
y6_0  = 14.0789;
y7_0  = 0.5432;
y8_0  = 0.0058;
y9_0  = 0.4745;
y10_0 = 3.3198;
y11_0 = 2.3274; 
y12_0 = 0.1120;
y13_0 = 0; 
y14_0 = 0;
y15_0 = 0;
y16_0 = 0;
y17_0 = 0;
y18_0 = 10.83; % IL10 is not 0 at t=0. This value is the same as the reference value for the trial with endotoxin dose: 3mg/kg; 
y19_0 = 0;
y20_0 = 0.1259; 

lps0=0; % No infection
y0= [y1_0 y2_0 y3_0 y4_0 y5_0 y6_0 y7_0 y8_0 y9_0 y10_0 y11_0 y12_0 y13_0 y14_0 y15_0 y16_0 y17_0 y18_0 y19_0 y20_0];
[T,Y] = ode45(@(t,y)mainMod(t,y,lps0),tSpan,y0); 
end

%-------------------------------------------------------------------------
function [T,Y] = callclock2(j)

tSpan = 0:0.1:25;

% % ICs choosen at CT12 (reference trough for Bmal1)
y1_0  = 4.0285;
y2_0  = 1.1971;
y3_0  = 11.3187;
y4_0  = 2.6364;
y5_0  = 0.3088;
y6_0  = 10.8421;
y7_0  = 0.3780;
y8_0  = 0.0173;
y9_0  = 0.4033;
y10_0 = 3.1959;
y11_0 = 1.0554; 
y12_0 = 0.1793;
y13_0 = [0,3,6,12]; 
y14_0 = 0;
y15_0 = 0;
y16_0 = 0;
y17_0 = 0;
y18_0 = [10,83 10.83, 10.94, 13.97]; % Based on the data, IL10 is not 0 at t=0
y19_0 = 0;
y20_0 = 0.1259; 

lps0=y13_0(j);
y0= [y1_0 y2_0 y3_0 y4_0 y5_0 y6_0 y7_0 y8_0 y9_0 y10_0 y11_0 y12_0 y13_0(j) y14_0 y15_0 y16_0 y17_0 y18_0(j) y19_0 y20_0];
[T,Y] = ode45(@(t,y)mainMod(t,y,lps0),tSpan,y0); 
end
