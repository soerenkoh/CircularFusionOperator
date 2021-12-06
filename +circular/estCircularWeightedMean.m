function mean = estCircularWeightedMean( samples, variances )
%   \brief      Estimate the circular mean if knowledge of the sample
%               variances is available following approach of Stienne et al.
%   \details    This is the maximum likelihood estimator for the wrapped
%               normal distribution if the variance is known.
%
%   \param      samples  Vector of samples from circular distribution
%   \param      variance Variance of the corresponding sample
%   \retval     mean     Weighted mean
%
%   \remark     G. Stienne, S. Reboul, M. Azmani, J.B. Choquel, and M. 
%               Benjelloun. A multi-temporal multi-sensor circular fusion 
%               filter. Information Fusion, 18:86–100, jul 2014.
    mean = atan2( sum( 1./variances .* sin( samples ) ), ...
                  sum( 1./variances .* cos( samples ) ) );
end