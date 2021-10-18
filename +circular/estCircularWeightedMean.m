function mean = estCircularWeightedMean( samples, variances )
 % Stienne
    mean = atan2( sum( 1./variances .* sin( samples ) ), ...
                  sum( 1./variances .* cos( samples ) ) );
end