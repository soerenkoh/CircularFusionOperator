function variance = estVarWrappedNormal( samples )
%   \brief      Estimate the Variance of Wrapped Normal distributed samples
%               following approach of Banerjee et al.
%
%   \param      samples  Vector of samples from distribution
%   \retval     variance Estimated variance
%   \remark     Arindam Banerjee, Inderjit S. Dhillon, Joydeep Ghosh, and 
%               Suvrit Sra. Clustering on the unit hypersphere using von 
%               mises-fisher distributions. Journal of Machine Learning 
%               Research, 6(46):1345–1382, 2005.

numSamples = length( samples );
lengthOfAverageVectorSqared = (1/numSamples * sum( cos( samples ) ) )^2 + ...
        (1/numSamples * sum( sin( samples ) ) )^2;
variance = -log( numSamples/(numSamples-1)*( lengthOfAverageVectorSqared -1/numSamples));

end