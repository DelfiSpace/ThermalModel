% Load general physical constants

% Earth parameters
Re = 6371E3 ;
Me = 5.97E24 ;

% Gravitational constant 
G = 6.67E-11 ;

% conversion factor for Kelvin <-> centigrade degrees conversion
T0 = -273.15;

% Stefan Boltzman constant
sigma = 5.670373e-8; % J m^-2 s^-1 K^-4

% Material properties
% Aluminum
heatCAl = 910;          % J kg^-1 K^-1
% thermCAl = 180;         % W m^-1 K^-1
thermCAl = 205;         % W m^-1 K^-1
densityAl = 2700;       % kg m^-3

% Steel
heatCsteel = 504;       % J kg^-1 K^-1
thermCsteel = 16;       % W m^-1 K^-1
densitysteel = 8000;    % kg m^-3

% FR4
% heatCFR4 = 1800;        % J kg^-1 K^-1
heatCFR4 = 1400;
% thermCFR4 = 0.25;       % W m^-1 K^-1
thermCFR4 = 0.3;
densityFR4 = 1850;      % kg m^-3
