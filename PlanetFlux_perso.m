function Flux = PlanetFlux_perso (day, albedo)

% Determination of the infrared radiation emitted by the planet,
% considering the temperature of the planet constant
% day = number of the day (ex: 1 january = 1) (day in 1:365)
% albedo = fraction of sunligth reflected

Flux = SolarFlux_perso(day)*(1-albedo)/4 ;

end
