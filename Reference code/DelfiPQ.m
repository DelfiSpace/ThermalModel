% Satellite description file for a 3U PocketQube

% satellite spin rates per axis
% spinX = 1.5438; % degrees/second
% spinY = 1.2345; % degrees/second
% spinZ = 2.2654; % degrees/second
spinX = 18.9; % degrees/second
spinY = 1.2345; % degrees/second
spinZ = 2.2654; % degrees/second

% internal average power dissipation
constantHeat = 0.7; % W

% active area of the solar panel in m^2
% use 0.00318 for AzurSpace solar cells
scarea = 0.00318; % m^2
% solar cells conversion efficiency
% use 0.298 for AzurSpace TJ30C solar cells
efficiency = 0.298;

% axis definition: X+ X- Y+ Y- Z+ Z-
% [1 1 1 1 0 0] means that the satellite has 1 solar cell on the
% X+, X-, Y+ and Y- directions

% 1U CubeSat
sa = [2 2 2 2 0 0] * scarea;
SolarArray = [0.178 * 0.05 0.178 * 0.05 0.178 * 0.05 0.178 * 0.05 0.0025 0.0025];
% thicknessSolarArray = 1e-3;
thicknessSolarArray = 1.6e-3;


contactWidth = 1e-3;
ThermalResistanceTopPlate =      0.001 / (0.05 * 0.007 * thermCAl);
ThermalResistanceMiddlePlate =    0.002 / (0.05 * 0.01 * thermCAl);
ThermalResistanceTop =       0.001 / (((0.05 * 0.05) - (0.0304 * 0.034)) * thermCAl);

% tcLongSide  = 0.05  / (0.178 * thicknessSolarArray * thermCAl);
% tcShortSide  = (0.178/2 + 0.05/2)  / (0.05 * thicknessSolarArray * thermCAl);
%tcLongSide  = 0.106  / (0.106 * thicknessSolarArray * thermCFR4);
%tcShortSide  = (0.106/2 + 0.106/2)  / (0.106 * thicknessSolarArray * thermCAl);

volumeSolarArray = SolarArray * thicknessSolarArray;

% area not covered by solar cells
panelarea = SolarArray - sa;
% make sure the panel area cannot be negative
if any(sum(panelarea < 0) ~= 0)
    error('One element of panel area is negative')
end

% solar panels mass
massSolarArray = volumeSolarArray * densityFR4;

% calculate the heat capacitance
hc = (heatCFR4 * massSolarArray)';

% absorbptivity of the solar panel surface (anodized alluminum)
% alphaPanels = 0.5;
alphaPanels = 0.94;  % black -> 0.94 white 0.21
% emissivity of the solar panel surface (anodized alluminum)
% epsilonPanels = 0.8;
epsilonPanels = 0.97; % black -> 0.97 white 0.96
% absorbptivity of AzurSpace solar cells
alphaSolarCells = 0.91;
%alphaSolarCells = 0.82;
% emissivity of solar cells (from Emcore / ClydeSpace datasheet)
 epsilonSolarCells = 0.85;
%epsilonSolarCells = 0.92;

t0 = 238;

hcFR4 = heatCFR4 * 0.042 * 0.042 * 0.0016 * 2.5 * 8 * densityFR4;
hc = [hc; hcFR4; hcFR4; thermCAl*0.0103; thermCAl*0.034; thermCAl*0.006 ];

%payload conductance matrix
payloadR  = 0.007 / (4 * 1e-3 *  1e-3 * pi * thermCsteel);
payloadRB  = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCAl);
payloadRPEEK  = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCPEEK);

SolverMatrix = diag(hc) / dt;

% thermal conductance between X+ and the metal structs
% axis definition: X+ X- Y+ Y- Z+ Z-
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 0 0 0 0 0 0 -1 0 0], ThermalResistanceTopPlate);
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 0 0 0 0 0 0 0 -1 0], ThermalResistanceMiddlePlate);
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 0 0 0 0 0 0 0 0 -1], ThermalResistanceTopPlate);

% thermal conductance between X- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 0 0 0 0 0 0 -1 0 0], ThermalResistanceTopPlate);
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 0 0 0 0 0 0 0 -1 0], ThermalResistanceMiddlePlate);
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 0 0 0 0 0 0 0 0 -1], ThermalResistanceTopPlate);

% thermal conductance between Y+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 1 0 0 0 0 0 -1 0 0], ThermalResistanceTopPlate);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 1 0 0 0 0 0 0 -1 0], ThermalResistanceMiddlePlate);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 1 0 0 0 0 0 0 0 -1], ThermalResistanceTopPlate);

% thermal conductance between Y- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 1 0 0 0 0 -1 0 0], ThermalResistanceTopPlate);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 1 0 0 0 0 0 -1 0], ThermalResistanceMiddlePlate);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 1 0 0 0 0 0 0 -1], ThermalResistanceTopPlate);

% thermal conductance between Z+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 1 0 0 0 -1 0 0], ThermalResistanceTop);

% thermal conductance between Z- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 1 0 0 0 0 -1], ThermalResistanceTop);

% thermal conductance between the payload and the metal struts
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 0 1 0 -1 0 0], payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 0 1 0 0 -1 0], payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 0 1 0 0 0 -1], payloadR*payloadRPEEK/(payloadR + payloadRPEEK));

% thermal conductance between the payload and the metal struts
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 0 0 1 -1 0 0], payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 0 0 1 0 -1 0], payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 0 0 1 0 0 -1], payloadR*payloadRB/(payloadR + payloadRB));

% calculate the effective absorbing and emitting area (weighted by the
% absorption and emission coefficients)
effectiveAbsorbingArea = panelarea' * alphaPanels + sa' * alphaSolarCells;
effectiveEmittingArea = panelarea' * epsilonPanels + sa' * epsilonSolarCells;
