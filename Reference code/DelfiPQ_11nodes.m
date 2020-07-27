% Satellite description file for a 2U PocketQube

% This file is the model for DelfiPQ, considering one node per face, 2
% nodes for the payload and one node for each metal ring

% There must the same number of nodes per face (Nface is divisible by 6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% satellite spin rates per axis
spinX = 18.9; % degrees/second
spinY = 1.2345; % degrees/second
spinZ = 2.2654; % degrees/second

%% Satellite properties

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
SolarArray = [0.178*0.05 0.178*0.05 0.178*0.05 0.178*0.05 0.0025 0.0025];
Nface = size(SolarArray,1)*size(SolarArray,2) ; %number of nodes for the faces

% Area of Solar cells per node 
% sa=[1 1 1 1 0 0] means that the satellite has 1 solar cell on the
% X+, X-, Y+ and Y- directions
sa = [2 2 2 2 0 0] * scarea;
sa_sum = sum([sa ; zeros(1,length(sa))]) ; %Used to compute surfaceSA

thicknessSolarArray = 1.6e-3;

contactWidth = 1e-3;

% ThermalResistanceTopPlate =      0.001 / (0.05 * 0.007 * thermCAl);
% ThermalResistanceMiddlePlate =    0.002 / (0.05 * 0.01 * thermCAl);
% ThermalResistanceTop =       0.001 / (((0.05 * 0.05) - (0.0304 * 0.034)) * thermCAl);

ThermalResistanceTopPlate_Xp = (0.178/2) / (0.05*0.5 * thicknessSolarArray * thermCAl) ...
                            + 1/0.4 + (0.05/2) / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceTopPlate_Y = (0.178/2) / (0.05*0.5 * thicknessSolarArray * thermCAl) ...
                            + 1/0.4 + 0.05 / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceTopPlate_Xm = (0.178/2) / (0.05*0.5 * thicknessSolarArray * thermCAl) ...
                            + 1/0.4 + 0.05 / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceMiddlePlate_Xp = (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) ...
                            +1/0.4 + (0.05/2) / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceMiddlePlate_Y = (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) ...
                            +1/0.4 + 0.05 / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceMiddlePlate_Xm = (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) ...
                            +1/0.4 + 0.05 / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceTop = (0.05/2) / (0.05 * thicknessSolarArray * thermCAl) ...
                        +1/0.4 ;

% tcLongSide  = 0.05  / (0.178 * thicknessSolarArray * thermCAl);
% tcShortSide  = (0.178/2 + 0.05/2)  / (0.05 * thicknessSolarArray * thermCAl);
%tcLongSide  = 0.106  / (0.106 * thicknessSolarArray * thermCFR4);
%tcShortSide  = (0.106/2 + 0.106/2)  / (0.106 * thicknessSolarArray * thermCAl);

volumeSolarArray = SolarArray * thicknessSolarArray;

% area not covered by solar cells
panelarea = SolarArray - sa;
panelarea_sum = sum([panelarea ; zeros(1,length(panelarea))]) ; %Used to compute surfaceSP
% reshape the area matrices to have arrays that suited to ThermalBudget
sa = reshape(sa, 1, size(sa,1)*size(sa,2));
panelarea = reshape(panelarea, 1, size(panelarea,1)*size(panelarea,2));
% make sure the panel area cannot be negative
if any(sum(panelarea < 0) ~= 0)
    error('One element of panel area is negative')
end

% solar panels mass
massSolarArray = volumeSolarArray * densityFR4; 

% calculate the heat capacitance
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
hc = [hc; hcFR4; hcFR4; heatCAl*0.0103; heatCAl*0.034; heatCAl*0.006]; 

%payload conductance matrix
payloadR  = 0.007 / (4 * 1e-3 *  1e-3 * pi * thermCsteel); 
payloadRB  = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCAl); %tube
payloadRPEEK  = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1e-3 *  1e-3 * pi)) * thermCPEEK); %tube

SolverMatrix = diag(hc) / dt;

%% Thermal Links

% Node definition for the model with 1 node per face: 
% X+=1 X-=2 Y+=3 Y-=4 Z+=5 Z-=6 Payload1=7 Payload2=8 TopRing=9 MiddleRing=10 BottomRing=11

% thermal conductance between X+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 1, 9, ThermalResistanceTopPlate_Xp);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 10, ThermalResistanceMiddlePlate_Xp);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 11, ThermalResistanceTopPlate_Xp);

% thermal conductance between X- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 2, 9, ThermalResistanceTopPlate_Xm);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 10, ThermalResistanceMiddlePlate_Xm);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 11, ThermalResistanceTopPlate_Xm);

% thermal conductance between Y+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 3, 9, ThermalResistanceTopPlate_Y);
SolverMatrix = addThermalConnection(SolverMatrix, 3, 10, ThermalResistanceMiddlePlate_Y);
SolverMatrix = addThermalConnection(SolverMatrix, 3, 11, ThermalResistanceTopPlate_Y);

% thermal conductance between Y- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 4, 9, ThermalResistanceTopPlate_Y);
SolverMatrix = addThermalConnection(SolverMatrix, 4, 10, ThermalResistanceMiddlePlate_Y);
SolverMatrix = addThermalConnection(SolverMatrix, 4, 11, ThermalResistanceTopPlate_Y);

% thermal conductance between Z+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 5, 9, ThermalResistanceTop);

% thermal conductance between Z- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 6, 11, ThermalResistanceTop);

% thermal conductance between the payload and the metal struts
SolverMatrix = addThermalConnection(SolverMatrix, 7, 9, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
SolverMatrix = addThermalConnection(SolverMatrix, 7, 10, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));
%SolverMatrix = addThermalConnection(SolverMatrix, 7, 11, payloadR*payloadRPEEK/(payloadR + payloadRPEEK));

% thermal conductance between the payload and the metal struts
%SolverMatrix = addThermalConnection(SolverMatrix, 8, 9, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 8, 10, payloadR*payloadRB/(payloadR + payloadRB));
SolverMatrix = addThermalConnection(SolverMatrix, 8, 11, payloadR*payloadRB/(payloadR + payloadRB));

% calculate the effective absorbing and emitting area (weighted by the
% absorption and emission coefficients)
effectiveAbsorbingArea = panelarea' * alphaPanels + sa' * alphaSolarCells;
effectiveEmittingArea = panelarea' * epsilonPanels + sa' * epsilonSolarCells;
