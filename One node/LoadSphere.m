
% Computes the illumination data for a spherical satellite

% Day of the simulation
day = 1 ;

% Load the satellite orbital parameters
SatelliteProperties

% Number of orbit 
orbit = 14 ;

% Evolution of the orbit angle (teta) during the orbits 
T_orbit = floor(2*pi*sqrt((Re+h)^3/(G*Me))) ; %orbit period
teta1 = 0:2*pi/(T_orbit):2*pi*orbit ;
teta1 = mod(teta1,2*pi) ;

% Time step in second
dt = 1 ;

% Incoming flux on the satellite
Fpla = ones(length(teta1), 1)*PlanetFlux(day, 0.3) ;
Falb = zeros(length(teta1),1) ;
Fs = zeros(length(teta1),1) ;
[umbra, r, teta_shadow] = EclipseTime(beta,h) ;

for j = 1:length(teta1)
    if teta1(j)>=pi/2 && teta1(j)<=3*pi/2
        Falb(j,1) = 0 ;
    else
        Falb(j,1) = AlbedoFlux(day, beta, teta1(j), 0.3);
    end
    
    if (teta1(j)>=teta_shadow && teta1(j)<=2*pi-teta_shadow)
        Fs(j,1) = 0 ; % Satellite in shadow
    else
        Fs(j,1) = SolarFlux(day) ;
    end
end

inputT = Fs' + Falb' + Fpla' ;

