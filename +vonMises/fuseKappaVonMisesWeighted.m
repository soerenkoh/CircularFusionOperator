function fusedKappas = fuseKappaVonMisesWeighted( samples, kappas )
    % Stienne
    fusedKappas = sqrt( sum( kappas .* sin( samples ) ).^2 + ...
                          sum( kappas .* cos( samples ) ).^2 );
                      
%     fusedKappas = ( sum( kappas .* sin(samples) ) ./ sin( estCircularWeightedMean( samples, 1./kappas ) ) );
        
               
end