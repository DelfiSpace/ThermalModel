% Satellite description file for QB50 P1

% satellite spin rates per axis
spinX = 0.01; % degrees/second
spinY = 7.8; % degrees/second
spinZ = 7.8; % degrees/second

% internal average power dissipation
constantHeat = 3*1.3; % W

% active area of the solar panel in m^2
% use 0.00318 for AzurSpace solar cells
scarea = 0.00318; % m^2
% solar cells conversion efficiency
% use 0.298 for AzurSpace TJ30C solar cells
efficiency = 0.25;

% axis definition: X+ X- Y+ Y- Z+ Z-
% [1 1 1 1 0 0] means that the satellite has 1 solar cell on the
% X+, X-, Y+ and Y- directions

% 2U CubeSat
sa = [4 4 4 2 0 0] * scarea;
SolarArray = 0.1 * [0.228 0.228 0.228 0.228 0.1 0.1];
Nface = size(SolarArray,1)*size(SolarArray,2) ; %number of nodes for the faces
sa_sum = sum([sa ; zeros(1,length(sa))]) ; %Used to compute surfaceSA

% thicknessSolarArray = 1e-3;
% thicknessSolarArray = 2.9e-3;
thicknessSolarArray = 2e-3;


contactWidth = 1e-3;
%tcLongSide  = thicknessSolarArray / (0.178 * contactWidth * thermCAl);
%tcShortSide = thicknessSolarArray / (0.05  * contactWidth * thermCAl);

tcLongSide  = 0.1  / (0.228 * thicknessSolarArray * thermCAl);
tcShortSide  = (0.228/2 + 0.1/2)  / (0.1 * thicknessSolarArray * thermCAl);

volumeSolarArray = SolarArray * thicknessSolarArray;

% area not covered by solar cells
panelarea = SolarArray - sa;
panelarea_sum = sum([panelarea ; zeros(1,length(panelarea))]) ; %Used to compute surfaceSP
sa = reshape(sa, 1, size(sa,1)*size(sa,2));
panelarea = reshape(panelarea, 1, size(panelarea,1)*size(panelarea,2));
% make sure the panel area cannot be negative
if any(sum(panelarea < 0) ~= 0)
    error('One element of panel area is negative')
end

% solar panels mass
massSolarArray = volumeSolarArray * densityAl;

% calculate the heat capacitance
hc = (heatCAl * massSolarArray)';

% absorbptivity of the solar panel surface (anodized alluminum)
% alphaPanels = 0.38; % for funcube
alphaPanels = 0.5;
% emissivity of the solar panel surface (anodized alluminum)
% epsilonPanels = 0.89; % for funcube
epsilonPanels = 0.8;
% absorbptivity of AzurSpace solar cells
% alphaSolarCells = 0.82; % for funcube
alphaSolarCells = 0.91;
% emissivity of solar cells (from Emcore / ClydeSpace datasheet)
% epsilonSolarCells = 0.92; % for funcube
epsilonSolarCells = 0.85;

t0 = 238;

hcFR4 = heatCFR4 * 1.1e-3 * densityFR4; %Volume=1.1e-3 to have mass_payload=2kg
hc = [hc; hcFR4];

%payload conductance matrix
payloadR  = 0.02 / (4 * 2.5e-3 *  2.5e-3 * pi * thermCsteel);

SolverMatrix = diag(hc) / dt;

% thermal conductance between X+ and the other faces
SolverMatrix = addThermalConnection(SolverMatrix, 1, 3, tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 4, tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 5, tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 6, tcShortSide);

% thermal conductance between X- and the remaining faces
SolverMatrix = addThermalConnection(SolverMatrix, 2, 3, tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 4, tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 5, tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 6, tcShortSide);

% thermal conductance between Y+ and the remaining faces
SolverMatrix = addThermalConnection(SolverMatrix, 3, 5, tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, 3, 6, tcShortSide);

% thermal conductance between Y- and the remaining faces
SolverMatrix = addThermalConnection(SolverMatrix, 4, 5, tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, 4, 6, tcShortSide);

% thermal conductance between the payload and the Z+ and Z- faces
SolverMatrix = addThermalConnection(SolverMatrix, 5, 7, payloadR);
SolverMatrix = addThermalConnection(SolverMatrix, 6, 7, payloadR);

% calculate the effective absorbing and emitting area (weighted by the
% absorption and emission coefficients)
effectiveAbsorbingArea = panelarea' * alphaPanels + sa' * alphaSolarCells;
effectiveEmittingArea = panelarea' * epsilonPanels + sa' * epsilonSolarCells;
