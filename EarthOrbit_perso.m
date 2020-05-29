function distance = EarthOrbit_perso(day)

% Computing the Earth-Sun distance
% day = number of the day (ex: 1 january = 1) (day in 1:365)

% Orbit data
apogee = 152E6 ;
perigee = 147E6 ;
e = 0.0167 ;
a = 149.6E6 ;
b = 149.58E6 ;
T = 365 ;

t=-pi:2*pi/T:pi;
x=a*cos(t(1:length(t)-1));
y=b*sin(t(1:length(t)-1));
% plot(x,y)
% axis equal
% title('Earth Orbit')
% hold on
% plot(0,0,'r*')
% plot(a*e,0,'r*')

%hold on
if (day>=3)
    x_Earth = x(day-2) ;
    y_Earth = y(day-2) ;
    % plot(x_Earth,y_Earth,'r*')
else
    x_Earth = x(length(x)-day+1) ;
    y_Earth = y(length(y)-day+1) ;
    % plot(x_Earth,y_Earth,'r*')
end

distance = sqrt((x_Earth+a*e).^2 + y_Earth.^2) ;

% hold off

end