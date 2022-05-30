%% CLOCK-IMMUNE MODEL FOR FEMALE MICE 

%% function to update states
function dydt = femMod(t,y,lps0)

%--------------------------------------------------------------------------
% we incorporate a linear function for the decay of the endotoxin insult
  lps=f(t,lps0);
  function lps=f(t,lps0)
      %set default
      %lps = zeros(size(t));
      lps(t > 24) = 0;
      ind = (0 <= t) & (t < 24);
      lps(ind) = lps0 - (lps0/24).*t(ind);
  end 
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% CLOCK parameters values
%--------------------------------------------------------------------------
% degradation rates
dm_per  = 0.10576;
dm_cry  = 0.50633;
dm_rev  = 0.47914;
dm_ror  = 0.26786;
dm_bmal = 4.6995;
dp_per  = 0.14989;
dp_cry  = 1.9105;
dp_rev  = 0.28899;
dp_ror  = 0.063637;
dp_bmal = 0.22534;
d_cb    = 0.1709;
d_pc    = 0.22571;
% maximal transcription rates
vmax_per  =0.83525;
vmax_cry  =1.0418;
vmax_rev  =0.065746;
vmax_ror  =7.2287;
vmax_bmal =0.29055;
% activation ratios
fold_per  =0.12156;
fold_cry  =13.828;
fold_rev  =130.78;
fold_ror  =0.078569;
fold_bmal =43.306;
% regulation threshold
ka_per_cb   =3.3679;
ki_per_pc   =0.14178;
ka_cry_cb   =1.5508;
ki_cry_pc   =0.0027556;
ki_cry_rev  =0.64066;
ka_rev_cb   =0.18454;
ki_rev_pc   =550.46;
ka_ror_cb   =0.56517;
ki_ror_pc   =0.072928;
ka_bmal_ror =0.076498;
ki_bmal_rev =0.0002375;
% hill coefficients
hill_per_cb   =17.025;
hill_per_pc   =22.829;
hill_cry_cb   =7.4632;
hill_cry_pc   =2.583;
hill_cry_rev  =58.733;
hill_rev_cb   =9.3373;
hill_rev_pc   =0.95847;
hill_ror_cb   =6.0371;
hill_ror_pc   =3.2993;
hill_bmal_ror =2.8187;
hill_bmal_rev =1.5678;
% translation rates
kp_per  =0.77741;
kp_cry  =0.9308;
kp_rev  =0.0004355;
kp_ror  =0.010866;
kp_bmal =0.97306;
% complexation rates
kass_cb  =0.0057803;
kass_pc  =0.15187;
kdiss_cb =0.00022191;
kdiss_pc =0.23509;

%--------------------------------------------------------------------------    
% Immune system parameters 
%--------------------------------------------------------------------------    
% Endotoxin
dp       = 3;
kP       = 1.385458; 
xP       = 0.5746; % avg. half-concentration for all three doses 
% Phagocytes
kN       =  5.239009955e+07; 
xN       =  11.5345; 
dN       =  0.195335; 
kNP      =  46.8879; 
kND      =  0.01297224; 
xNTNF    =  1530.0904; 
xNIL6    =  52121.3480; 
xNCA     =  0.0819918; 
xNIL10   =  138.3830; 
kNTNF    =  15.7694; 
kNIL6    =  2.916366; 

% Damage
kD       = 0.747386; 
dD       = 0.434761; 
xD       = 3572.1137;

% Slow-acting cytokines
kCA      = 1.381866e-09;
dCA      = 3.1777e-2;
sCA      = 0.004; 

% IL6
kIL6TNF  =23.15473;
xIL6TNF  =1072.9657;
kIL6     =4.2094572e+07;
dIL6     =0.410396;
xIL6     =2.012412e+08;
xIL6IL10 =1.32377;
kIL6IL6  =101.1321;
xIL6IL6  =14308.8692;
xIL6CA   =1.104116;

% TNF
kTNF     =9.326669e-08;
dTNF     =1.99835;
xTNFIL10 =6177.1302;
xTNFCA   =0.223434;
kTNFTNF  =0.198227;
xTNFTNF  =8520.5658;
xTNFIL6  =40998.1848;

% IL10
kIL10TNF =0.212173;
xIL10TNF =8905.7477;
kIL10IL6 =3.27267;
xIL10IL6 =22345.6179;
kIL10    =1.9301e+05;
dIL10    =95.465;
xIL10    =5.938865e+07;
sIL10    =1187.2; 
xIL10d   =713.8094;

% YIL10
kIL102   =3.804797e+06;
dIL102   =0.0224238;
xIL102   =8.470849;

%--------------------------------------------------------------------------    
% coupling
%--------------------------------------------------------------------------    
xIL6REV      = 0.0090; % mean concentration
xTNFROR      = 0.4534; % mean concentration
xTNFCRY      = 0.4315; % mean concentration
xIL10REV     = 0.004;  % half-average concentration

%% Rescaling due to chronic jet lag (CJL)

% Percentage change in mean gene expression levels due to CJL
%------------------------------------------
% lower Bmal1 mRNA by 43% 
% higher Per2 mRNA by 497% 
% higher Cry2 mRNA by 69%
% lower Reva mRNA by 70%
%------------------------------------------
% Chronic Jet Lag (CJL) modifications to obtain the percentage changes mentioned above
CJLbmal = 0.52; %1-0.43;
CJLper  = 3.54; %1+4.97;  
CJLcry  = 1.6;  %1+0.69;  
CJLrev  = 0.25; %1-0.7;  


%% ODEs (20 entries)
dydt = zeros(20,1);  

% clock genes and proteins 
     dydt(1) = -dm_per*y(1) + ((CJLper*vmax_per)*(1+fold_per*((y(12)/ka_per_cb)^hill_per_cb)))/(1+((y(12)/ka_per_cb)^hill_per_cb)*(1+((y(11)/ki_per_pc)^hill_per_pc)));
     dydt(2) = -dm_cry*y(2) + (CJLcry*vmax_cry)*(1+fold_cry*(y(12)/ka_cry_cb)^hill_cry_cb)/((1 + (y(12)/ka_cry_cb)^hill_cry_cb*(1 + (y(11)/ki_cry_pc)^hill_cry_pc))*(1 + (y(8)/(CJLrev*ki_cry_rev))^hill_cry_rev));
     dydt(3) = -dm_rev*y(3) + ((CJLrev*vmax_rev)*(1+fold_rev*((y(12)/ka_rev_cb)^hill_rev_cb)))/(1+((y(12)/ka_rev_cb)^hill_rev_cb)*(1+((y(11)/ki_rev_pc)^hill_rev_pc)));
     dydt(4) = -dm_ror*y(4) + (vmax_ror*(1+fold_ror*((y(12)/ka_ror_cb)^hill_ror_cb)))/(1+((y(12)/ka_ror_cb)^hill_ror_cb)*(1+((y(11)/ki_ror_pc)^hill_ror_pc)));
     dydt(5) = -dm_bmal*y(5) + (xP/(xP+lps))*((CJLbmal*vmax_bmal)*(1+fold_bmal*((y(9)/ka_bmal_ror)^hill_bmal_ror)))/(1+((y(8)/(CJLrev*ki_bmal_rev))^hill_bmal_rev)+((y(9)/ka_bmal_ror)^hill_bmal_ror));
     dydt(6) = -dp_per*y(6) + kp_per*y(1) - ((kass_pc/(CJLper*CJLcry))*y(6)*y(7) - CJLcry*CJLper*kdiss_pc*y(11));
     dydt(7) = -dp_cry*y(7) + kp_cry*y(2) - ((kass_pc/(CJLper*CJLcry))*y(6)*y(7) - CJLcry*CJLper*kdiss_pc*y(11));
     dydt(8) = -dp_rev*y(8) + kp_rev*y(3);
     dydt(9) = -dp_ror*y(9) + kp_ror*y(4);
     dydt(10) = -dp_bmal*y(10) + kp_bmal*y(5) - (kass_cb/CJLbmal)*y(10) + CJLbmal*kdiss_cb*y(12);
     dydt(11) = (kass_pc/(CJLper*CJLcry))*y(6)*y(7) - CJLcry*CJLper*kdiss_pc*y(11) - d_pc*y(11);
     dydt(12) = ((kass_cb/CJLbmal)*y(10) - CJLbmal*kdiss_cb*y(12)) - d_cb*y(12);
     
% P(t)
    dydt(13) = -dp*y(13);
    
% N(t)
    fUP_NTNF  = y(17)/(xNTNF+y(17));
    fUP_NIL6  = y(16)/(xNIL6+y(16));
    fDN_NCA   = xNCA/(xNCA+y(20));
    fDN_NIL10 = xNIL10/(xNIL10+y(18));
    R = (kNP*y(13) + kND*y(15)) * ((1+kNTNF*fUP_NTNF) * (1+kNIL6*fUP_NIL6)) * fDN_NCA * fDN_NIL10;
    dydt(14) = kN*(R/(xN+R)) - dN*y(14);

% D(t)
    dydt(15) = kD*(y(16)^4)/(xD^4+y(16)^4)+ kP*y(13)/(xP+y(13))  - dD*y(15); 
    
% IL6(t) 
    fUP_IL6TNF  = y(17)/(xIL6TNF+y(17));
    fUP_IL6IL6  = y(16)/(xIL6IL6+y(16));
    fDN_IL6IL10 = xIL6IL10/(xIL6IL10+y(18));
    fDN_IL6CA   = xIL6CA/(xIL6CA+y(20));
    fDN_IL6REV  = xIL6REV/(xIL6REV+y(8)); 
    funcIL6     = (1+(kIL6TNF*fUP_IL6TNF)+(kIL6IL6*fUP_IL6IL6)) * fDN_IL6IL10 * fDN_IL6CA; 
    dydt(16) = (kIL6*(y(14)^4/(xIL6^4+y(14)^4))*funcIL6)*fDN_IL6REV - dIL6*y(16);

% TNF(t)
    fUP_TNFTNF  = y(17)/(xTNFTNF+y(17));
    fDN_TNFCA   = (xTNFCA^6)/(xTNFCA^6+y(20)^6);
    fDN_TNFIL10 = xTNFIL10/(xTNFIL10+y(18));
    fDN_TNFIL6  = xTNFIL6/(xTNFIL6+y(16));
    funcTNF = (1+(kTNFTNF*fUP_TNFTNF)) * fDN_TNFCA * fDN_TNFIL10 * fDN_TNFIL6;
    fDN_TNFROR  = xTNFROR/(xTNFROR+y(9)); 
    fDN_TNFCRY  = xTNFCRY/(xTNFCRY+y(7)); 
    dydt(17) = (kTNF*y(14)^1.5 * funcTNF)*fDN_TNFROR*fDN_TNFCRY - dTNF*y(17);

% IL10(t) % 

    % YIL10(t)
    dydt(19) = kIL102*(y(15)^4/(xIL102^4+y(15)^4)) - dIL102*y(19);
    
    fUP_IL10IL6  = (y(16)^4)/(xIL10IL6^4+y(16)^4);
    fUP_IL10TNF  = y(17)/(xIL10TNF+y(17));
    fDN_IL10d    = xIL10d/(xIL10d+y(18));
    fDN_IL10REV  = xIL10REV/(xIL10REV+y(8));
    funcIL10 = (1+(kIL10IL6*fUP_IL10IL6)+(kIL10TNF*fUP_IL10TNF));
    dydt(18) = (kIL10*(y(14)^3/(xIL10^3+y(14)^3)) * funcIL10)*fDN_IL10REV - (dIL10*fDN_IL10d*y(18)) + y(19) + sIL10;
    
% CA(t)
    dydt(20) = kCA*y(14) - dCA*y(20) + sCA;
end