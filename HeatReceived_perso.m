function [Fpla, Falb, Fs] = HeatReceived_perso(day, beta, teta, h, eta, albedo)

% Computing the heat received on a face of a satellite (without taking into 
% account its area, characteristics...)
% day = number of the day (ex: 1 january = 1) (day in 1:365)
% beta = beta angle
% eta = angle between the normal to the surface and the local zenith (rad)
% teta = orbit angle
% e = angle between the orbital plane and the normale to the surface (rad,
% -pi/2<=e<=pi/2)
% h = satellite altitude
% albedo = fraction of sunligth reflected

% Earth Infrared Radiation
Fpla = PlanetFlux_perso(day,albedo) * ViewFactor_perso(h,eta) ;

% Albedo
if teta>=pi/2 && teta<=3*pi/2
    Falb = 0 ;
else
    Falb = AlbedoFlux_perso(day,beta,teta,albedo) * ViewFactor_perso(h,eta) ;
end
%Falb = AlbedoFlux_perso(day,beta,teta,albedo) * ViewFactor_perso(h,eta) ;

% Solar radiation
[umbra, r, teta_shadow] = EclipseTime_perso(beta,97.5,h) ;
if (teta>=teta_shadow && teta<=2*pi-teta_shadow)
    Fs = 0 ; % Staellite in shadow
else
    Fs = SolarFlux_perso(day)*max(0,cos(beta)*cos(eta+teta));
end

end