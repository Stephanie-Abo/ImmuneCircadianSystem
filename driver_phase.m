%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% This code computes phase differences between oscillatory signals in
% the control model vs male/female CJL models
% This code can be used to verify that ICs are chosen correctly to
% represent 8h phase advance induced by CJL
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Need to set 3 parameters
% (i) refers to the dose of endotoxin: (1--none), (2--3mg/kg),(3--6mmg/kg),(4--12mg/kg)
% (j) refers to the CT: (1--CT0), (2--CT3), (3--CT6),(4--CT9),(5--CT12), (6--CT15), (7--CT18),(8--CT21)
% "tend" = final simulation time

%%%%%%%%%%%%%%
% Example
%%%%%%%%%%%%%%
i=1; % no endotoxin
j=5; % CT12
tend=24*10; % set "tend" = 10-cycle length to allow oscillations to become sustained, if needed.
% ideally the models should run for at least two full cycles.


[T,Ymain] = call_mainMod(i,j,tend);
[Tf,Yfem] = call_femMod(i,j,tend);
[Tm,Ymale] = call_maleMod(i,j,tend);

% Get the period for each model 
% CJL may alter the period of oscillation
[period_mean,period_meanF,period_meanM] = driver_period(i,j,tend);

% How to interpret the results? 
% The results will be outputed as:
% PhDiff - phase difference Y -> X = (number) hrs
% 8-h phase advance = positive 8 hrs for Y -> X
% or equivalently, -16 hrs for Y -> X

%--------------------------------------------------------------------------
% The case for female CJL mice
%--------------------------------------------------------------------------
% Extract Ror mRNA time series
% we choose Ror as our reference because it is the only gene that is not directly affected by CJL.
x = Ymain(:,4); 
y = Yfem(:,4); 
% phase difference calculation
PhDiff = phdiffmeasure(x,y); % Rad
PhDiff_fem = PhDiff*period_meanF/(2*pi);    % hours
% display the phase difference
PhDiffstr = num2str(PhDiff_fem);
disp(['Phase difference Y->X = ' PhDiffstr 'hrs'])
% plot the signals
figure(11)
plot(T, x, '--b', 'LineWidth', 2)
grid on
hold on
plot(T, y, ':r', 'LineWidth', 2)
xlim([0 48])
ylim([-1.1 10.1])
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, h')
ylabel('Amplitude, Ror')
title('Two signals with phase difference')
legend('Control signal', 'CJLfemale signal')

%--------------------------------------------------------------------------
% The case for male CJL mice
%--------------------------------------------------------------------------
% Extract Ror mRNA time series
% we choose Ror as our reference because it is the only gene that is not directly affected by CJL.
x = Ymain(:,4); 
y = Ymale(:,4); 
% phase difference calculation
PhDiff = phdiffmeasure(x, y); % Rad
PhDiff_male = PhDiff*period_meanM/(2*pi);        % hours
% display the phase difference
PhDiffstr = num2str(PhDiff_male);
disp(['Phase difference Y->X = ' PhDiffstr 'hrs'])
% plot the signals
figure(12)
plot(T, x, '--b', 'LineWidth', 2)
grid on
hold on
plot(T, y, ':r', 'LineWidth', 2)
xlim([0 48])
ylim([-1.1 10.1])
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, h')
ylabel('Amplitude, Ror')
title('Two signals with phase difference')
legend('Control signal', 'CJLmale signal')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Phase Difference Measurement             %
%              with MATLAB Implementation              %
%                                                      %
% Author: M.Sc. Eng. Hristo Zhivomirov        12/01/14 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The present code is a Matlab function that provides a measurement of the phase difference between two signals. 
% The measurement is based on Discrete Fourier Transform (DFT) and Maximum Likelihood (ML) estimation of the signals properties. 
% The code is based on the theory described in:
% [1] M. Sedlacek, M. Krumpholc. “Digital measurement of phase difference – a comparative study of DSP algorithms”. Metrology and Measurement Systems, Vol. XII, No. 4, pp. 427-448, 2005. 
% [2] M. Sedlacek. “Digital Measurement of Phase Difference of LF Signals A Comparison of DSP Algorithms”. Proceedings of XVII IMEKO World Congress, pp. 639-644, 2003.

function PhDiff = phdiffmeasure(x,y)
% function: PhDiff = phdiffmeasure(x,y)
% x - first signal in the time domain
% y - second signal in the time domain
% PhDiff - phase difference Y -> X, rad
% represent x as column-vector if it is not
if size(x, 2) > 1
    x = x';
end
% represent y as column-vector if it is not
if size(y, 2) > 1
    y = y';
end
% remove the DC component
x = x - mean(x);
y = y - mean(y);
% signals length
N = length(x);
% window preparation
win = rectwin(N);
% fft of the first signal
X = fft(x.*win);
% fft of the second signal
Y = fft(y.*win);
% phase difference calculation
[~, indx] = max(abs(X));
[~, indy] = max(abs(Y));
PhDiff = angle(Y(indy)) - angle(X(indx));
end

