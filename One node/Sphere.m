% Satellite description file for a sphere in aluminium (radius = 0.1m)

% internal average power dissipation
constantHeat = 1.0; % W

% geometry of the sphere
r = 0.1 ; %m
A_disk = pi*r^2 ;
A_sphere = 4*pi*r^2 ;

% Heat capacitance of the sphere
mass = 4*pi*r^3/3 * densityAl ;
hc = mass * heatCAl ;

% emissivity of the solar panel surface (Kapton over anodized alluminum)
epsilonPanels = 0.8; 
% absorbptivity of the solar panel surface (Kapton over anodized alluminum)
alphaPanels = 0.8;

SolverMatrix = diag(1) ;

