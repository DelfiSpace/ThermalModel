function [Fpla, Falb, Fs] = HeatReceived_perso(day, beta, teta, h, pol, azi, albedo)

% Compute the external heat received on an orented face of a satellite
% day = number of the day (ex: 1 january = 1) (day in 1:365)
% beta = beta angle
% teta = orbit angle
% h = satellite altitude
% pol = polar angle in sperical coordinates; in the reference frame defined 
% by SPENVIS (Z axis parallel to speed)
% azi = azimuthal angle in spherical coordinates; in the reference frame 
% defined by SPENVIS (Z axis parallel to speed)
% albedo = fraction of sunligth reflected
% SPENVIS help: https://www.spenvis.oma.be/help/models/illum.html#PAR

eta = acos(cos(azi)*sin(pol)) ; % eta = angle between the normal and the local zenith 

% Earth Infrared Radiation
Fpla = PlanetFlux_perso(day,albedo) * ViewFactor_perso(h,eta) ;

% Albedo
if teta>=pi/2 && teta<=3*pi/2
    Falb = 0 ;
else
    Falb = AlbedoFlux_perso(day,beta,teta,albedo) * ViewFactor_perso(h,eta) ;
end

% Solar radiation
[umbra, r, teta_shadow] = EclipseTime_perso(beta,97.5,h) ;
if (teta>=teta_shadow && teta<=2*pi-teta_shadow)
    Fs = 0 ; % Staellite in shadow
else
    a = cos(beta)*cos(teta)*sin(pol)*cos(azi) + sin(beta)*sin(pol)*sin(azi) ...
        - cos(beta)*sin(teta)*cos(pol) ;
    Fs = SolarFlux_perso(day)*max(0,a);
end

end
