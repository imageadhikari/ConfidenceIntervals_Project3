function generate_noisy_dataset()
    total_size = 1000000;

    samples = [];
    
    while length(samples) < total_size
        pool = randn(1, total_size - length(samples));
        
        % filter
        valid_samples = pool(pool >= 0 & pool <= 1);
        
        samples = [samples, valid_samples];
    end

    % clip at correct length
    samples = samples(1:total_size);

    empirical_mean = mean(samples);

    save('noisy_dataset.mat', 'samples', 'empirical_mean');
end

