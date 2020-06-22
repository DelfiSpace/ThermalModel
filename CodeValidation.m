
% Validation of the Thermal Budget code 
close all
% Loading data for funcube
out=readTemperatureData('wod2016-02-10.csv');

BlackChassis = out{1,2}' ;
% SilverChassis= out{1,3}' ;
BlackPanel = out{1,4}' ;
% SilverPanel= out{1,5}' ;
X = out{1,6}' ;
Xm= out{1,7}' ;
Y = out{1,8}' ;
Ym= out{1,9}' ;

time = 0:60:60*(length(X)-1) ; % One measure every minute

graphsize = 1:500 ;

plot(time(graphsize),BlackChassis(graphsize), 'LineWidth', 2)
hold on 
% plot(time(graphsize),SilverChassis(graphsize),'r', 'LineWidth', 2)
plot(time(graphsize),BlackPanel(graphsize), 'g', 'LineWidth', 2)
% plot(time(graphsize),SilverPanel(graphsize), 'm', 'LineWidth', 2)
plot(time(graphsize),Xm(graphsize), 'k:', 'LineWidth', 2)
plot(time(graphsize),Y(graphsize), 'b:', 'LineWidth', 2)
plot(time(graphsize),Ym(graphsize), 'r:', 'LineWidth', 2)
plot(time(graphsize),X(graphsize), 'c:', 'LineWidth', 2)
plot(t(1,1:30000)+T0, 'm', 'LineWidth', 2) % X simulation
grid on
legend('Black Chassis', 'Black Panel', 'X-', 'Y', 'Y-', 'X', 'X simulation') 
title('Temperature measurements for FUNcube (02/04/2016) VS Computed Temperature for X panel')
xlabel('Time - s')
ylabel('Temperature - degC')
axis tight

