function mean = estCircularMean( samples )
 % Borradaile, G.J.. Statistics of Earth Science Data: Their Distribution 
 % in Time, Space and Orientation. Springer Berlin Heidelberg 2003
    mean = atan2( sum( sin( samples ) ), ...
        sum( cos( samples ) ) );
end