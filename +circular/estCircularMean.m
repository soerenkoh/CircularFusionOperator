function mean = estCircularMean( samples )
%   \brief      Estimate the circular mean.
%   \details    This method is universally valid. It does not depend on an
%               underlying distribution.
%
%   \param      samples  Vector of samples from circular distribution
%   \retval     mean     Mean of samples
%
%   \remark     Borradaile, G.J.. Statistics of Earth Science Data: Their 
%               Distribution in Time, Space and Orientation. Springer 
%               Berlin Heidelberg 2003

    mean = atan2(   sum( sin( samples ) ), ...
                    sum( cos( samples ) ) );
end