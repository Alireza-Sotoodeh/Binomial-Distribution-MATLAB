%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binomial Distribution Approximation – MATLAB Simulation
%
% Description:
% This program compares the Binomial Distribution to its approximations:
%   - Normal (Gaussian) distribution
%   - Poisson distribution
%
% Author: Dr. Amir Zaimbashi
% Edited by: Alireza Sotoodeh (Student ID: 401412056)
% University: Shahid Bahonar University of Kerman, Iran
% Email: a.zaimbashi@uk.ac.ir
%
% Date: Spring 1403
%
% Note:
% - Code uses vectorization for performance.
% - Change 'n' and 'p' to test different scenarios.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc; close all;

% ----------------------------
% PARAMETERS
% ----------------------------
n = 100;        % Number of independent trials
p = 0.4;        % Probability of success
q = 1 - p;      % Probability of failure
s = n * p * q;  % Variance of Binomial distribution
mu = n * p;     % Mean (expected value)
k = 0:n;        % Range of discrete values

% ----------------------------
% BINOMIAL DISTRIBUTION
% ----------------------------
% Vectorized binomial PMF using log factorial to avoid overflow
p2 = arrayfun(@(u) exp(gammaln(n+1) - gammaln(u+1) - gammaln(n-u+1) + ...
              u*log(p) + (n-u)*log(1 - p)), k);

% ----------------------------
% POISSON APPROXIMATION
% ----------------------------
po = arrayfun(@(u) exp(-mu) * (mu^u / factorial(u)), k);

% ----------------------------
% NORMAL (GAUSSIAN) APPROXIMATION
% ----------------------------
f = (1 / sqrt(2 * pi * s)) * exp(-((k - mu).^2) / (2 * s));

% ----------------------------
% PLOTTING
% ----------------------------
figure('Color', 'w');

stem(k, p2, 'filled', 'DisplayName', 'Binomial'); hold on;
stem(k, po, ':', 'DisplayName', 'Poisson');
plot(k, f, 'LineWidth', 1.5, 'DisplayName', 'Gaussian');

% Mark ±3σ range
plot(n*p - 3*sqrt(s) * ones(1,10), linspace(0, max(f), 10), 'r--');
plot(n*p + 3*sqrt(s) * ones(1,10), linspace(0, max(f), 10), 'r--');

% ----------------------------
% AXES & LABELS
% ----------------------------
legend('Interpreter','latex', 'FontSize', 10, 'Location', 'northeast');
xlabel('$k$ (Number of Successes)', 'Interpreter','latex', 'FontSize', 12);
ylabel('Probability Density', 'Interpreter','latex', 'FontSize', 12);
title('Binomial Distribution and Its Approximations', 'FontSize', 14);
grid on;
