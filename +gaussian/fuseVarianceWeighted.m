function fusedVariance = fuseVarianceWeighted( variances )
    fusedVariance = prod( variances ) / sum( variances );
end