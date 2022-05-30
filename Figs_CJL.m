%--------------------------------
% Code to reproduce figures 5,6,8 and 9
%--------------------------------
%% Figure 5
% Inflammatory response after infection at CT0 and CT12. 

[T0,Y0] = contfun(2,1,25); % CT0 + Endotoxin dose = 3mg/kg
[T12,Y12] = contfun(2,5,25); % CT12 + Endotoxin dose = 3mg/kg
figure(5)
tiledlayout(2,2)

% Tile 1
nexttile
plot(T0,Y0(:,16),'linewidth',2)
hold on
plot(T12,Y12(:,16),'linewidth',2)
hold off
xlabel('Time (h)')
ylabel('IL6 (pg/mL)')
legend('CT0','CT12')

% Tile 2
nexttile
plot(T0,Y0(:,17),'linewidth',2)
hold on
plot(T12,Y12(:,17),'linewidth',2)
hold off
xlabel('Time (h)')
ylabel('TNF\alpha (pg/mL)')
legend('CT0','CT12')

% Tile 3
nexttile
plot(T0,Y0(:,18),'linewidth',2)
hold on
plot(T12,Y12(:,18),'linewidth',2)
hold off
xlabel('Time (h)')
ylabel('IL10 (pg/mL)')
legend('CT0','CT12')

% Tile 4
nexttile
plot(T0,Y0(:,15),'linewidth',2)
hold on
plot(T12,Y12(:,15),'linewidth',2)
hold off
xlabel('Time (h)')
ylabel('Damage (pg/mL)')
legend('CT0','CT12')

%% Figure 6
% Phase relations between CRY, REV-ERB and ROR proteins 
[T0,Y0] = contfun(1,1,48); % Start time is CT0; no LPS
figure(6)
plot(T0,Y0(:,7)/mean(Y0(:,7)),'LineWidth',2,'color','blue')
hold on
plot(T0,Y0(:,8)/mean(Y0(:,8)),'LineWidth',2,'color','magenta')
plot(T0,Y0(:,9)/mean(Y0(:,9)),'LineWidth',2,'color','green')
xline([12,24,36],'LineStyle','--','LineWidth',1)
hold off
ylim([0.2 2])
xlim([0 48])
xticks(0:6:48)
xticklabels({'0','6','12','18','0','6','12','18','0'})
xlabel('Circadian time (h)')
legend('CRY','REV-ERB','ROR','Location','northoutside','Orientation','horizontal')

%% Figure 8
% Sex-specific response to infection during CJL at CT0 and CT12. 
% CONTROL
[T0,Y0] = contfun(2,1,25); % CT0 + Endotoxin dose = 3mg/kg
[T12,Y12] = contfun(2,5,25); % CT12 + Endotoxin dose = 3mg/kg
% FEMALE
[Tf0,Yf0] = femfun(2,1,25); % CT0 + Endotoxin dose = 3mg/kg
[Tf12,Yf12] = femfun(2,5,25); % CT12 + Endotoxin dose = 3mg/kg
% MALE
[Tm0,Ym0] = malefun(2,1,25); % CT0 + Endotoxin dose = 3mg/kg
[Tm12,Ym12] = malefun(2,5,25); % CT12 + Endotoxin dose = 3mg/kg

figure(8)
f8=tiledlayout(2,2);
drkgrey=[0.1490 0.1490 0.1490];
pink = [0.7020 0.0784 0.6588];
blue = [0.3294 0.4039 0.9098];

% Tile 1
nexttile
plot(T0,Y0(:,15),'linewidth',2,'color',drkgrey,'LineStyle','--')
hold on
plot(Tf0,Yf0(:,15),'linewidth',2,'color',pink,'LineStyle','--')
plot(Tm0,Ym0(:,15),'linewidth',2,'color',blue,'LineStyle','--')
plot(T12,Y12(:,15),'linewidth',2,'color',drkgrey,'LineStyle','-')
plot(Tm12,Ym12(:,15),'linewidth',2,'color',blue,'LineStyle','-')
plot(Tf12,Yf12(:,15),'linewidth',2,'color',pink,'LineStyle','-')
hold off
xlabel('Time (h)')
ylabel('Damage (pg/mL)')

% Tile 2
nexttile
plot(T0,Y0(:,16),'linewidth',2,'color',drkgrey,'LineStyle','--')
hold on
plot(Tf0,Yf0(:,16),'linewidth',2,'color',pink,'LineStyle','--')
plot(Tm0,Ym0(:,16),'linewidth',2,'color',blue,'LineStyle','--')
plot(T12,Y12(:,16),'linewidth',2,'color',drkgrey,'LineStyle','-')
plot(Tm12,Ym12(:,16),'linewidth',2,'color',blue,'LineStyle','-')
plot(Tf12,Yf12(:,16),'linewidth',2,'color',pink,'LineStyle','-')
hold off
xlabel('Time (h)')
ylabel('IL6 (pg/mL)')

% Tile 3
nexttile
plot(T0,Y0(:,17),'linewidth',2,'color',drkgrey,'LineStyle','--')
hold on
plot(Tf0,Yf0(:,17),'linewidth',2,'color',pink,'LineStyle','--')
plot(Tm0,Ym0(:,17),'linewidth',2,'color',blue,'LineStyle','--')
plot(T12,Y12(:,17),'linewidth',2,'color',drkgrey,'LineStyle','-')
plot(Tm12,Ym12(:,17),'linewidth',2,'color',blue,'LineStyle','-')
plot(Tf12,Yf12(:,17),'linewidth',2,'color',pink,'LineStyle','-')
hold off
xlabel('Time (h)')
ylabel('TNF\alpha (pg/mL)')

% Tile 4
nexttile
plot(T0,Y0(:,18),'linewidth',2,'color','black','LineStyle','--')
hold on
plot(Tf0,Yf0(:,18),'linewidth',2,'color',pink,'LineStyle','--')
plot(Tm0,Ym0(:,18),'linewidth',2,'color',blue,'LineStyle','--')
plot(T12,Y12(:,18),'linewidth',2,'color','black','LineStyle','-')
plot(Tm12,Ym12(:,18),'linewidth',2,'color',blue,'LineStyle','-')
plot(Tf12,Yf12(:,18),'linewidth',2,'color',pink,'LineStyle','-')
hold off
xlabel('Time (h)')
ylabel('IL10 (pg/mL)')

leg = legend('Control CT0', 'Female shifter CT0', 'Male shifter CT0','Control CT12', 'Male shifter CT12', 'Female shifter CT12', 'location','northoutside','orientation','horizontal');
leg.Layout.Tile = 'north';

%% Figure 9
% Simulated acute inflammation across different circadian times.
% ---------------------------------------------------
% Comparing male and female mice at different CTs
% for different doses of LPS
% one has to set the LPS dose manually each time
% replace the first entry (i) in y13_0 to the desired dose
% ---------------------------------------------------
figure(9)
tiledlayout(2,2)
clr = [0 0.4470 0.7410; 1.00,0.41,0.16;0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330;
    0.6350 0.0780 0.1840; 1 0 1];
colormap(clr);
    % ------------------------------------------------
    % Endotoxin dose: 3mg/kg
    % ------------------------------------------------
    % i prescribes the endotoxin dose and k time of infection
    % CT0: k=1, CT3: k=2, CT6: k=3, CT9: k=4, CT12: k=5, CT15: k=6, CT18: k=7, CT21: k=8, 
    i=2;  % Endotoxin dose = 3mg/kg   

% Tile 1
nexttile
for  k=1:1:8
    [T,Y] = contfun(i,k,25);
    [Tf,Yf] = femfun(i,k,25);
    [Tm,Ym] = malefun(i,k,25);
    % Damage
    h=plot([0.7,1,1.3], [max(Y(:,15)),max(Ym(:,15)),max(Yf(:,15))],'d','MarkerSize',20');
    set(h, 'MarkerFaceColor', clr(k,:));
    hold on
end   
hold off
xlim([0.5 1.5])
ylim([0.4 1.6])
xticks([0.7 1 1.3])
xticklabels({'Control','CJL male','CJL female'})
ylabel('Max. D')
set(gca,'FontSize',16)

% Tile 2
nexttile
for  k=1:1:8
    [T,Y] = contfun(i,k,25);
    [Tf,Yf] = femfun(i,k,25);
    [Tm,Ym] = malefun(i,k,25);
    % IL6
    h=plot([0.7,1,1.3], [max(Y(:,16)),max(Ym(:,16)),max(Yf(:,16))],'d','MarkerSize',20');
    set(h, 'MarkerFaceColor', clr(k,:));
    hold on
end   
hold off
xlim([0.5 1.5])
ylim([0 14000])
xticks([0.7 1 1.3])
xticklabels({'Control','CJL male','CJL female'})
ylabel('Maximum concentration of IL-6')
set(gca,'FontSize',16)

% Tile 3
nexttile
for  k=1:1:8
    [T,Y] = contfun(i,k,25);
    [Tf,Yf] = femfun(i,k,25);
    [Tm,Ym] = malefun(i,k,25);
    % TNF
    h=plot([0.7,1,1.3], [max(Y(:,17)),max(Ym(:,17)),max(Yf(:,17))],'d','MarkerSize',20');
    set(h, 'MarkerFaceColor', clr(k,:));
    hold on
end   
hold off
xlim([0.5 1.5])
ylim([500 2500])
xticks([0.7 1 1.3])
xticklabels({'Control','CJL male','CJL female'})
ylabel('Max. concentration of TNF-\alpha')
set(gca,'FontSize',16)

% Tile 4
nexttile
for  k=1:1:8
    [T,Y] = contfun(i,k,25);
    [Tf,Yf] = femfun(i,k,25);
    [Tm,Ym] = malefun(i,k,25);
    % IL10: only looking at the second peak
    h=plot([0.7,1,1.3], [max(Y(81:end,18)),max(Ym(81:end,18)),max(Yf(81:end,18))],'d','MarkerSize',20');
    set(h, 'MarkerFaceColor', clr(k,:));
    hold on
end   
hold off
xlim([0.5 1.5])
ylim([0 250])
xticks([0.7 1 1.3])
xticklabels({'Control','CJL male','CJL female'})
ylabel('Max. concentration of IL-10 // second peak')
set(gca,'FontSize',16)

leg = legend('CT0','CT3','CT6','CT9','CT12','CT15','CT18','CT21','Orientation','horizontal','Location','northoutside');
leg.Layout.Tile = 'north';


%% Associated function calls
%-------------------------------------------------------------------------
function [T,Y] = contfun(i,j,tend)
% (i) refers to the dose of endotoxin: (1--none), (2--3mg/kg), (3--6mmg/kg),(4--12mg/kg)
% (j) refers to the CT: (1--CT0), (2--CT3), (3--CT6),(4--CT9),(5--CT12), (6--CT15), (7--CT18),(8--CT21),
tSpan = 0:0.1:tend;
% ICs are  chosen to satisfy specific CTs
% some model parameters are used to formally determine IL10 and CA at t=0
% these two quantities are the only one (except for LPS) in the immune system
% sub-model that are not 0 at initial time.
dCA      = 3.1777e-2;
sCA      = 0.004; 
sIL10    =1187.2; 
xIL10d   =713.8094;
dIL10    =95.465;
% state variables: IL10 and CA
y18_0 = sIL10*xIL10d/(dIL10*xIL10d - sIL10); %IL10
y20_0 = sCA/dCA; %CA
% LPS
y13_0 = [0,3,6,12]; 

% starting at CT0 (reference: peak for Bmal1), run model for desired number
% of hours to obtain the set of ICs.
% ------------------CT0-----------------------
y0CT(1,:)=[1.5729,1.3787,1.4418,2.4508,2.3108,10.358,0.5279,0.002159,0.50798,7.1398,2.1638,0.1567,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT3-----------------------
y0CT(2,:)=[1.1462,0.81235,7.0601,1.4515,1.7451,8.6294,0.36149,0.0046158,0.47554,8.0053,1.5235,0.19954,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT6-----------------------
y0CT(3,:)=[1.5667,0.68517,12.575,1.2209,0.6787,7.4498,0.28374,0.011177,0.43004, 6.304,0.96287,0.21766,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT9-----------------------
y0CT(4,:)=[3.274,1.0093,13.294,2.1,0.34004,9.0676,0.34085,0.0164,0.40287,4.0944,0.8792,0.19884,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT12-----------------------
y0CT(5,:)=[4.0285,1.1971,11.319,2.6364,0.3088,10.842,0.378,0.0173,0.4033,3.1959,1.0554,0.1793,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT15-----------------------
y0CT(6,:)=[4.0131,1.5848,3.4256,3.3766,0.56717,14.823,0.45096,0.011791,0.43117,2.2777,1.8065,0.13024,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT18-----------------------
y0CT(7,:)=[2.9634,1.7795,1.1307,3.9824,1.1942,14.408,0.52783,0.0066179,0.46587,2.9946,2.2648,0.1126,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT21-----------------------
y0CT(8,:)=[1.9442,1.7044,0.58636,3.3555,2.1501,11.758,0.58345,0.0027595,0.5097,5.7429,2.3911,0.1309,y13_0(i),0,0,0,0,y18_0,0,y20_0];

lps0=y13_0(i);
y0=y0CT(j,:);
[T,Y] = ode45(@(t,y)mainMod(t,y,lps0), tSpan, y0); 
end

%-------------------------------------------------------------------------

% note that both CJL males and females experience an 8h-phase advance.
% CT refers to the time in the control model against which the CJL model is compared.
% For example, when it says CT0 below for femfum, the actual CJL female
% model starts at CT16 but the control model starts at CT0
% This notation facilitates the monitoring of simulations

function [Tf,Yf] = femfun(i,j,tend)
tSpan = 0:0.1:tend;
% same as in control model
dCA      = 3.1777e-2;
sCA      = 0.004; 
sIL10    =1187.2; 
xIL10d   =713.8094;
dIL10    =95.465;

y13_0 = [0,3,6,12]; 
y18_0 = sIL10*xIL10d/(dIL10*xIL10d - sIL10);
y20_0 = sCA/dCA;

% ------------------CT0-----------------------
y0CT(1,:)=[16.382,1.6356,3.3589,2.4148,0.37327,69.448,0.69435,0.0036157,0.51768, 2.893,0.82444,0.21273,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT3-----------------------
y0CT(2,:)=[19.514,1.8756,3.1193,2.8768,0.27153,77.799,0.74681,0.0044104,0.50632,2.0582,0.9538,0.19035,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT6-----------------------
y0CT(3,:)=[21.592,2.2502,1.9274, 3.383,0.30128,87.747,0.86692,0.0040272,0.51127,1.5931,1.2379,0.16016,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT9-----------------------
y0CT(4,:)=[20.806,2.6078,0.81503,3.9588,0.4849,95.421,1.0051,0.0027741,0.53157,1.5964,1.5833,0.13633,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT12-----------------------
y0CT(5,:)=[18.233,2.7468,0.46307,4.2299,0.68826,96.101,1.0802,0.0019943,0.55077,1.8937,1.7464,0.12983,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT15-----------------------
y0CT(6,:)=[12.264,2.6053,0.3532,3.6205,1.0991,86.042,1.1231  0.00094857,0.58402,3.1536,1.7189,0.14842,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT18-----------------------
y0CT(7,:)=[9.388,2.0371,1.1802,2.6163,1.0842,74.173,0.95841,0.0010338, 0.574,3.9004,1.3263,0.18293,y13_0(i),0,0,0,0,y18_0,0,y20_0];
% ------------------CT21-----------------------
y0CT(8,:)=[13.927,1.6002,3.0106,2.2162,0.53764,66.773,0.71889,0.0027453,0.53294, 3.475,0.8576,0.21513,y13_0(i),0,0,0,0,y18_0,0,y20_0];

lps0=y13_0(i);
y0=y0CT(j,:);
[Tf,Yf] = ode45(@(t,y)femMod(t,y,lps0), tSpan, y0); 
end


%-------------------------------------------------------------------------
% note that both CJL males and females experience an 8h-phase advance.
% CT refers to the time in the control model against which the CJL model is compared.
% For example, when it says CT12 below for malefum, the actual CJL female
% model starts at CT4 but the control model starts at CT0
% This notation facilitates the monitoring of simulations

function [Tm,Ym] = malefun(i,j,tend)
tSpan = 0:0.1:tend;
% same as in control model
dCA      = 3.1777e-2;
sCA      = 0.004; 
sIL10    =1187.2; 
xIL10d   =713.8094;
dIL10    =95.465;

y13_0 = [0,3,6,12]; 
y18_0 = sIL10*xIL10d/(dIL10*xIL10d - sIL10);
y20_0 = sCA/dCA;

% ------------------CT0-----------------------
y0CT(1,:)=[8.9437,0.93781, 25.975, 2.0011,0.53522, 33.804,0.35102, 0.027876,0.45508, 5.2666,0.81791,0.21279,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT3-----------------------
y0CT(2,:)=[12.079, 1.1786, 22.899,  2.734,0.38805, 41.041,0.39332,0.03355,0.44723, 3.5376, 1.0038,0.18517,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT6-----------------------
y0CT(3,:)=[13.786, 1.4396, 12.333, 3.2663,0.48074, 50.008,0.44871, 0.029031,0.45888, 2.6526, 1.3889, 0.1513,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT9-----------------------
y0CT(4,:)=[11.666, 1.6772, 4.5214, 3.8704,0.88757, 54.909,0.51872, 0.018628,0.48506, 2.7466, 1.8307,0.12595,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT12-----------------------
y0CT(5,:)=[9.8905,1.76, 2.5358,  4.155, 1.2895, 54.258, 0.5609,0.01335, 0.5059, 3.3498, 2.0195,0.11997,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT15-----------------------
y0CT(6,:)=[6.3132, 1.6184, 1.8467, 3.2825, 2.1894, 46.184,0.60124,0.0056306,0.54449, 6.2125, 2.0455,0.14336,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT18-----------------------
y0CT(7,:)=[4.6043, 1.1231, 8.3302, 2.0912, 2.1254, 38.896,0.49239,0.0064595,0.52808, 7.7922, 1.5789,0.18311,y13_0(i),0,0,0,0, y18_0,0,y20_0];
% ------------------CT21-----------------------
y0CT(8,:)=[6.3665,0.82621, 23.367, 1.6077,0.85427, 32.012,0.35106, 0.020593,0.47451,  6.641,0.89398,0.21781,y13_0(i),0,0,0,0, y18_0,0,y20_0];

lps0=y13_0(i);
y0=y0CT(j,:);
[Tm,Ym] = ode45(@(t,y)maleMod(t,y,lps0), tSpan, y0); 
end
