% Computes the illumination data considering the rotation of the satellite

% Day of the simulation
% day = input('What is the day of the simulation? \n') ;
day = 1 ;

% Load the satellite orbital parameters
SatelliteProperties_perso

% Number of orbit 
orbit = 14 ;

% Evolution of the orbit angle (teta) during the orbits 
T_orbit = floor(2*pi*sqrt((Re+h)^3/(G*Me))) ; %orbit period
teta1 = 0:2*pi/(T_orbit):2*pi*orbit ;
teta1 = mod(teta1,2*pi) ;

% Time step in second
dt = 1 ; 

% Incoming flux on the satellite faces
% Column1 -> Direct Illumination
% Column2 -> Earth IR Radiation
% Column3 -> Albedo Radiation
% Column4 -> Total Radiation

x = zeros(length(teta1), 4) ;
xm = zeros(length(teta1), 4) ;
y = zeros(length(teta1), 4) ;
ym = zeros(length(teta1), 4) ;
z = zeros(length(teta1), 4) ;
zm = zeros(length(teta1), 4) ;

for i=1:length(teta1)
   [x(i,2), x(i,3), x(i,1)] = HeatReceived_perso(day,beta,teta1(i),h,pol_X,azi_X,0.3) ;
   x(i,4) = sum(x(i,:)) ;
   
   [xm(i,2), xm(i,3), xm(i,1)] = HeatReceived_perso(day,beta,teta1(i),h,pol_Xm,azi_Xm,0.3) ;
   xm(i,4) = sum(xm(i,:)) ;
   
   [y(i,2), y(i,3), y(i,1)] = HeatReceived_perso(day,beta,teta1(i),h,pol_Y,azi_Y,0.3) ;
   y(i,4) = sum(y(i,:)) ;
   
   [ym(i,2), ym(i,3), ym(i,1)] = HeatReceived_perso(day,beta,teta1(i),h,pol_Ym,azi_Ym,0.3) ;
   ym(i,4) = sum(ym(i,:)) ;
   
   [z(i,2), z(i,3), z(i,1)] = HeatReceived_perso(day,beta,teta1(i),h,pol_Z,azi_Z,0.3) ;
   z(i,4) = sum(z(i,:)) ;
   
   [zm(i,2), zm(i,3), zm(i,1)] = HeatReceived_perso(day,beta,teta1(i),h,pol_Zm,azi_Zm,0.3) ;
   zm(i,4) = sum(zm(i,:)) ;
   
   % Keep track of the rotation
%    azi_X = mod(azi_X + spinazi, 2*pi) ;
%    azi_Y = mod(azi_Y + spinazi, 2*pi) ;
%    azi_Z = mod(azi_Z + spinazi, 2*pi) ;
%    azi_Xm = mod(azi_Xm + spinazi, 2*pi) ;
%    azi_Ym = mod(azi_Ym + spinazi, 2*pi) ;
%    azi_Zm = mod(azi_Zm + spinazi, 2*pi) ;
%    
%    pol_X = pol_X + spinpol ;
%    if pol_X ~= pi
%        pol_X = mod(pol_X,pi) ;
%    end
%    pol_Y = pol_Y + spinpol ;
%    if pol_Y ~= pi
%        pol_Y = mod(pol_Y,pi) ;
%    end
%    pol_Z = pol_Z + spinpol ;
%    if pol_Z ~= pi
%        pol_Z = mod(pol_Z,pi) ;
%    end
%    pol_Xm = pol_Xm + spinpol ;
%    if pol_Xm ~= pi
%        pol_Xm = mod(pol_Xm,pi) ;
%    end
%    pol_Ym = pol_Ym + spinpol ;
%    if pol_Ym ~= pi
%        pol_Ym = mod(pol_Ym,pi) ;
%    end
%    pol_Zm = pol_Zm + spinpol ;
%    if pol_Zm ~= pi
%        pol_Zm = mod(pol_Zm,pi) ;
%    end   
   [pol_X,azi_X] = Rotation(pol_X,azi_X,spinX,spinY,spinZ) ;
   [pol_Y,azi_Y] = Rotation(pol_Y,azi_Y,spinX,spinY,spinZ) ;
   [pol_Z,azi_Z] = Rotation(pol_Z,azi_Z,spinX,spinY,spinZ) ;
   [pol_Xm,azi_Xm] = Rotation(pol_Xm,azi_Xm,spinX,spinY,spinZ) ;
   [pol_Ym,azi_Ym] = Rotation(pol_Ym,azi_Ym,spinX,spinY,spinZ) ;
   [pol_Zm,azi_Zm] = Rotation(pol_Zm,azi_Zm,spinX,spinY,spinZ) ;
end

% Same matrices as in Stefano code (for SPENVIS input)
inputE = [ x(:,1)' + x(:,3)'; xm(:,1)' + xm(:,3)'; 
            y(:,1)' + y(:,3)'; ym(:,1)' + ym(:,3)'; 
            z(:,1)' + z(:,3)'; zm(:,1)' + zm(:,3)' ];
inputT = [ x(:,4)'; xm(:,4)'; 
            y(:,4)'; ym(:,4)'; 
            z(:,4)'; zm(:,4)'  ];
