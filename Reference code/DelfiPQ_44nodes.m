% Satellite description file for a 2U PocketQube

% This file is the model for DelfiPQ, considering 5 nodes per face, 2
% nodes for the payload and 4 nodes for each metal ring

% There must the same number of nodes per face (Nface is divisible by 6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% satellite spin rates per axis
spinX = 18.9; % degrees/second
spinY = 1.2345; % degrees/second
spinZ = 2.2654; % degrees/second

% internal average power dissipation (per payload node)
constantHeat = [0.7/3 ; 0.7*2/3]; % W

% active area of the solar panel in m^2
% use 0.00318 for AzurSpace solar cells
scarea = 0.00318; % m^2
% solar cells conversion efficiency
% use 0.298 for AzurSpace TJ30C solar cells
efficiency = 0.298;

% axis definition: X+ X- Y+ Y- Z+ Z-

% 2U PocketQube
% Solar array: area of each node
% Column 1 -> X+
% Column 2 -> X-
% Column 3 -> Y+
% Column 4 -> Y-
% Column 5 -> Z+
% Column 6 -> Z-
SolarArray = 1/5 * [0.178*0.05 0.178*0.05 0.178*0.05 0.178*0.05 0.0025 0.0025 ; ...
                    0.178*0.05 0.178*0.05 0.178*0.05 0.178*0.05 0.0025 0.0025 ; ...
                    0.178*0.05 0.178*0.05 0.178*0.05 0.178*0.05 0.0025 0.0025 ; ...
                    0.178*0.05 0.178*0.05 0.178*0.05 0.178*0.05 0.0025 0.0025 ; ...
                    0.178*0.05 0.178*0.05 0.178*0.05 0.178*0.05 0.0025 0.0025 ] ;
Nface = size(SolarArray,1)*size(SolarArray,2) ; %number of nodes for the faces

% Area of Solar cells per node 
% sa=[1 1 1 1 0 0] means that the satellite has 1 solar cell on the
% X+, X-, Y+ and Y- directions
sa = 2/5 * scarea * [1 1 1 1 0 0 ; ...
                     1 1 1 1 0 0 ; ...
                     1 1 1 1 0 0 ; ...
                     1 1 1 1 0 0 ; ...
                     1 1 1 1 0 0 ] ;
sa_sum = sum([sa ; zeros(1,length(sa))]) ; %Used to compute surfaceSA

thicknessSolarArray = 1.6e-3;

contactWidth = 1e-3;

% Thermal Resistances
%ThermalResistanceTopPlate =      0.001 / (0.05 * 0.007 * thermCAl);
ThermalResistanceTopPlate_middle =      (0.05/2) / (0.05 * 0.007 * thermCAl);

ThermalResistanceMiddlePlate_edge =    0.002 / (0.05 * 0.01 * thermCAl);
ThermalResistanceMiddlePlate_center =  (0.05/2) / (0.05 * 0.01 * thermCAl);

ThermalResistanceTop_edge =       0.001 / (((0.05 * 0.05) - (0.0304 * 0.034)) * thermCAl); 
ThermalResistanceTop_center =     (0.05/sqrt(2)) / (((0.05 * 0.05) - (0.0304 * 0.034)) * thermCAl);

% tcLongSide  = 0.05  / (0.178 * thicknessSolarArray * thermCAl);
% tcShortSide  = (0.178/2 + 0.05/2)  / (0.05 * thicknessSolarArray * thermCAl);
%tcLongSide  = 0.106  / (0.106 * thicknessSolarArray * thermCFR4);
%tcShortSide  = (0.106/2 + 0.106/2)  / (0.106 * thicknessSolarArray * thermCAl);

volumeSolarArray = SolarArray * thicknessSolarArray;

% Area not covered by solar cells
panelarea = SolarArray - sa;
panelarea_sum = sum([panelarea ; zeros(1,length(panelarea))]) ; %Used to compute surfaceSP

% Reshape the area matrices to have arrays that suited to ThermalBudget
sa = reshape(sa, 1, size(sa,1)*size(sa,2));
panelarea = reshape(panelarea, 1, size(panelarea,1)*size(panelarea,2));
% Make sure the panel area cannot be negative
if any(sum(panelarea < 0) ~= 0)
    error('One element of panel area is negative')
end

% solar panels mass
massSolarArray = volumeSolarArray * densityFR4; 

% Calculate the heat capacitance
hc = (heatCFR4 * massSolarArray);
% reshape hc to have an array: number of lines = number of nodes
hc = reshape(hc,size(hc,1)*size(hc,2),1) ;

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

% heat capacitance of the payloads and the other parts in the model
hcFR4 = heatCFR4 * 0.042 * 0.042 * 0.0016 * 2.5 * 8 * densityFR4;
hc = [hc; hcFR4; hcFR4; heatCAl*0.0103/4 * ones(4,1); heatCAl*0.034* ones(4,1); heatCAl*0.006* ones(4,1)]; 

% Payload conductance matrix
% payloadR  = 0.007 / (4 * 1e-3 *  1e-3 * pi * thermCsteel); 
% payloadRB  = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCAl); %tube
% payloadRPEEK  = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCPEEK); %tube

payloadR  = 0.007 / (1e-3 *  1e-3 * pi * thermCsteel); 
payloadRB  = 0.007 / (((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCAl); %tube
payloadRPEEK  = 0.007 / (((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCPEEK); %tube

SolverMatrix = diag(hc) / dt;

% Node definition for the model with 5 nodes per face: 
% X+=1:5 X-=6:10 Y+=11:15 Y-=16:20 Z+=21:25 Z-=26:30 
% Payload1=31 Payload2=32 TopRing=33:36 MiddleRing=37:40 BottomRing=41:44

% thermal conductance between X+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 1, 33, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 34, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 37, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 3, 37, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 3, 38, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 4, 38, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 41, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 42, ThermalResistanceTopPlate_middle);

% thermal conductance between X- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 6, 35, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 6, 36, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 7, 39, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 8, 39, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 8, 40, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 9, 40, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 43, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 44, ThermalResistanceTopPlate_middle);

% thermal conductance between Y+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 11, 34, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 11, 35, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 12, 38, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 13, 38, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 13, 39, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 14, 39, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 42, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 43, ThermalResistanceTopPlate_middle);

% thermal conductance between Y- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 16, 36, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 16, 33, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 17, 40, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 18, 40, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 18, 37, ThermalResistanceMiddlePlate_center);
SolverMatrix = addThermalConnection(SolverMatrix, 19, 37, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 44, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 41, ThermalResistanceTopPlate_middle);

% thermal conductance between Z+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 21, 33, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 22, 34, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 23, 33, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 23, 34, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 23, 35, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 23, 36, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 24, 35, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 25, 36, ThermalResistanceTop_edge);

% thermal conductance between Z- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 26, 41, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 27, 42, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 28, 41, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 28, 42, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 28, 43, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 28, 44, ThermalResistanceTop_center);
SolverMatrix = addThermalConnection(SolverMatrix, 29, 43, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 30, 44, ThermalResistanceTop_edge);

% thermal conductance between the payload and the metal struts
SolverMatrix = addThermalConnection(SolverMatrix, 31, 33, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 34, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 35, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 36, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 37, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 38, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 39, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 40, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 41, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 42, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 43, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 31, 44, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));

% thermal conductance between the payload and the metal struts
SolverMatrix = addThermalConnection(SolverMatrix, 32, 33, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 34, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 35, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 36, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 37, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 38, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 39, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 40, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 41, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 42, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 43, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 32, 44, payloadR*payloadRB/(payloadR + payloadRB));

% calculate the effective absorbing and emitting area (weighted by the
% absorption and emission coefficients)
effectiveAbsorbingArea = panelarea' * alphaPanels + sa' * alphaSolarCells;
effectiveEmittingArea = panelarea' * epsilonPanels + sa' * epsilonSolarCells;