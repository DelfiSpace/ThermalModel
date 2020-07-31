% Thermal budget simulator for the experiment: Y- face heated by a lamp in
% a room (radiation + convection)
%
% Author: Stefano Speretta <s.speretta@tudelft.nl> 
%
% close all
clearvars
clc

%% Initialisation

% load physical constants needed for simulation
constants_perso;

% load illumination profile 
LoadExperiment

% load satellite configuration
DelfiPQ_experiment

spinX = 0; % degrees/second
spinY = 0; % degrees/second
spinZ = 0; % degrees/second

constantHeat = [0 ; 0]; 

points = size(inputE, 2);

t0 = 24.6 - T0 ; %for the experiment
t_outside = ones(Nface,1) ; %for the experiment
t_outside(1:end,1) = 24.6-T0 ;
t_lamp = (3200-T0) * ones(1,Nface/6) ;

b = zeros(size(SolverMatrix, 2), points);
states = zeros(size(SolverMatrix, 1), points);

t = zeros(length(hc), points);
t(:,1) = t0;
t(Nface+1,1) = 24.6-T0; %for the experiment

% 3-axis rotation angles (all initialized to 0)
xAngle = 0;
yAngle = 0;
zAngle = 0;

% heat per simulation node
heat = zeros(length(hc), points);

%heat(1:Nface, 1) =    alphaSolarCells * FitNumberNode(inputT(:, 1), Nface)' .* sa ...
%                + alphaPanels * FitNumberNode(inputT(:, 1), Nface)' .* panelarea;

%heat(7:7+length(constantHeat)-1,:) = constantHeat(:,1).* ones(length(constantHeat),size(heat,2)) ;

% create the arrays used to store the average surfaces
% area covered by silar cells
surfaceSA = zeros(size(inputE, 1), size(inputE, 2));
% solar panel area not covered by solar cells
surfaceSP = zeros(size(inputE, 1), size(inputE, 2));

avgHpower = sum(heat(1:Nface, 1));

%% Temperature Computation 
for h = 2 : points
    % calculate the incoming heat power
%     heat(1:Nface, h) =    alphaSolarCells * FitNumberNode(inputT(:, h), Nface)' .*  sa ...
%                     + alphaPanels * FitNumberNode(inputT(:, h), Nface)' .* panelarea;
    
%     heat(1:Nface/6, h) = sigma * alphaSolarCells * (t_lamp.^4 - t(1:Nface/6).^4) * Form_factor(h,1) .*sa(1:Nface/6) ...
%                       + sigma * alphaPanels * (t_lamp.^4 - t(1:Nface/6).^4) * Form_factor(h,1) .* panelarea(1:Nface/6);
    %emissivity of thungsten : 0.35
    heat(16:20, h) = sigma * alphaSolarCells*0.35 * (t_lamp.^4 - t(16:20).^4) * Form_factor(h,1) .*sa(16:20) ...
                      + sigma * alphaPanels*0.35 * (t_lamp.^4 - t(16:20).^4) * Form_factor(h,1) .* panelarea(16:20);
    
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
    heat(1:Nface,h) = heat(1:Nface,h) - sa' * sigma * epsilonSolarCells .* (t(1:Nface, h - 1).^4 - t_outside.^4);
    
    % subtract the heat radiated (Stefan Boltzman law) by the rest of the
    % solar panel area
    heat(1:Nface,h) = heat(1:Nface,h) - panelarea' * sigma * epsilonPanels .* (t(1:Nface, h - 1).^4 - t_outside.^4);
    
    % air convection
%     heat_coef = h_conv( abs(t(1:Nface,h-1)-t_outside) , 0.178) ; %heat transfer coefficient
    heat_coef = [25*ones(5,1) ; 15*ones(25,1)] ;
    heat(1:Nface,h) = heat(1:Nface,h) + heat_coef .* sa' .* (t_outside - t(1:Nface, h - 1)) ;
    heat(1:Nface,h) = heat(1:Nface,h) + heat_coef .* panelarea' .* (t_outside - t(1:Nface, h - 1)) ;
    
%     % air conduction
%     heat(1:Nface,h) = heat(1:Nface,h) + 0.026 .* sa' .* (t_outside - t(1:Nface, h - 1)) / 1 ;
%     heat(1:Nface,h) = heat(1:Nface,h) + 0.026 .* panelarea' .* (t_outside - t(1:Nface, h - 1)) / 1 ;

    % only take into account the lines that describe states (that also have
    % an incoming heat)
    b(1:length(hc), h) = heat(:,h) +  hc(:) / dt .* t(:,h - 1);     

    states = max(0, SolverMatrix \ b(:,h));
    
    % the first states are temperatures, the others are fluxes
    t(:, h) = states(1:length(hc));
end

%% Graphs

range = 1:size(t, 2);

Delta_T = t(1,end) - t(6,end)

plotAverage = mean(t(Nface+1,range))+T0;

avgHpower = avgHpower / points;
avgSurfaceSA = mean(sum(surfaceSA, 1));
avgSurfaceSP = mean(sum(surfaceSP, 1));
equilibriumT = ((avgHpower + sum(constantHeat)) / (epsilonSolarCells * avgSurfaceSA + ...
    epsilonPanels * avgSurfaceSP) / sigma).^(1/4) + T0;

date = [] ;
for i=range
    h = 16 + floor((20*60+i+31)/3600) ;
    s = mod(31+i , 60) ;
    m = mod(20 + floor((i+31 - (h-16)*3600) / 60) , 60);
    ch_date = ['2020-07-17 ' num2str(h) ':' num2str(m) ':' num2str(s)] ;
    date = [date datetime(ch_date, 'InputFormat','yyyy-MM-dd HH:mm:ss')] ;
end

figure
plot(date,t(1,range)+T0, 'LineWidth', 2)
hold on
plot(date,t(1*Nface/6+1,range)+T0, 'r', 'LineWidth', 2)
plot(date,t(2*Nface/6+1,range)+T0, 'g', 'LineWidth', 2)
plot(date,t(3*Nface/6+1,range)+T0, 'k', 'LineWidth', 2)
%plot(date,t(4*Nface/6+1,range)+T0, 'm', 'LineWidth', 2)
%plot(date,t(5*Nface/6+1,range)+T0, 'c', 'LineWidth', 2)

% Compare with the telemetry
ReadTelemetry

date_exp = TelemetryEPS17072020(:,18) ;
x_exp = TelemetryEPS17072020(:,74) ;
xm_exp = TelemetryEPS17072020(:,59) ;
y_exp = TelemetryEPS17072020(:,19) ;
ym_exp = TelemetryEPS17072020(:,24) ;
date_exp = date_exp{:,1} ;
ym_exp = ym_exp{:,1} ;
y_exp = y_exp{:,1} ;
xm_exp = xm_exp{:,1} ;
x_exp = x_exp{:,1} ;

plot(date_exp,x_exp, 'b--', 'LineWidth', 1.5)
plot(date_exp,xm_exp, 'r--', 'LineWidth', 1.5)
plot(date_exp,y_exp, 'g--', 'LineWidth', 1.5)
plot(date_exp,ym_exp, 'k--', 'LineWidth', 1.5)

leg = {'X+'; 'X-'; 'Y+'; 'Y-'} ;
% legPayload = [] ;
% for i=1:length(constantHeat)
%     plot(date,t(Nface+i,range)+T0, '--', 'LineWidth', 2) %plot the payloads temperature
%     legPayload = [legPayload ; {['Payload',num2str(i)]}] ;
% end
grid on
%legend([leg; legPayload])
legend(leg)
title('\fontsize{20}Thermal Simulation VS Experiment')
xlabel('\fontsize{14}Time - s')
ylabel('\fontsize{14}Temperature - degC')


% figure
% hold on
% for i=1:5
%     plot(t(i,range)+T0, 'LineWidth', 2)
% end
% legend('1','2','3','4','5')
% 
% figure
% hold on
% for i=6:10
%     plot(t(i,range)+T0, 'LineWidth', 2)
% end
% legend('1','2','3','4','5')
% 
% figure
% hold on
% for i=11:15
%     plot(t(i,range)+T0, 'LineWidth', 2)
% end
% legend('1','2','3','4','5')
% 
% figure
% hold on
% for i=16:20
%     plot(t(i,range)+T0, 'LineWidth', 2)
% end
% legend('1','2','3','4','5')
% 
% figure
% hold on
% for i=21:25
%     plot(t(i,range)+T0, 'LineWidth', 2)
% end
% legend('1','2','3','4','5')
% 
% figure
% hold on
% for i=26:30
%     plot(t(i,range)+T0, 'LineWidth', 2)
% end
% legend('1','2','3','4','5')