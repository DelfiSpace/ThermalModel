function SolarFlux = SolarFlux(day)

% Computinf the solar flux received by Earth
% day = number of the day (ex: 1 january = 1)

% Astronomic unit
AU = 149.6E6 ;

distance = EarthOrbit(day) ;
distance_AU = distance/AU ;

SolarFlux = 1367./(distance_AU).^2 ; % W / m^2

end