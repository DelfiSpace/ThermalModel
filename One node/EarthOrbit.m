function distance = EarthOrbit(day)

% Computing the Earth-Sun distance
% day = number of the day (ex: 1 january = 1) (day in 1:365)

% Orbit data
% apogee = 152E6 ;
% perigee = 147E6 ;
e = 0.0167 ;
a = 149.6E6 ;
b = 149.58E6 ;
T = 365 ;

if (day>=3)
    x_Earth = a*cos(-pi+(day-3)*2*pi/(T+1)) ;
    y_Earth = b*sin(-pi+(day-3)*2*pi/(T+1)) ;
else
    x_Earth = a*cos(-pi+(T+(day-3))*2*pi/(T+1)) ;
    y_Earth = b*sin(-pi+(T+(day-3))*2*pi/(T+1)) ;
end

distance = sqrt((x_Earth+a*e).^2 + y_Earth.^2) ;


end