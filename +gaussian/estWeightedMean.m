function meanWeighted = estWeightedMean( samples, variances )
%   \brief      Estimate the mean if knowledge of the sample
%               variances is available.
%   \details    This is the maximum likelihood estimator for the 
%               Normal distribution if the variance is known.
%
%   \param      samples  Vector of samples from circular distribution
%   \param      variance Variance of the corresponding sample
%   \retval     mean     Weighted mean

meanWeighted = sum(fliplr(variances) .* samples) ./ sum(variances);

end