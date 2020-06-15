function Flux = AlbedoFlux(day, beta, teta, albedo)

% day = number of the day (ex: 1 january = 1) (day in 1:365)
% beta = beta angle
% teta = orbit angle
% albedo = fraction of sunligth reflected

Flux = albedo*SolarFlux(day)*cos(beta)*cos(teta);

end