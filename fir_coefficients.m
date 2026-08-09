clc;
clear;
close all;

%% 8-Tap FIR Filter Coefficient Generation

% FIR filter coefficients
h = [1 6 21 36 36 21 6 1];

% Number of taps
N = length(h);

%% Display Coefficients

disp('8-Tap FIR Filter Coefficients:');
disp(h);

%% Check Symmetry

if isequal(h, fliplr(h))
    disp('The FIR coefficients are symmetric.');
else
    disp('The FIR coefficients are not symmetric.');
end

%% Plot FIR Coefficients

figure;

stem(0:N-1, h, 'filled');

grid on;
xlabel('Coefficient Index');
ylabel('Coefficient Value');
title('8-Tap FIR Filter Coefficients');

%% Frequency Response

figure;

freqz(h, 1, 1024);

title('Frequency Response of 8-Tap FIR Filter');

%% Impulse Response

figure;

stem(0:N-1, h, 'filled');

grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('Impulse Response of 8-Tap FIR Filter');

%% Display Filter Equation

disp(' ');
disp('FIR Filter Equation:');
disp('y[n] = h0*x[n] + h1*x[n-1] + h2*x[n-2] + h3*x[n-3]');
disp('     + h4*x[n-4] + h5*x[n-5] + h6*x[n-6] + h7*x[n-7]');
