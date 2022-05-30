%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% This code is for verification purposes only
% The code computes percentage change in mean gene expression levels due to CJL
% See table L in "supporting information"
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%----------------------------------------------------
% Full coupled model with damage 
% mean period = 24 hours 
%---------------------------------------------------- 
i=1; % no endotoxin
j=5; % CT12
tend=24*10; % ten cycles
[period_mean,period_meanF,period_meanM] = driver_period(i,j,tend);
%---------------------------------------------------- 
[Tc,Yc] = call_mainMod(i,j,tend); 
[Tf,Yf] = call_femMod(i,j,tend); 
[Tm,Ym] = call_maleMod(i,j,tend); 
cyclelength = (length(Tc)-1)/10;
%----------------------------------------------------
% FEMALE Mouse Model
% Verifying changes in MEAN expression levels of genes
%  Experiment                            VS.   Predicted
%  --------------------------------         ----------
%  lower Bmal1 mRNA by 43%                  -44% mRNA 
%  higher Per2 mRNA by 497%                  510% mRNA
%  higher Cry2 mRNA by 69%                   69% mRNA
%  lower Reva mRNA  by 70%                  -72% mRNA
%---------------------------------------------------- 
    change_meanF=zeros(12,1); %change in mean
for c=1:12
    change_meanF(c) = 100*(mean(Yf(:,c))-mean(Yc(:,c)))/mean(Yc(:,c)); 
end

%----------------------------------------------------
% MALE Mouse Model
% Verifying changes in MEAN expression levels of genes
% Experiment                           VS.   Predicted
%  --------------------------------         ----------
%  higher Per2 mRNA by 230%                  236% mRNA
%  higher Reva mRNA  by 98%                  103% mRNA
%---------------------------------------------------- 
    change_meanM=zeros(12,1); %change in mean
for c=1:12
    change_meanM(c) = 100*(mean(Ym(:,c))-mean(Yc(:,c)))/mean(Yc(:,c));  
end
