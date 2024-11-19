function cis = generate_confidence_intervals(samples, ci_type)
    % Generates confidence intervals for samples.
    %
    % Inputs:
    %   - samples: An n x m matrix where each row is a sample
    %
    % Outputs:
    %   - cis: An n x 2 matrix where each row is [lower_bound, upper_bound]

    n = size(samples, 1);
    cis = zeros(n, 2);

    for i = 1:n
        [a, b] = ci(samples(i, :), ci_type);
        cis(i, :) = [a, b];
    end
end

