function [matrix, true_mean] = sample_noisy_dataset(n, m)
    data = load('noisy_dataset.mat', 'samples', 'empirical_mean');
    values = data.samples;
    true_mean = data.empirical_mean;

    indices = randi(length(values), n, m);
    matrix = values(indices);
end
