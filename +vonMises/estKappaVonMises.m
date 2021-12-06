function kappa = estKappaVonMises(samples)
%   \brief      Estimate concentration parameter of von Mises distribution
%
%   \param      samples  Vector of samples from distribution
%   \retval     kappa    Estimated concentration
%   \remark     Rade  Kutil. Biased and unbiased estimation of the circular
%               mean resultant length and its variance. Statistics, 
%               46(4):549–561, 2012.


numSamples = length( samples );
lengthOfSampleMeanResultant = abs( 1/numSamples * sum( exp( 1j * samples) ) );
% Simple approximation for k is 
kappa = lengthOfSampleMeanResultant*(2-lengthOfSampleMeanResultant^2) ./ (1-lengthOfSampleMeanResultant^2);

end