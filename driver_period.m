%--------------------------------------------------------------------------
% this code computes the period of oscillations
% mean period = 24 hours for control
% every element oscillates with a period of ~24h
%-------------------------------------------------------------------------- 
% example
% [period_mean,period_meanF,period_meanM] = periodfun(i,j,tend);
% Need to set 3 parameters
% (i) refers to the dose of endotoxin: (1--none), (2--3mg/kg),(3--6mmg/kg),(4--12mg/kg)
% (j) refers to the CT: (1--CT0), (2--CT3), (3--CT6),(4--CT9),(5--CT12), (6--CT15), (7--CT18),(8--CT21)
% "tend" = final simulation time
%--------------------------------------------------------------------------

function [period_mean,period_meanF,period_meanM] = driver_period(i,j,tend)
% call all functions for endotoxin level 0mg/kg at CT0 for 10 cycles
[Tp,Yp] = call_mainMod(i,j,tend); %24*10 gives roughly ten cycles
period=zeros(12,1);
 for c=1:12
    [~,peaklocs] = findpeaks(Yp(:,c));
    % peaks may not be exactly periodic, so take mean
    period(c) = mean(diff(peaklocs)*0.1); % multiply by 0.1 because steplength is 0.1
 end
period_mean = mean(period);


[Tf,Yf] = call_femMod(i,j,tend); % Female model 
period=zeros(12,1);
 for c=1:12
    [~,peaklocs] = findpeaks(Yf(:,c));
    % peaks may not be exactly periodic, so take mean
    period(c) = mean(diff(peaklocs)*0.1); % multiply by 0.1 because steplength is 0.1
 end
period_meanF = mean(period);


[Tm,Ym] = call_maleMod(i,j,tend); % Male model
period=zeros(12,1);
 for c=1:12
    [~,peaklocs] = findpeaks(Ym(:,c));
    % peaks may not be exactly periodic, so take mean
    period(c) = mean(diff(peaklocs)*0.1); % multiply by 0.1 because steplength is 0.1
 end
period_meanM = mean(period);
end