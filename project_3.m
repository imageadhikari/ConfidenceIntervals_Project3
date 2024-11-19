%powers = 1:4; 
%x_values = 10.^powers; % 10, 100, 1,000, 10,000
x_values = [10, 100, 500, 1000, 5000, 10000];
num_samples = 10000;

% Parameters for distributions
bernoulli_means = [0.01, 0.5, 0.99];
uniform_bounds = [0, 0.3; 0.3, 0.7; 0.7, 1];

try 
    csv_file = 'results.csv';
    fd = fopen(csv_file, 'w');
    fprintf(fd, 'ci_method,N,percent_missed,param_info\n');

    for k = 1:10
        % Loop through Bernoulli distribution
        for mean_val = bernoulli_means
            y_values = zeros(size(x_values));
            for i = 1:length(x_values)
                [samples, true_mean] = generate_samples('bernoulli', num_samples, x_values(i), mean_val);
                cis = generate_confidence_intervals(samples, k);

                y_values(i) = test_confidence_intervals(true_mean, cis); 
                fprintf(fd, '%u,%u,%g,%g\n', k, x_values(i), y_values(i), mean_val);
            end

            % Plot the data
            figure;
            semilogx(x_values, y_values, '-o'); % Logarithmic x-axis
            xlabel('x (log scale)');
            ylabel('Fraction Missed');
            title(sprintf('Bernoulli (mean = %.1f), CI Method %u', mean_val, k));
            grid on;

            % Adjust x-axis to include 500 and 5000 explicitly
            xticks([10, 100, 500, 1000, 5000, 10000]);
            xtickformat('%,.0f');

            outputFilename = sprintf('Bernoulli_mean_%.1f_%u.png', mean_val, k);
            saveas(gcf, outputFilename);

            disp(['Plot saved as ', outputFilename]);
        end

        % Loop through Uniform distribution
        for bounds = uniform_bounds'
            lower = bounds(1);
            upper = bounds(2);
            y_values = zeros(size(x_values));
            for i = 1:length(x_values)
                [samples, true_mean] = generate_samples('uniform', num_samples, x_values(i), lower, upper);
                cis = generate_confidence_intervals(samples, k);

                y_values(i) = test_confidence_intervals(true_mean, cis); 
                fprintf(fd, '%u,%u,%g,[%g,%g]\n', k, x_values(i), y_values(i), lower, upper);
            end

            % Plot the data
            figure;
            semilogx(x_values, y_values, '-o'); % Logarithmic x-axis
            xlabel('x (log scale)');
            ylabel('Fraction Missed');
            title(sprintf('Uniform (bounds = [%.1f, %.1f]), CI Method %u', lower, upper, k));
            grid on;

            % Adjust x-axis to include 500 and 5000 explicitly
            xticks([10, 100, 500, 1000, 5000, 10000]);
            xtickformat('%,.0f');

            outputFilename = sprintf('Uniform_bounds_[%.1f_%.1f]_%u.png', lower, upper, k);
            saveas(gcf, outputFilename);

            disp(['Plot saved as ', outputFilename]);
        end
    end 
catch EX
    fclose(fd);
    rethrow(EX)
end
fclose(fd);
