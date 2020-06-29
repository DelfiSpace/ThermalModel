
% Satellite orbital parameters

%% Funcube
% %Day of the simulation
% day = 4 ;
% year = 2016 ;
% month = 2 ; 
% % jdate = julian(month,day,year) ; %julian day
% 
% % Orbital parameters
% % Mean_anomaly = 262.694 *pi/180 ; %Mean anomaly of funcube at the begining 
% Mean_anomaly = 283.694 *pi/180 ; 
% h = 630E3 ; %altitude
% LTAN = 10+30/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
% %RAAN = mltan2raan(jdate,LTAN) ; %Right ascension of the ascending node (in rad)
% RAAN = 94.3150 *pi/180 ;
% i = 97.004 *pi/180 ; %inclination (in rad)
% beta = BetaAngle_perso(35,RAAN,i) ; %beta angle (in rad)

%% QB50 P1
% Day of the simulation
day = 7 ;
year = 2015 ;
month = 5 ; 

% Orbital parameters
h = 604.2E3 ; %altitude (m)
Mean_anomaly = 30.8695 *pi/180 ; %Mean anomaly (in rad)
LTAN = 6+0/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
RAAN = 25.42 *pi/180 ;
i = 97.96 *pi/180 ; %inclination (in rad)
beta = BetaAngle_perso(127,RAAN,i) ; %beta angle (in rad)

%% Initial orientation of the satellite faces
pol_X = pi/2 ; %nadir facing plate
azi_X = pi ;
% pol_X = pi/2 ; %zenith facing plate
% azi_X = 0 ;
pol_Xm = pi-pol_X ;
if azi_X == 0 && pol_X == 0
    azi_Xm = 0;
elseif azi_X == 0 && pol_X == pi
    aziXm = 0;
else
    azi_Xm = mod(azi_X+pi,2*pi) ;
end

pol_Y = 0 ; %forward facing plate
azi_Y = 0 ;
% pol_Y = pi ; %aft facing plate
% azi_Y = 0 ;
pol_Ym = pi-pol_Y ;
if azi_Y == 0 && pol_Y == 0
    azi_Ym=0 ;
elseif azi_Y == 0 && pol_Y == pi
    azi_Ym = 0;
else
    azi_Ym = mod(azi_Y+pi,2*pi) ;    
end

pol_Z = pi/2 ; %South facing plate
azi_Z = pi/2 ;
pol_Zm = pi-pol_Z ;
if azi_Z == 0 && pol_Z == 0
    azi_Zm = 0 ;
elseif azi_Z == 0 && pol_Z == pi
    azi_Zm = 0 ;
else
    azi_Zm = mod(azi_Z+pi,2*pi) ;
end

% Orientation array for the faces
orientation = [pol_X azi_X ; pol_Xm azi_Xm ; pol_Y azi_Y ; pol_Ym azi_Ym ; pol_Z azi_Z ; pol_Zm azi_Zm] ;




