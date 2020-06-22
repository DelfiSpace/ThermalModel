
% Satellite orbital parameters

% Day of the simulation
day = 4 ;
year = 2016 ;
month = 2 ; 
% jdate = julian(month,day,year) ; %julian day

%% Orbital parameters
h = 630E3 ; %altitude
LTAN = 10+30/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
%RAAN = mltan2raan(jdate,LTAN) ; %Right ascension of the ascending node (in rad)
RAAN = 94.3150 *pi/180 ;
i = 97.004 *pi/180 ; %inclination (in rad)
beta = BetaAngle_perso(day,RAAN,i) ; %beta angle (in rad)

%% Initial orientation of the satellite faces
pol_X = pi/2 ; %nadir facing plate
azi_X = pi ;
pol_Xm = pi-pol_X ;
if azi_X == 0
    azi_Xm = 0;
else
    azi_Xm = mod(azi_X+pi,2*pi) ;
end

pol_Y = 0 ; %forward facing plate
azi_Y = 0 ;
pol_Ym = pi-pol_Y ;
if azi_Y == 0
    azi_Ym=0 ;
else
    azi_Ym = mod(azi_Y+pi,2*pi) ;    
end

pol_Z = pi/2 ; %North facing plate
azi_Z = 3*pi/2 ;
pol_Zm = pi-pol_Z ;
if azi_Z == 0
    azi_Zm = 0 ;
else
    azi_Zm = mod(azi_Z+pi,2*pi) ;
end

%% Satellite spin rates 
% spinX = 0; % rad/second
% spinY = 0; % rad/second
% spinZ = 0; % rad/second




