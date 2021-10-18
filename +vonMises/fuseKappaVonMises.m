function fusedKappas = fuseKappaVonMises( samples )
 % Stienne
    fusedKappas = sqrt( sum( sin( samples ) ).^2 + ...
                        sum( cos( samples ) ).^2 );
end