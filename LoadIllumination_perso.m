
% Computes the illumination data 

% Load the satellite orbital parameters
SatelliteProperties_perso

% Number of orbit 
orbit = 14 ;

% Evolution of the orbit angle (teta) during the orbits 
T_orbit = floor(2*pi*sqrt((Re+h)^3/(G*Me))) ; %orbit period
teta1 = Mean_anomaly:2*pi/(T_orbit):2*pi*orbit+Mean_anomaly ;
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
end

% Same matrices as in Stefano code (for SPENVIS input)
inputE = [ x(:,1)' + x(:,3)'; xm(:,1)' + xm(:,3)'; 
            y(:,1)' + y(:,3)'; ym(:,1)' + ym(:,3)'; 
            z(:,1)' + z(:,3)'; zm(:,1)' + zm(:,3)' ];
inputT = [ x(:,4)'; xm(:,4)'; 
            y(:,4)'; ym(:,4)'; 
            z(:,4)'; zm(:,4)'  ];

