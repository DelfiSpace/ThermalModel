
% Satellite orbital parameters

%% Orbital parameters
h = 500E3 ; %altitude
i = 97.5 *pi/180 ; %inclination
beta = 60 *pi/180 ; %beta angle

%% Initial orientation of the satellite faces
pol_X = pi/2 ; %nadir facing plate
azi_X = pi ;
pol_Xm = pi-pol_X ;
if azi_X == 0
    azi_X = 0;
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
pol_Zm = mod(pol_Z+pi,pi) ;
if azi_Z == 0
    azi_Zm = 0 ;
else
    azi_Zm = mod(azi_Z+pi,2*pi) ;
end





