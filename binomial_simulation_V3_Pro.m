function binomial_simulation(n_input, p_input)
% BINOMIAL_SIMULATION
% -------------------------------------------------------------------------
% Simulates the Binomial Distribution and compares it to:
%   - Poisson approximation (valid when np ≤ 2)
%   - Gaussian (Normal) approximation (valid when np ≥ 5 and nq ≥ 5)
%
% INPUTS:
%   - n_input (optional): number of trials (positive integer)
%   - p_input (optional): probability of success (0 ≤ p ≤ 1)
%
% OUTPUTS:
%   - Graph comparing distributions
%   - distribution_data_<timestamp>.csv file
%   - distribution_plot_<timestamp>.png image
%
% EXAMPLE:
%   binomial_simulation();            % Interactive mode
%   binomial_simulation(100, 0.3);    % Programmatic call
%
% Author: Dr. Amir Zaimbashi
% Edited by: Alireza Sotoodeh
% University: Shahid Bahonar University of Kerman
% -------------------------------------------------------------------------

    % Handle optional input
    if nargin < 2
        [n, p] = get_user_input();
    else
        n = n_input;
        p = p_input;
        validate_inputs(n, p);
    end

    % Edge case: n = 0
    if n == 0
        warning('n = 0 results in a degenerate distribution.');
        disp('No trials to simulate. Exiting.');
        return;
    end

    q = 1 - p;
    mu = n * p;
    sigma2 = n * p * q;
    k = 0:n;

    % Compute distributions
    binomial = compute_binomial(n, p, k);
    poisson  = compute_poisson(mu, k);
    gaussian = compute_gaussian(mu, sigma2, k);

    % Plot and save
    plot_results(k, binomial, poisson, gaussian, mu, sigma2, n, p);

    % Export data
    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
    dataFile = ['distribution_data_', timestamp, '.csv'];

    T = table(k', binomial', poisson', gaussian', ...
        'VariableNames', {'k', 'Binomial', 'Poisson', 'Gaussian'});
    T.n = repmat(n, height(T), 1);
    T.p = repmat(p, height(T), 1);

    try
        writetable(T, dataFile);
        fprintf('✅ Results saved to: %s\n', dataFile);
    catch
        warning('❌ Failed to save CSV file.');
    end
end

%% ------------------ FUNCTION: USER INPUT ------------------
function [n, p] = get_user_input()
    while true
        n = input('Enter number of trials (n): ');
        p = input('Enter probability of success (p, 0 ≤ p ≤ 1): ');
        try
            validate_inputs(n, p);
            break;
        catch ME
            fprintf('⚠️  %s\nPlease try again.\n\n', ME.message);
        end
    end
end

%% ------------------ FUNCTION: VALIDATION ------------------
function validate_inputs(n, p)
    if ~isscalar(n) || n < 0 || floor(n) ~= n
        error('n must be a non-negative integer.');
    end
    if ~isscalar(p) || p < 0 || p > 1
        error('p must be a value in the range [0, 1].');
    end
end

%% ------------------ FUNCTION: BINOMIAL ------------------
function p_b = compute_binomial(n, p, k)
    % Uses log-factorial (gammaln) to avoid overflow for large n
    log_coeff = gammaln(n + 1) - gammaln(k + 1) - gammaln(n - k + 1);
    p_b = exp(log_coeff + k .* log(p) + (n - k) .* log(1 - p));
end

%% ------------------ FUNCTION: POISSON ------------------
function p_p = compute_poisson(mu, k)
    % Poisson approximation for Binomial (when n large, p small)
    p_p = exp(-mu) .* (mu .^ k) ./ factorial(k);
end

%% ------------------ FUNCTION: GAUSSIAN ------------------
function p_g = compute_gaussian(mu, var, k)
    % Gaussian approximation for Binomial (when np, nq ≥ 5)
    p_g = (1 ./ sqrt(2 * pi * var)) .* exp(-((k - mu).^2) ./ (2 * var));
end

%% ------------------ FUNCTION: PLOT RESULTS ------------------
function plot_results(k, p_b, p_p, p_g, mu, var, n, p)
    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
    figure('Color', 'w', 'Position', [100 100 850 500]);

    hold on;
    stem(k, p_b, 'filled', 'DisplayName', 'Binomial', 'Color', [0.2 0.2 1]);
    stem(k, p_p, ':', 'DisplayName', 'Poisson', 'Color', [1 0.5 0]);
    plot(k, p_g, 'LineWidth', 2, 'DisplayName', 'Gaussian', 'Color', [0 0.7 0]);

    % ±3σ range
    xline(mu - 3 * sqrt(var), 'r--', 'DisplayName', '-3σ');
    xline(mu + 3 * sqrt(var), 'r--', 'DisplayName', '+3σ');

    % Annotations
    text(mu, max(p_b)*0.9, sprintf('\\mu = %.2f', mu), ...
        'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'black');

    title(sprintf('Binomial Distribution (n = %d, p = %.2f)', n, p));
    xlabel('k (Number of Successes)', 'FontSize', 11);
    ylabel('Probability', 'FontSize', 11);
    legend('Location', 'northeast');
    grid on;
    hold off;

    % Save plot
    figFile = ['distribution_plot_', timestamp, '.png'];
    try
        saveas(gcf, figFile);
        fprintf('📈 Plot saved to: %s\n', figFile);
    catch
        warning('❌ Failed to save plot image.');
    end
end
