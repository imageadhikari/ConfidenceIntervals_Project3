function [ samples, true_mean ] = generate_samples(dist_type, n, m, varargin)
    % Generates an n x m matrix of samples from a specified distribution,
    % ensuring all values are within [0, 1] without distorting the distribution's statistics.
    %
    % Parameters:
    %   dist_type (string): The type of distribution ("bernoulli", "uniform", etc.).
    %   n, m (int): Dimensions of the output matrix.
    %   varargin: Additional optional arguments:
    %       - For "bernoulli": probability of success (default: 0.5)
    %       - For "uniform": lower and upper bounds (default: 0, 1)
    %
    % Returns:
    %   samples (matrix): An n x m matrix of random samples in [0, 1].
    %
    % Supported distributions:
    %   - "bernoulli": Binary values (0 or 1) with specified success probability.
    %   - "uniform": Continuous values within specified range.

    switch dist_type
        case 'bernoulli'
            p = 0.5;
            if numel(varargin) >= 1
                p = varargin{1};
            end
            samples = double(rand(n, m) < p);
            true_mean = p;

        case 'uniform'
            lower = 0;
            upper = 1;
            if numel(varargin) >= 1
                lower = varargin{1};
            end
            if numel(varargin) >= 2
                upper = varargin{2};
            end
            if lower < 0 || upper > 1
                error('Uniform bounds must be within [0, 1].');
            end
            samples = lower + (upper - lower) * rand(n, m);
            true_mean = (lower + upper) / 2;

        otherwise
            error('Unsupported distribution type: %s. Supported types: "bernoulli", "uniform", "normal".', dist_type);
    end
end

