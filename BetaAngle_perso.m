function beta = BetaAngle_perso(day, RAAN, i)

% Computes Beta angle
% day = number of the day (ex: 1 january = 1) (day in 1:365)
% RAAN= Right ascension of the ascending node (in rad)
% i = inclination (in rad)

epsilon = 23.44 *pi/180 ; %Oblicity of the ecliptic (in rad)

% Ecliptic true solar longitude (in rad)
% day=78: vernal equinox (gamma=0°)
if day>=78
    gamma = (day-78)*0.986 *pi/180 ; %gamma increases of 0.986°/day
else
    gamma = (365-78+day)*0.986 *pi/180 ;
end

beta = asin(cos(gamma).*sin(RAAN).*sin(i)...
    -sin(gamma).*cos(epsilon).*cos(RAAN)*sin(i)...
    +sin(gamma).*sin(epsilon).*cos(i)) ;

end