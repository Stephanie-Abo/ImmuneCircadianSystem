%--------------------------------
% Code to reproduce figure 7
%--------------------------------
%% Figure 7
i=2; %endotoxin dose = 3mg/kg
% start time CT12
% cry KO
[Tcry,Ycry] = KOfun(2,25,1);
% rev KO
[Trev,Yrev] = KOfun(2,25,2);
% cry KO
[Tror,Yror] = KOfun(2,25,3);
% control
[T,Y] = call_mainMod(2,5,25); % CT12

figure(7)
tiledlayout(1,2)

%Tile 1
nexttile
plot(Trev,Yrev(:,18),'linewidth',2,'LineStyle','-','Color','blue')
hold on
plot(Tcry,Ycry(:,18),'linewidth',2,'LineStyle','-','Color','green')
plot(Tror,Yror(:,18),'linewidth',2,'LineStyle','--','Color','red')
plot(T,Y(:,18),'linewidth',2,'LineStyle','--','Color','black') 
hold off
xlim([0 25])
ylim([0 500])
xlabel('Time (h)')
ylabel('IL10 (pg/mL)')
legend('Rev-Erb KO','Cry KO','Ror KO','Control','Location','northeast')

%Tile 2
nexttile
plot(Trev,Yrev(:,15),'linewidth',2,'LineStyle','-','Color','blue')
hold on
plot(Tcry,Ycry(:,15),'linewidth',2,'LineStyle','-','Color','green')
plot(Tror,Yror(:,15),'linewidth',2,'LineStyle','--','Color','red')
plot(T,Y(:,15),'linewidth',2,'LineStyle','--','Color','black') 
hold off
xlim([0 25])
ylim([0 1.6])
xlabel('Time (h)')
ylabel('D')
legend('Rev-Erb KO','Cry KO','Ror KO','Control','Location','northeast')

function [T,Y] = KOfun(i,tend,condition)
% (i) refers to the dose of endotoxin: (1--none), (2--3mg/kg), (3--6mmg/kg),(4--12mg/kg)
tSpan = 0:0.1:tend;

% parameters
dCA      = 3.1777e-2;
sCA      = 0.004; 
sIL10    =1187.2; 
xIL10d   =713.8094;
dIL10    =95.465;

% ICs choosen at CT12 (rerefencre trough for Bmal1); same as conntrol model
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
y18_0 = sIL10*xIL10d/(dIL10*xIL10d - sIL10); %IL10
y19_0 = 0;
y20_0 = sCA/dCA; %CA

lps0=y13_0(i);
y0= [y1_0 y2_0 y3_0 y4_0 y5_0 y6_0 y7_0 y8_0 y9_0 y10_0 y11_0 y12_0 y13_0(i) y14_0 y15_0 y16_0 y17_0 y18_0 y19_0 y20_0];

if condition == 1
    y0([2,7]) = 0; %cry and CRY
elseif condition == 2
    y0([3,8]) = 0; %rev and REV
elseif condition == 3
    y0([4,9]) = 0; %ror and ROR
end

[T,Y] = ode45(@(t,y)KOexp(t,y,lps0,condition),tSpan,y0); 
end