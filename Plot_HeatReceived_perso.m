
close all
teta = 0:2*pi/1000:2*pi ;
beta = -60*pi/180 ;
h = 408E3 ;

% eta = pi ; % nadir facing plate 
% eta = 0 ; % zenith facing plate
% eta = pi/2 ; % forward facing plate
% eta = 3*pi/2 ; % aft facing plate

% Nadir facing plate
% pol = pi/2 ;
% azi = pi ;
% Zenith facing plate
% pol = pi/2 ;
% azi = 0 ;
%Forward facing plate
% pol = 0 ;
% azi = 0 ;
% Aft facing plate
% pol = pi ;
% azi = 0 ;
% North facing plate
pol = pi/2 ; 
azi = 3*pi/2 ;

eta = acos(cos(azi)*sin(pol)) ;

Fpla = zeros(1,length(teta));
Falb = zeros(1,length(teta));
Fs = zeros(1,length(teta));

for i=1:length(teta)
    [temp1,temp2,temp3] = HeatReceived_perso(94,beta,teta(1,i),h,pol,azi,0.3);
    Fpla(i)=temp1;
    Falb(i)=temp2;
    Fs(i)=temp3;
end

plot(teta*180/pi,Fpla, 'LineWidth',2)
hold on
plot(teta*180/pi,Falb, 'LineWidth',2)
plot(teta*180/pi,Fs,'LineWidth',2)

% Validation for beta=0 and nadir facing plate
% tetaTest = [0 30 60 90 95 100 110 180 250 260 265 270 300 330 360] ;
% FplaTest = [210] ;
% FalbTest = [360 320 180 0 0 0 0 0 0 0 0 0 180 320 360] ;
% FsTest = [0 0 0 0 100 220 460 0 460 220 100 0 0 0 0] ;
% plot(tetaTest, FalbTest, 'r*', 'LineWidth',1.7)
% plot(tetaTest, FsTest, 'k*', 'LineWidth',1.7)
% plot([180], FplaTest, 'b*', 'LineWidth',1.7)

% Validation for beta=60 and nadir facing plate
% tetaTest = [0 30 60 90 100 110 120 132 180 228 240 250 260 270 300 330 360];
% FplaTest = [210];
% FalbTest = [180 150 90 0 0 0 0 0 0 0 0 0 0 0 90 150 180];
% FsTest = [0 0 0 0 100 220 350 470 0 470 350 220 100 0 0 0 0] ; 
% plot(tetaTest, FalbTest, 'r*', 'LineWidth',1.7)
% plot(tetaTest, FsTest, 'k*', 'LineWidth',1.7)
% plot([180], FplaTest, 'b*', 'LineWidth',1.7)

% Validation for beta=0 and forward facing plate
% tetaTest = [0 30 60 90 250 270 300 330 360];
% FplaTest = [70];
% FalbTest = [110 100 50 0 0 0 50 100 110];
% FsTest = [0 0 0 0 1295 1370 1190 680 0] ; 
% plot(tetaTest, FalbTest, 'r*','LineWidth',1.7)
% plot(tetaTest, FsTest, 'k*','LineWidth',1.7)
% plot([180], FplaTest, 'b*', 'LineWidth',1.7)

% Validation for beta=-60° and north facing plate
tetaTest = [0 90 130 180 230 270 360];
FplaTest = [60];
FalbTest = [55 0 0 0 0 0 55];
FsTest = [1185 1185 1185 0 1185 1185 1185] ; 
plot(tetaTest, FalbTest, 'r*', 'LineWidth',1.7)
plot(tetaTest, FsTest, 'k*', 'LineWidth',1.7)
plot([180], FplaTest, 'b*', 'LineWidth',1.7)

title('\fontsize{20}Incident Heat on an oriented plate')
xlabel('\fontsize{14}Orbit angle from solar noon (°)')
ylabel('\fontsize{14}Incident Heating Flux (W/m^2)')
legend('\fontsize{12}Earth IR', '\fontsize{12}Albedo', '\fontsize{12}Solar radiation',...
    '\fontsize{12}Reference Value for Albedo ([6])','\fontsize{12}Reference Value for Solar Flux ([6])',...
    '\fontsize{12}Reference Value for Earth IR radiation ([6])')
str = {'beta=' beta*180/pi, 'Polar angle=' pol*180/pi, 'Azimuthal angle=',azi*180/pi} ;
annotation('textbox',[.2 .5 .4 .4],'String',str,'FitBoxToText','on');
hold off
