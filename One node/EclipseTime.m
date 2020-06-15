function [umbra, r, teta] = EclipseTime(beta, h)

% Considering a cylindrical Earth shadow and neglecting time in penumbra:
% computing the time spent in shadow, the ratio of the orbit in shadow, and
% the angle of entry in shadow (if it never happens, teta = 1000)
% i=inlication
% h = altitude of the satellite
% beta = beta angle

Re = 6371E3 ; % m
Mass = 6.97E24 ; %kg

% Orbital period of the satellite
T = 2*pi*sqrt((Re+h)^3/((6.67E-11)*Mass)) ; % s

if (beta == pi/2)
    umbra = 0 ;
    r = 0 ;
    teta = 1000 ;
else
    b = ( (Re/(Re+h))^2 - sin(beta)^2 ) / ((cos(beta))^2) ;
    if (0<=b)
        a = sqrt(b) ;
        if (a>=-1 && a<=1)
            % Onset of shadowing :
            teta = pi - asin(a) ;

            % Ratio of the orbit spent in umbra
            r = 1-teta/pi ;

            % Time spent in umbra (s)
            umbra = r*T ;
        else
            % Time spent in umbra (s)
            umbra = 0 ;
            r = 0 ;
            teta = 1000 ;
        end
    else
        umbra = 0 ;
        r = 0 ;
        teta = 1000 ; 
    end
    
end

end