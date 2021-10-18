function meanWeighted = estWeightedMean( samples, variances )

% meanWeighted = variances(2)*sum(variances) .* samples(1) + variances(q)*sum(variances) .* samples(2);
meanWeighted = sum(fliplr(variances) .* samples) ./ sum(variances);

end