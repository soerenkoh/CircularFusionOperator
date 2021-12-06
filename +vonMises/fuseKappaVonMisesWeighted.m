function fusedKappas = fuseKappaVonMisesWeighted( samples, kappas )
%   \brief      ??? Fuse samples of von mises distribution with known
%               concentration parameter ???
%   \details    It is likely that I missunderstood the use of this formula.
%
%   \param      samples     Vector of samples from distribution
%   \param      kappa       Corresponding concentration parameters
%   \retval     fusedKappa  Concentration parameter
%
%   \remark     G. Stienne, S. Reboul, M. Azmani, J.B. Choquel, and M. 
%               Benjelloun. A multi-temporal multi-sensor circular fusion 
%               filter. Information Fusion, 18:86–100, jul 2014

    fusedKappas = sqrt( sum( kappas .* sin( samples ) ).^2 + ...
                        sum( kappas .* cos( samples ) ).^2 );
                      
end