function mindist = minimumDistanceBetweenTwoPoints(points, point2)
%   \brief      Minimum distance between two points on a circle.
%
%   \param      points  (Vector) of angles
%   \param      point2  (One) angle to compare against
%   \retval     mindist Estimated variance
%
%   \remark     Pierre S. Farrugia, James L. Borg, and Alfred Micallef. On 
%               the algorithms used to compute the standard deviation of 
%               wind direction. Journal of Applied Meteorology and 
%               Climatology, 48(10):2144–2151, oct 2009. 

mindist = 2 .* atan( tan( 0.5 .* (points - point2) ) );
