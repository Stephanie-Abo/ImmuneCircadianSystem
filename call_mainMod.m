%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% example
% [T,Y] = call_mainMod(2,5,25); % CT12; endoptoxin dose: 3mg/kg
% Need to set 3 parameters
% (i) refers to the dose of endotoxin: (1--none), (2--3mg/kg),(3--6mmg/kg),(4--12mg/kg)
% (j) refers to the CT: (1--CT0), (2--CT3), (3--CT6),(4--CT9),(5--CT12), (6--CT15), (7--CT18),(8--CT21)
% "tend" = final simulation time
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function [T,Y] = call_mainMod(i,j,tend)
% (i) refers to the dose of endotoxin: (1--none), (2--3mg/kg), (3--6mmg/kg),(4--12mg/kg)
% (j) refers to the CT: (1--CT0), (2--CT3), (3--CT6),(4--CT9),(5--CT12), (6--CT15), (7--CT18),(8--CT21),
tSpan = 0:0.1:tend;
% ICs are  chosen to satisfy specific CTs
% some model parameters are used to formally determine IL10 and CA at t=0
% these two quantities are the only ones (except for LPS) in the immune system
% sub-model that are not 0 at initial time.
dCA      = 3.1777e-2;
sCA      = 0.004; 
sIL10    =1187.2; 
xIL10d   =713.8094;
dIL10    =95.465;
% state variables: IL10 and CA
y18_0 = sIL10*xIL10d/(dIL10*xIL10d - sIL10); %IL10
y20_0 = sCA/dCA; %CA
y13_0 = [0,3,6,12]; % LPS

% starting at CT0 (reference: peak for Bmal1), run model for desired number
% of hours to obtain the set of remaining ICs listed below.
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