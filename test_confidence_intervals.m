function fraction_missed = test_confidence_intervals(mean_val, ci_samples)
    % Inputs:
    % mean_val: Mean value
    % ci_samples: n x 2 array, where each row contains [lower, upper] bounds for a sample.
    % alpha: The significance level (e.g., 0.25, 0.1)
    
    % Validate inputs
    % if size(ci_samples, 2) ~= 2
    %     error('ci_samples must be an n x 2 array, where each row contains [lower, upper] bounds.');
    % end
    % 
    % Number of samples
    num_samples = size(ci_samples, 1);
    
    % Initialize counters
    total_missed = 0;
    
    % Loop through all samples
    for i = 1:num_samples
        lower_bound = ci_samples(i, 1);
        upper_bound = ci_samples(i, 2);
        
        % Check if the true mean is within the interval
        if mean_val < lower_bound || mean_val > upper_bound
            total_missed = total_missed + 1;
        end
    end
    
    % Compute fraction missed
    fraction_missed = total_missed / num_samples;
end
