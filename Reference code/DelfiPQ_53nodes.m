% Satellite description file for a 2U PocketQube

% This file is the model for DelfiPQ, considering 5 nodes per face, 4 nodes
% for each metal ring and 11 nodes for the payloads (2 for the battery: PCB
% + battery)

% There must the same number of nodes per face (Nface is divisible by 6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PayloadModel

% satellite spin rates per axis
spinX = 18.9; % degrees/second
spinY = 1.2345; % degrees/second
spinZ = 2.2654; % degrees/second
% spinX = 0; % degrees/second
% spinY = 0; % degrees/second
% spinZ = 0; % degrees/second

%% Satellite properties

% internal average power dissipation (per payload node) (W)
% In the maximum consumption case: 
constantHeat = [0 ; 0.247 ; 0.15 ; 0.4 ; 0.4 ; 0.25 ; 0.066 ; 0;0 ; 0.066; 0.066];
% In the minimum consumption case: 
% constantHeat = [0 ; 0.126 ; 0 ; 0 ; 0 ; 0 ; 0.066 ; 0;0 ; 0.066 ; 0.066 ] ;

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

%contactWidth = 1e-3;

% Thermal Resistances
% ThermalResistanceTopPlate_middle =   (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) + 0.001/(0.05 * 0.007 * thermCAl);
ThermalResistanceTopPlate_middle =   (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) + 1/0.4;

% ThermalResistanceMiddlePlate_edge =    0.002 / (0.05 * 0.01 * thermCAl);
ThermalResistanceMiddlePlate_edge =    1/0.4;
%ThermalResistanceMiddlePlate_center =  (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) + ThermalResistanceMiddlePlate_edge; 

% ThermalResistanceTop_edge =       0.001 / (((0.05 * 0.05) - (0.0304 * 0.034)) * thermCAl); 
ThermalResistanceTop_edge =       1/0.4; 
%ThermalResistanceTop_center =     (0.05/sqrt(2)) / (0.05/sqrt(2) * thicknessSolarArray * thermCAl) + ThermalResistanceTop_edge;

ThermalResistanceInside_long = (0.178/2) / (0.05*0.5 * thicknessSolarArray * thermCAl) ;
ThermalResistanceInside_short = (0.05/2) / (0.178*0.5 * thicknessSolarArray * thermCAl) ;

ThermalResistanceInsideTOP_long =  0.05 / (0.05*0.5 * thicknessSolarArray * thermCAl) ;
ThermalResistanceInsideTOP_short = (0.05/sqrt(2)) / (0.05/sqrt(2) * thicknessSolarArray * thermCAl) ;

ThermalResistanceInsideRing_Top = 0.05 / (0.008 * 0.001 * thermCAl) ;
ThermalResistanceInsideRing_Middle = 0.05 / (0.008 * 0.002 * thermCAl) ;

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

% heat capacitance of the payloads and the other parts in the model

hc = [hc; hcPhasing ; hcCOMMS ; hcLNA ; hcGPS1 ; hcGPS2 ; hcADCS ; hcOBC ; hcPCB ; ...
    hcBattery ; hcEPS ; hcADB; heatCAl*0.0103/4 * ones(4,1); heatCAl*0.034* ones(4,1); ...
    heatCAl*0.006* ones(4,1)] ;


SolverMatrix = diag(hc) / dt;

%% Thermal Links

% Node definition for the model with 5 nodes per face: 
% X+=1:5 X-=6:10 Y+=11:15 Y-=16:20 Z+=21:25 Z-=26:30 
% TopRing=42:45 MiddleRing=46:49 BottomRing=50:53 Payloads=31:41 (see file
% PayloadModel for further information)

% thermal conductance between X+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 1, 42, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 43, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 46, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 4, 47, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 50, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 51, ThermalResistanceTopPlate_middle);

% thermal conductance between X- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 6, 44, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 6, 45, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 7, 48, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 9, 49, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 52, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 53, ThermalResistanceTopPlate_middle);

% thermal conductance between Y+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 11, 43, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 11, 44, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 12, 47, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 14, 48, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 51, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 52, ThermalResistanceTopPlate_middle);

% thermal conductance between Y- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 16, 45, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 16, 42, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 17, 49, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 19, 46, ThermalResistanceMiddlePlate_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 53, ThermalResistanceTopPlate_middle);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 50, ThermalResistanceTopPlate_middle);

% thermal conductance between Z+ and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 21, 42, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 22, 43, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 24, 44, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 25, 45, ThermalResistanceTop_edge);

% thermal conductance between Z- and the metal structs
SolverMatrix = addThermalConnection(SolverMatrix, 26, 50, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 27, 51, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 29, 52, ThermalResistanceTop_edge);
SolverMatrix = addThermalConnection(SolverMatrix, 30, 53, ThermalResistanceTop_edge);

% thermal conductance between the nodes of the top ring
SolverMatrix = addThermalConnection(SolverMatrix, 42, 43, ThermalResistanceInsideRing_Top);
SolverMatrix = addThermalConnection(SolverMatrix, 43, 44, ThermalResistanceInsideRing_Top);
SolverMatrix = addThermalConnection(SolverMatrix, 44, 45, ThermalResistanceInsideRing_Top);
SolverMatrix = addThermalConnection(SolverMatrix, 45, 42, ThermalResistanceInsideRing_Top);

% thermal conductance between the nodes of the middle ring
SolverMatrix = addThermalConnection(SolverMatrix, 46, 47, ThermalResistanceInsideRing_Middle);
SolverMatrix = addThermalConnection(SolverMatrix, 47, 48, ThermalResistanceInsideRing_Middle);
SolverMatrix = addThermalConnection(SolverMatrix, 48, 49, ThermalResistanceInsideRing_Middle);
SolverMatrix = addThermalConnection(SolverMatrix, 49, 46, ThermalResistanceInsideRing_Middle);

% thermal conductance between the nodes of the bottom ring
SolverMatrix = addThermalConnection(SolverMatrix, 50, 51, ThermalResistanceInsideRing_Top);
SolverMatrix = addThermalConnection(SolverMatrix, 51, 52, ThermalResistanceInsideRing_Top);
SolverMatrix = addThermalConnection(SolverMatrix, 52, 53, ThermalResistanceInsideRing_Top);
SolverMatrix = addThermalConnection(SolverMatrix, 53, 50, ThermalResistanceInsideRing_Top);

% thermal conductance between the nodes of X+
SolverMatrix = addThermalConnection(SolverMatrix, 1, 2, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 3, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 1, 4, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 2, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 3, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 5, 4, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 2, 3, ThermalResistanceInside_short);
SolverMatrix = addThermalConnection(SolverMatrix, 4, 3, ThermalResistanceInside_short);

% thermal conductance between the nodes of X-
SolverMatrix = addThermalConnection(SolverMatrix, 6, 7, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 6, 8, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 6, 9, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 7, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 8, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 10, 9, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 7, 8, ThermalResistanceInside_short);
SolverMatrix = addThermalConnection(SolverMatrix, 9, 8, ThermalResistanceInside_short);

% thermal conductance between the nodes of Y+
SolverMatrix = addThermalConnection(SolverMatrix, 11, 12, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 11, 13, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 11, 14, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 12, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 13, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 15, 14, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 12, 13, ThermalResistanceInside_short);
SolverMatrix = addThermalConnection(SolverMatrix, 14, 13, ThermalResistanceInside_short);

% thermal conductance between the nodes of Y-
SolverMatrix = addThermalConnection(SolverMatrix, 16, 17, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 16, 18, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 16, 19, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 17, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 18, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 20, 19, ThermalResistanceInside_long);
SolverMatrix = addThermalConnection(SolverMatrix, 17, 18, ThermalResistanceInside_short);
SolverMatrix = addThermalConnection(SolverMatrix, 19, 18, ThermalResistanceInside_short);

% thermal conductance between the nodes of Z+
SolverMatrix = addThermalConnection(SolverMatrix, 21, 22, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 21, 23, ThermalResistanceInsideTOP_short);
SolverMatrix = addThermalConnection(SolverMatrix, 21, 24, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 25, 22, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 25, 23, ThermalResistanceInsideTOP_short);
SolverMatrix = addThermalConnection(SolverMatrix, 25, 24, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 22, 23, ThermalResistanceInsideTOP_short);
SolverMatrix = addThermalConnection(SolverMatrix, 24, 23, ThermalResistanceInsideTOP_short);

% thermal conductance between the nodes of Z-
SolverMatrix = addThermalConnection(SolverMatrix, 26, 27, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 26, 28, ThermalResistanceInsideTOP_short);
SolverMatrix = addThermalConnection(SolverMatrix, 26, 29, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 30, 27, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 30, 28, ThermalResistanceInsideTOP_short);
SolverMatrix = addThermalConnection(SolverMatrix, 30, 29, ThermalResistanceInsideTOP_long);
SolverMatrix = addThermalConnection(SolverMatrix, 27, 28, ThermalResistanceInsideTOP_short);
SolverMatrix = addThermalConnection(SolverMatrix, 29, 28, ThermalResistanceInsideTOP_short);

% thermal conductances between the payloads
SolverMatrix = addThermalConnection(SolverMatrix, 31, 32, assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 32, 33, assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 33, 34, assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 34, 35, assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 35, 36, assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 36, 37, assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 37, 38, assembly2);
SolverMatrix = addThermalConnection(SolverMatrix, 38, 39, payloadBattery);
SolverMatrix = addThermalConnection(SolverMatrix, 38, 40, payloadAlSpacer1);
%SolverMatrix = addThermalConnection(SolverMatrix, 38, 40, payloadPolySpacer2);
SolverMatrix = addThermalConnection(SolverMatrix, 40, 41, payloadAlSpacer2);

% thermal conductance with the TOP bracket
SolverMatrix = addThermalConnection(SolverMatrix, 31, 42, payloadPanels);
SolverMatrix = addThermalConnection(SolverMatrix, 31, 43, payloadPanels);
SolverMatrix = addThermalConnection(SolverMatrix, 31, 44, payloadPanels);
SolverMatrix = addThermalConnection(SolverMatrix, 31, 45, payloadPanels);

% thermal conductance with the BOTTOM bracket
SolverMatrix = addThermalConnection(SolverMatrix, 41, 50, payloadPanels);
SolverMatrix = addThermalConnection(SolverMatrix, 41, 51, payloadPanels);
SolverMatrix = addThermalConnection(SolverMatrix, 41, 52, payloadPanels);
SolverMatrix = addThermalConnection(SolverMatrix, 41, 53, payloadPanels);

% thermal conductance with the MIDDLE bracket
SolverMatrix = addThermalConnection(SolverMatrix, 35, 46, 4*assembly1); %GPS2
SolverMatrix = addThermalConnection(SolverMatrix, 35, 47, 4*assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 35, 48, 4*assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 35, 49, 4*assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 36, 46, 4*assembly1); %ADCS
SolverMatrix = addThermalConnection(SolverMatrix, 36, 47, 4*assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 36, 48, 4*assembly1);
SolverMatrix = addThermalConnection(SolverMatrix, 36, 49, 4*assembly1);

% calculate the effective absorbing and emitting area (weighted by the
% absorption and emission coefficients)
effectiveAbsorbingArea = panelarea' * alphaPanels + sa' * alphaSolarCells;
effectiveEmittingArea = panelarea' * epsilonPanels + sa' * epsilonSolarCells;