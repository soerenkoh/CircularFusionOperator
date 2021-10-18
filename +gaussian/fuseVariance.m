function fusedVariance = fuseVariance( variances )
    fusedVariance = sum( variances ) ./ ( length( variances ) .* 2 ); 
end