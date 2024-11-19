function [samples, true_mean] = generate_samples(dist_type, n, m, varargin)
    % Generates an n x m matrix of samples from a specified distribution.
    %
    % Parameters:
    %   dist_type (string): The type of distribution ("bernoulli", "uniform", "noisy").
    %   n, m (int): Dimensions of the output matrix.
    %   varargin: Additional optional arguments.
    %
    % Returns:
    %   samples (matrix): An n x m matrix of random samples.
    %   true_mean: The true mean of the distribution.

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
            samples = lower + (upper - lower) * rand(n, m);
            true_mean = (lower + upper) / 2;

        case 'noisy'
            [samples, true_mean] = sample_noisy_dataset(n, m);

        otherwise
            error('Unsupported distribution type: %s. Supported types: "bernoulli", "uniform", "noisy".', dist_type);
    end
end
