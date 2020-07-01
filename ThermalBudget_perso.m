% Thermal budget simulator
% It computes the available solar power for the different satellite axis 
% and computes the average incoming heat and determines the equilibrium 
% temperature and the temperature swing
%
% Author: Stefano Speretta <s.speretta@tudelft.nl> 
%
close all
clearvars
clc

%% Initialisation

% load physical constants needed for simulation
constants_perso;

% load illumination profile 
LoadIllumination_perso;

% load satellite configuration
% pocketqube3U_perso;
% funcube;
% DelfiPQ_11nodes;
DelfiPQ_35nodes;
% QB50_P1;


points = size(inputE, 2);

t0 = 4.2 - T0;

b = zeros(size(SolverMatrix, 2), points);
states = zeros(size(SolverMatrix, 1), points);

t = zeros(length(hc), points);
t(:,1) = t0;
t(Nface+1,1) = 17-T0;
% 3-axis rotation angles (all initialized to 0)
xAngle = 0;
yAngle = 0;
zAngle = 0;

% heat per simulation node
heat = zeros(length(hc), points);
% heat(1:Nface, 1) =    alphaSolarCells * rotateZ(rotateY(rotateX(inputT(:, 1)', xAngle), yAngle), zAngle) .* sa ...
%                 - rotateZ(rotateY(rotateX(inputE(:, 1)', xAngle), yAngle), zAngle) .* sa * efficiency ...
%                 + alphaPanels * rotateZ(rotateY(rotateX(inputT(:, 1)', xAngle), yAngle), zAngle) .* panelarea;
% heat(7,:) = constantHeat(1,1);
% heat(8,:) = constantHeat(2,1);
heat(1:Nface, 1) =    alphaSolarCells * FitNumberNode(rotateZ(rotateY(rotateX(inputT(:, 1)', xAngle), yAngle), zAngle)',Nface)' .* sa ...
                - FitNumberNode(rotateZ(rotateY(rotateX(inputE(:, 1)', xAngle), yAngle), zAngle)',Nface)' .* sa * efficiency ...
                + alphaPanels * FitNumberNode(rotateZ(rotateY(rotateX(inputT(:, 1)', xAngle), yAngle), zAngle)',Nface)' .* panelarea;

heat(7:7+length(constantHeat)-1,:) = constantHeat(:,1).* ones(length(constantHeat),size(heat,2)) ;

% create the arrays used to store the average surfaces
% area covered by silar cells
surfaceSA = zeros(size(inputE, 1), size(inputE, 2));
% solar panel area not covered by solar cells
surfaceSP = zeros(size(inputE, 1), size(inputE, 2));

avgHpower = sum(heat(1:Nface, 1));

%% Temperature Computation 
for h = 2 : points
    % calculate the incoming heat power
    %heat(1:Nface, h) =    alphaSolarCells * rotateZ(rotateY(rotateX(inputT(:, h)', xAngle), yAngle), zAngle) .*  sa ...
    %                - rotateZ(rotateY(rotateX(inputE(:, h)', xAngle), yAngle), zAngle) .* sa * efficiency ...
    %                + alphaPanels * rotateZ(rotateY(rotateX(inputT(:, h)', xAngle), yAngle), zAngle) .* panelarea;
    heat(1:Nface, h) =    alphaSolarCells * FitNumberNode(rotateZ(rotateY(rotateX(inputT(:, h)', xAngle), yAngle), zAngle)',Nface)' .*  sa ...
                    - FitNumberNode(rotateZ(rotateY(rotateX(inputE(:, h)', xAngle), yAngle), zAngle)',Nface)' .* sa * efficiency ...
                    + alphaPanels * FitNumberNode(rotateZ(rotateY(rotateX(inputT(:, h)', xAngle), yAngle), zAngle)',Nface)' .* panelarea;
    
    % keep track of the current position 
    xAngle = xAngle + spinX;
    yAngle = yAngle + spinY;
    zAngle = zAngle + spinZ;
    
    % calculate the total heat and normalize to account for 50%
    % illumination over the orbit
    avgHpower = avgHpower + sum(heat(1:Nface, h));
    
    surfaceSA(:,h) = rotateZ(rotateY(rotateX(sa_sum, xAngle), yAngle), zAngle)';
    surfaceSP(:,h) = rotateZ(rotateY(rotateX(panelarea_sum, xAngle), yAngle), zAngle)';
    
    % subtract the heat radiated (Stefan Boltzman law) by the solar cells
    heat(1:Nface,h) = heat(1:Nface,h) - sa' * sigma * epsilonSolarCells .* t(1:Nface, h - 1).^4;
    
    % subtract the heat radiated (Stefan Boltzman law) by the rest of the
    % solar panel area
    heat(1:Nface,h) = heat(1:Nface,h) - panelarea' * sigma * epsilonPanels .* t(1:Nface, h - 1).^4;

    % only take into account the lines that describe states (that also have
    % an incoming heat)
    b(1:length(hc), h) = heat(:,h) +  hc(:) / dt .* t(:,h - 1);     

    states = max(0, SolverMatrix \ b(:,h));
    
    % the first states are temperatures, the others are fluxes
    t(:, h) = states(1:length(hc));
end

%% Graphs
if (0)

figure
plot(output(1, :));
hold on
plot(output(2, :), 'r')
grid on
title('X')
%xlim([0 1000])

figure
plot(output(3, :));
hold on
plot(output(4, :), 'r')
grid on
title('Y')
%xlim([0 1000])

figure
plot(output(5, :));
hold on
plot(output(6, :), 'r')
grid on
title('Z')
%xlim([0 1000])
end

range = 1:size(t, 2);

plotAverage = mean(t(Nface+1,range))+T0

avgHpower = avgHpower / points;
avgSurfaceSA = mean(sum(surfaceSA, 1));
avgSurfaceSP = mean(sum(surfaceSP, 1));
equilibriumT = ((avgHpower + sum(constantHeat)) / (epsilonSolarCells * avgSurfaceSA + ...
    epsilonPanels * avgSurfaceSP) / sigma).^(1/4) + T0

figure
plot(t(1,range)+T0, 'LineWidth', 2)
hold on
plot(t(1*Nface/6+1,range)+T0, 'r', 'LineWidth', 2)
plot(t(2*Nface/6+1,range)+T0, 'g', 'LineWidth', 2)
plot(t(3*Nface/6+1,range)+T0, 'k', 'LineWidth', 2)
plot(t(4*Nface/6+1,range)+T0, 'm', 'LineWidth', 2)
plot(t(5*Nface/6+1,range)+T0, 'c', 'LineWidth', 2)
leg = {'X+'; 'X-'; 'Y+'; 'Y-'; 'Z+'; 'Z-'} ;
legPayload = [] ;
for i=1:length(constantHeat)
    plot(t(Nface+i,range)+T0, '--', 'LineWidth', 2) %plot the payloads temperature
    legPayload = [legPayload ; {['Payload',num2str(i)]}] ;
end
%plot(t(9,range)+T0, '.', 'LineWidth', 2)
%plot(t(10,range)+T0, 'o', 'LineWidth', 2)
%plot(t(11,range)+T0, '*', 'LineWidth', 2)
grid on
legend([leg; legPayload])
%legend('X+', 'X-', 'Y+', 'Y-', 'Z+', 'Z-', 'Payload 1', 'Payload2', 'Top', 'Middle', 'Bottom');
title('Thermal Simulation')
xlabel('Time - s')
ylabel('Temperature - degC')
%axis tight


