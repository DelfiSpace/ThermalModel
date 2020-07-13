% Computes the illumination data for the experiment: 10min illumination of
% one face : X+

% Load the satellite orbital parameters
SatelliteProperties_perso

teta1 = 1:20*60 ; %for 10min of experiment

% Time step in second
dt = 1 ; 

% Lamp radiation
inputE = zeros(6,length(teta1)) ;
inputT = 1412/2 * [ones(1,length(teta1)) ; zeros(5,length(teta1)) ] ;

% Convection
h_conv = 4.3 ; %W.m^-2.K^-1
