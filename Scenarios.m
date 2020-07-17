
% Load Funcube TLE (DelfiPQ will have an orbit similar to Funcube)
fid = fopen('TLE FUNCUBE Jul2014-2020.txt','r') ;

RAAN = [] ;
DAY = [] ;
year =[] ;

n = 1 ;

while(true)
    line = fgetl(fid);
    if(line == -1)
        break;
    else
        if mod(n,2) == 0
            RAAN = [RAAN ; str2double(line(18:25))] ;
        else
%             day = [day ; floor(str2double(line(21:32)))] ;
            year = [year ; str2double(line(19:20))] ;
            DAY = [DAY ; str2double(line(21:32))] ;
        end
        n = n + 1;
    end
end
fclose(fid);

i = 97.004 *pi/180 ; %inclination (in rad)
h = 630E3 ; %altitude
Mean_anomaly = 283.694 *pi/180 ;
RAAN = RAAN *pi/180 ; 
beta_vec = BetaAngle_perso(DAY,RAAN,i) ; %beta angle (in rad)
orbit = 1 ;

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

illumination = zeros(length(beta_vec),1) ;
constants_perso

% Evolution of the orbit angle (teta) during the orbits 
T_orbit = floor(2*pi*sqrt((Re+h)^3/(G*Me))) ; %orbit period
teta1 = Mean_anomaly:2*pi/(T_orbit):2*pi*orbit+Mean_anomaly ;
teta1 = mod(teta1,2*pi) ;

x = zeros(length(teta1), 1) ;
xm = zeros(length(teta1), 1) ;
y = zeros(length(teta1), 1) ;
ym = zeros(length(teta1), 1) ;
z = zeros(length(teta1), 1) ;
zm = zeros(length(teta1), 1) ;

spinX = 18.9; % degrees/second
spinY = 1.2345; % degrees/second
spinZ = 2.2654; % degrees/second

xAngle = 0;
yAngle = 0;
zAngle = 0;

for k=1:length(beta_vec)
    disp(k)
    beta = beta_vec(k,1) ;
    day = DAY(k,1) ;
    
    xAngle = 0;
    yAngle = 0;
    zAngle = 0;

    % Incoming flux on the satellite faces

    for i=1:length(teta1)
       xAngle = xAngle + spinX;
       yAngle = yAngle + spinY;
       zAngle = zAngle + spinZ;
    
       [temp1, temp2, temp3] = HeatReceived_perso(day,beta,teta1(i),h,pol_X,azi_X,0.3) ;
       x(i,1) = temp1+temp2+temp3 ;

       [temp1, temp2, temp3] = HeatReceived_perso(day,beta,teta1(i),h,pol_Xm,azi_Xm,0.3) ;
       xm(i,1) = temp1+temp2+temp3 ;

       [temp1, temp2, temp3] = HeatReceived_perso(day,beta,teta1(i),h,pol_Y,azi_Y,0.3) ;
       y(i,1) = temp1+temp2+temp3 ;

       [temp1, temp2, temp3] = HeatReceived_perso(day,beta,teta1(i),h,pol_Ym,azi_Ym,0.3) ;
       ym(i,1) = temp1+temp2+temp3 ;

       [temp1, temp2, temp3] = HeatReceived_perso(day,beta,teta1(i),h,pol_Z,azi_Z,0.3) ;
       z(i,1) = temp1+temp2+temp3 ;

       [temp1, temp2, temp3] = HeatReceived_perso(day,beta,teta1(i),h,pol_Zm,azi_Zm,0.3) ;
       zm(i,1) = temp1+temp2+temp3 ;
       
       TEMP = rotateZ(rotateY(rotateX([x(i,1) xm(i,1) y(i,1) ym(i,1) z(i,1) zm(i,1)], xAngle), yAngle), zAngle);
       x(i,1) = TEMP(1) ;
       xm(i,1) = TEMP(2) ;
       y(i,1) = TEMP(3) ;
       ym(i,1) = TEMP(4) ;
       z(i,1) = TEMP(5) ;
       zm(i,1) = TEMP(6) ;
    end

    inputT = [ x(:,1)'; xm(:,1)'; 
                y(:,1)'; ym(:,1)'; 
                z(:,1)'; zm(:,1)'  ];
            
    
    illumination(k,1) = sum(sum(inputT,2)) ;
end

% Find the cold case scenario
range = find(beta_vec<1.1519) ;
indice = find(illumination(range,1) == min(illumination(range,1))) ;
beta_cold = beta_vec(indice) ;
DAY_cold = DAY(indice) ;

% Find the hot case scenario
indice2 = find(illumination == max(illumination)) ;
beta_hot = beta_vec(indice2) ;
DAY_hot = DAY(indice2) ;
