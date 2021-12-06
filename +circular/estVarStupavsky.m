function variance = estVarStupavsky(samples)
%   \brief      Estimate the variance of circular distributed samples
%               following approach of Stupavsky and Symons.
%
%   \param      samples  Vector of samples from circular distribution
%   \retval     variance Estimated variance
%
%   \remark     M. Stupavsky and D. T. A. Symons. Isolation of early 
%               Paleohelikian remanence in Grenville anorthosites of the 
%               French River area, Ontario. Canadian Journal of Earth 
%               Sciences. 19(4): 819-828. https://doi.org/10.1139/e82-068 

mean = circular.estCircularMean( samples );

mindist = circular.minimumDistanceBetweenTwoPoints(samples, mean);

n=length(mindist);
variance  = n/(n-1) * 1/n * sum( mindist.^2 - (1/n*sum( mindist ) ) .^2 );

end