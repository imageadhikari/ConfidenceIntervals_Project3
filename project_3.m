function project_3(methods, dist_type)
    if nargin < 1
        methods = 1:10; % Default to all methods if none specified
    end

    if nargin < 2
        dist_type = 'all'; % Default to run all distributions if none specified
    end

    % Define common variables
    x_values = [10, 100, 500, 1000, 5000, 10000];
    num_samples = 10000;

    % Parameters for distributions
    bernoulli_means = [0.01, 0.5, 0.99];
    uniform_bounds = [0, 0.3; 0.3, 0.7; 0.7, 1];

    % Open CSV file for results
    try
        csv_file = 'results.csv';
        fd = fopen(csv_file, 'w');
        fprintf(fd, 'ci_method,distribution,N,percent_missed,param_info\n');

        % Loop through all selected methods
        for k = methods
            % Loop through Bernoulli distribution if applicable
            if strcmp(dist_type, 'bernoulli') || strcmp(dist_type, 'all')
                for mean_val = bernoulli_means
                    y_values = zeros(size(x_values));
                    for i = 1:length(x_values)
                        [samples, true_mean] = generate_samples('bernoulli', num_samples, x_values(i), mean_val);
                        cis = generate_confidence_intervals(samples, k);
                        y_values(i) = test_confidence_intervals(true_mean, cis);
                        fprintf(fd, '%u,bernoulli,%u,%g,%g\n', k, x_values(i), y_values(i), mean_val);
                    end

                    % Plot results
                    plot_results(x_values, y_values, sprintf('Bernoulli (mean = %.2f), CI Method %u', mean_val, k), ...
                        sprintf('Bernoulli_mean_%.2f_%u.png', mean_val, k));
                end
            end

            % Loop through Uniform distribution if applicable
            if strcmp(dist_type, 'uniform') || strcmp(dist_type, 'all')
                for bounds = uniform_bounds'
                    lower = bounds(1);
                    upper = bounds(2);
                    y_values = zeros(size(x_values));
                    for i = 1:length(x_values)
                        [samples, true_mean] = generate_samples('uniform', num_samples, x_values(i), lower, upper);
                        cis = generate_confidence_intervals(samples, k);
                        y_values(i) = test_confidence_intervals(true_mean, cis);
                        fprintf(fd, '%u,uniform,%u,%g,[%g,%g]\n', k, x_values(i), y_values(i), lower, upper);
                    end

                    % Plot results
                    plot_results(x_values, y_values, sprintf('Uniform (bounds = [%.2f, %.2f]), CI Method %u', lower, upper, k), ...
                        sprintf('Uniform_bounds_[%.2f_%.2f]_%u.png', lower, upper, k));
                end
            end

            % Loop through Noisy distribution if applicable
            if strcmp(dist_type, 'noisy') || strcmp(dist_type, 'all')
                y_values = zeros(size(x_values));
                for i = 1:length(x_values)
                    [samples, true_mean] = generate_samples('noisy', num_samples, x_values(i));
                    cis = generate_confidence_intervals(samples, k);
                    y_values(i) = test_confidence_intervals(true_mean, cis);
                    fprintf(fd, '%u,noisy,%u,%g\n', k, x_values(i), y_values(i));
                end

                % Plot results
                plot_results(x_values, y_values, sprintf('Noisy Distribution, CI Method %u', k), ...
                    sprintf('Noisy_%u.png', k));
            end
        end
    catch EX
        fclose(fd);
        rethrow(EX);
    end
    fclose(fd);
end

function plot_results(x_values, y_values, title_str, filename)
    figure;
    semilogx(x_values, y_values, '-o'); % Logarithmic x-axis
    xlabel('x (log scale)');
    ylabel('Fraction Missed');
    title(title_str);
    grid on;

    % Adjust x-axis to include specific ticks
    xticks([10, 100, 500, 1000, 5000, 10000]);
    xtickformat('%,.0f');
    saveas(gcf, filename);
    disp(['Plot saved as ', filename]);
end
