function variance = estVarStupavsky(samples)
% M. Stupavsky and D. T. A. Symons. Isolation of early Paleohelikian 
% remanence in Grenville anorthosites of the French River area, Ontario. 
% Canadian Journal of Earth Sciences. 19(4): 819-828. 
% https://doi.org/10.1139/e82-068 
mean = circular.estCircularMean( samples );

for distIdx=1:length(samples)
    mindist(distIdx) = 2* atan( tan( 0.5 * ( samples(distIdx) - mean) ) ); % FARRUGIA: On the Algorithms Used to Compute the Standard Deviation of Wind Direction
end % and Yartimatino
n=length(mindist);
variance  = n/(n-1) * 1/n * sum( mindist.^2 - (1/n*sum( mindist ) ) .^2 );

end