function binomial_simulation()
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Binomial Distribution: Approximation by Normal and Poisson
    % Author: Dr. Amir Zaimbashi
    % Edited by: Alireza Sotoodeh
    % University: Shahid Bahonar University of Kerman
    % Email: a.zaimbashi@uk.ac.ir
    %
    % Description:
    % - Computes and compares Binomial, Poisson, and Gaussian distributions.
    % - Accepts user-defined parameters n and p.
    % - Plots and exports results.
    %
    % References:
    % - Wikipedia: https://en.wikipedia.org/wiki/Binomial_distribution
    % - Statistics for Engineers, Montgomery & Runger
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% USER INPUT WITH VALIDATION
    prompt = 'Enter number of trials (n): ';
    n = input(prompt);
    if ~isscalar(n) || n <= 0 || floor(n) ~= n
        error('n must be a positive integer.');
    end

    prompt = 'Enter probability of success (p): ';
    p = input(prompt);
    if ~isscalar(p) || p < 0 || p > 1
        error('p must be a value between 0 and 1.');
    end

    q = 1 - p;
    mu = n * p;
    sigma2 = n * p * q;  % Variance
    k = 0:n;

    %% COMPUTE DISTRIBUTIONS
    binomial = compute_binomial(n, p, k);
    poisson  = compute_poisson(mu, k);
    gaussian = compute_gaussian(mu, sigma2, k);

    %% PLOT RESULTS
    plot_results(k, binomial, poisson, gaussian, mu, sigma2, n, p);

    %% SAVE DATA
    T = table(k', binomial', poisson', gaussian', ...
        'VariableNames', {'k', 'Binomial', 'Poisson', 'Gaussian'});
    writetable(T, 'distribution_data.csv');
    disp('Results saved to distribution_data.csv');
end

%% FUNCTION DEFINITIONS

function p_b = compute_binomial(n, p, k)
    % Vectorized binomial PMF
    log_coeff = gammaln(n+1) - gammaln(k+1) - gammaln(n-k+1);
    p_b = exp(log_coeff + k .* log(p) + (n - k) .* log(1 - p));
end

function p_p = compute_poisson(mu, k)
    % Poisson approximation to Binomial
    p_p = exp(-mu) .* (mu .^ k) ./ factorial(k);
end

function p_g = compute_gaussian(mu, var, k)
    % Normal approximation to Binomial
    p_g = (1 ./ sqrt(2 * pi * var)) .* exp(-((k - mu).^2) ./ (2 * var));
end

function plot_results(k, p_b, p_p, p_g, mu, var, n, p)
    figure('Color','w','Position',[100 100 800 500]);
    hold on;
    stem(k, p_b, 'filled', 'DisplayName','Binomial', 'Color',[0.2 0.2 1]);
    stem(k, p_p, ':', 'DisplayName','Poisson', 'Color',[1 0.5 0]);
    plot(k, p_g, 'LineWidth', 2, 'DisplayName','Gaussian', 'Color','green');

    % ±3σ lines
    xline(mu - 3 * sqrt(var), 'r--', 'LineWidth', 1.2, 'DisplayName', '-3σ');
    xline(mu + 3 * sqrt(var), 'r--', 'LineWidth', 1.2, 'DisplayName', '+3σ');

    title(['Binomial Approximation | n = ' num2str(n) ', p = ' num2str(p)]);
    xlabel('k (number of successes)', 'Interpreter','latex');
    ylabel('Probability', 'Interpreter','latex');
    legend('Location','northeast');
    grid on;
    hold off;

    % Save figure
    saveas(gcf, 'distribution_plot.png');
    disp('Plot saved to distribution_plot.png');
end
