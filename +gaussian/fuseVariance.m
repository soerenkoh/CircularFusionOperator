function fusedVariance = fuseVariance( variances )
%   \brief      The variance after two measurements are fused while not
%               incorporating the knowledge about their variance.
%   \details    This is the maximum likelihood method for the Normal
%               distribution and was taken as the fusion operator for
%               Wrapped Normal and von Mises distribution as well.
%
%   \param      variance       Variance of the corresponding sample
%   \retval     fusedVariance  Variance after fusion of measurements
%
%   \remark     S. Kohnert and R. Stolle, "A High-Level Track Fusion Scheme 
%               for Circular Quantities," 2021 20th International 
%               Conference on Advanced Robotics. 2021, (accepted).

    fusedVariance = sum( variances ) ./ ( length( variances ) .* 2 ); 
end