function variance = estCircularVariance(samples)
%   \brief      Estimate the circular variance
%   \details    This method is universally valid. It does not depend on an
%               underlying distribution.
%
%   \param      samples  Vector of samples from circular distribution
%   \retval     variance Circular variance of samples
%
%   \remark     Borradaile, G.J.. Statistics of Earth Science Data: Their 
%               Distribution in Time, Space and Orientation. Springer 
%               Berlin Heidelberg 2003

n = length( samples );
lengthOfSampleMeanResultant = sqrt( ( sum( sin( samples ) ) ).^2 ...
                                  + ( sum( cos( samples ) ) ).^2 );
variance = 1 - lengthOfSampleMeanResultant ./ n;

end