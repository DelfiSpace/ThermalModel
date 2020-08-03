

% Payloads caracterization for the 53 nodes model
% Node description for the payloads (43 -> 53):
% 31 -> Phasing board
% 32 -> COMMS
% 33 -> LNA
% 34 -> GPS1
% 35 -> GPS2
% 36 -> ADCS
% 37 -> OBC
% 38 -> PCB
% 39 -> Batteries
% 40 -> EPX
% 41 -> ADB

% Heat capacitances
hcPhasing   = 12e-3 * heatCFR4 ;
hcCOMMS     = 20e-3 * heatCFR4 ;
hcLNA       = 20e-3 * heatCFR4 ;
hcGPS1      = 20e-3 * heatCFR4 ;
hcGPS2      = 20e-3 * heatCFR4 ;
hcADCS      = 23e-3 * heatCFR4 ;
hcOBC       = 10e-3 * heatCFR4 ;
hcPCB       = 10e-3 * heatCFR4 ;
hcBattery   = 36e-3 * heatBat ;
hcEPS       = 10e-3 * heatCFR4 ;
hcADB       = 15e-3 * heatCFR4 ;


payloadSteelRod     = 0.007 / (4 * 1e-3 *  1e-3 * pi * thermCsteel) + 1/0.4 ; %steel rod in the center of the Aluminium tube
payloadAlSpacer1    = 0.007 / (4 * ((2e-3 * 2e-3 * pi) - (1.2e-3 * 1.2e-3 *pi)) * thermCAl) + 1/0.4 ; %majority of spacers
payloadAlSpacer2    = 0.007 / (4 * ((2.5e-3 * 2.5e-3 * pi) - (1.2e-3 * 1.2e-3 *pi)) * thermCAl) + 1/0.4 ; %2cm aluminium spacer
payloadPolySpacer   = 0.020 / (4 * ((2e-3 * 2e-3 * pi) - (1.2e-3 * 1.2e-3 *pi)) * thermPoly) + 1/0.4 ; %between OBC and PCB
payloadPolySpacer2  = 0.007 / (4 * ((2e-3 * 2e-3 * pi) - (1.2e-3 * 1.2e-3 *pi)) * thermPoly) + 1/0.4 ; %between PCB and EPS if the battery needs it
payloadPanels       = 1/0.4 ; %between Phasing borad and TOP / ADB and BOTTOM
payloadBattery      = 0.003 / (0.035 * 0.035 * thermPoly) + 2/0.4 ; %between the battery and PCB

assembly1 = payloadSteelRod*payloadAlSpacer1/(payloadSteelRod + payloadAlSpacer1) ;
assembly2 = payloadSteelRod*payloadPolySpacer/(payloadSteelRod + payloadPolySpacer) ;

% % thermal conductances between the payloads
% SolverMatrix = addThermalConnection(SolverMatrix, 31, 32, assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 32, 33, assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 33, 34, assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 34, 35, assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 35, 36, assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 36, 37, assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 37, 38, assembly2);
% SolverMatrix = addThermalConnection(SolverMatrix, 38, 39, payloadBattery);
% SolverMatrix = addThermalConnection(SolverMatrix, 38, 40, payloadAlSpacer1);
% SolverMatrix = addThermalConnection(SolverMatrix, 40, 41, payloadAlSpacer2);
% 
% % thermal conductance with the TOP bracket
% SolverMatrix = addThermalConnection(SolverMatrix, 31, 42, payloadPanels);
% SolverMatrix = addThermalConnection(SolverMatrix, 31, 43, payloadPanels);
% SolverMatrix = addThermalConnection(SolverMatrix, 31, 44, payloadPanels);
% SolverMatrix = addThermalConnection(SolverMatrix, 31, 45, payloadPanels);
% 
% % thermal conductance with the BOTTOM bracket
% SolverMatrix = addThermalConnection(SolverMatrix, 41, 50, payloadPanels);
% SolverMatrix = addThermalConnection(SolverMatrix, 41, 51, payloadPanels);
% SolverMatrix = addThermalConnection(SolverMatrix, 41, 52, payloadPanels);
% SolverMatrix = addThermalConnection(SolverMatrix, 41, 53, payloadPanels);
% 
% % thermal conductance with the MIDDLE bracket
% SolverMatrix = addThermalConnection(SolverMatrix, 35, 46, 4*assembly1); %GPS2
% SolverMatrix = addThermalConnection(SolverMatrix, 35, 47, 4*assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 35, 48, 4*assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 35, 49, 4*assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 36, 46, 4*assembly1); %ADCS
% SolverMatrix = addThermalConnection(SolverMatrix, 36, 47, 4*assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 36, 48, 4*assembly1);
% SolverMatrix = addThermalConnection(SolverMatrix, 36, 49, 4*assembly1);


