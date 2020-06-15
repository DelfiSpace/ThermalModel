% Thermal budget simulator
% It computes the available solar power for the sperical satellite 
% and computes the average incoming heat and determines the equilibrium 
% temperature and the temperature swing
%
close all
clearvars
clc

%% Initialisation

% load phisycal constants needed for simulation
constants

% load illumination profile 
LoadSphere

% load satellite configuration
Sphere;

points = size(inputT, 2);

t0 = 4.2 - T0;

b = zeros(size(SolverMatrix, 2), points);
% states = zeros(size(SolverMatrix, 1), points);

t = zeros(length(hc), points);
t(:,1) = t0;
%t(7,1) = 17-T0;

% heat per simulation node
heat = zeros(length(hc), points);
heat(1,1) = alphaPanels * inputT(1,1) * A_disk + constantHeat ;

% create the arrays used to store the average surfaces
% area covered by solar cells
surfaceSA = zeros(size(inputT, 1), size(inputT, 2));
% solar panel area not covered by solar cells
surfaceSP = ones(size(inputT, 1), size(inputT, 2))*A_disk;

avgHpower = heat(1,1);

%% Temperature Computation 
for h = 2 : points
    % calculate the incoming heat power
    heat(1,h) = alphaPanels * inputT(1,h) * A_disk + constantHeat;
    
    % calculate the total heat and normalize to account for 50%
    % illumination over the orbit
    avgHpower = avgHpower + heat(1,h);
    
    surfaceSP(1,h) = A_sphere;
    
%     % subtract the heat radiated (Stefan Boltzman law) by the solar cells
%     heat(1,h) = heat(1,h) - A_sphere * sigma * epsilonSolarCells .* t(1:6, h - 1).^4;
    
    % subtract the heat radiated (Stefan Boltzman law) by the rest of the
    % solar panel area
    heat(1,h) = heat(1,h) - A_sphere * sigma * epsilonPanels .* t(1, h - 1).^4;

    % only take into account the lines that describe states (that also have
    % an incoming heat)
    b(1, h) = heat(1,h)*dt/hc + t(:,h - 1);     

%     states = max(0, SolverMatrix \ b(:,h));
    
    t(1, h) = b(1,h) ;
end

%% Graphs


range = 1:size(t, 2);

plotAverage = mean(t(1,range))+T0

avgHpower = avgHpower / points;
avgSurfaceSA = mean(sum(surfaceSA, 1));
avgSurfaceSP = mean(sum(surfaceSP, 1));
equilibriumT = ((avgHpower + constantHeat) / (epsilonPanels * avgSurfaceSP) / sigma)^(1/4) + T0

figure
plot(t(1,range)+T0-plotAverage+equilibriumT, 'LineWidth', 2)
grid on
legend('Sphere');
title('Thermal Simulation for a single node satellite')
xlabel('Time - s')
ylabel('Temperature - degC')
axis tight