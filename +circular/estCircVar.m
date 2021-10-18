function variance = estCircVarVonMises(samples)
% G. J. Borradaile.Statistics of earth science data : their distribution 
% in time, space, and orientation.  Springer, Berlin New York, 2003
n = length( samples );
lengthOfSampleMeanResultant = sqrt( ( sum( sin( samples ) ) ).^2 ...
                                  + ( sum( cos( samples ) ) ).^2 );
variance = 1 - lengthOfSampleMeanResultant ./ n;

end