% Load the illumination data from files

% folder where to load the files
folder = 'FUNcube';

% sun vectors calculated using SPENVIS
% these files take into accout the orbital dynamics part and
% provide the amount of power received from the sun and the Earth albedo
% on a reference system aligned with the velocity vector (Z+ axis)
% and the zenith (X+ axis)
x = readSPENVISilo(sprintf('%s/X+.txt', folder));
xm = readSPENVISilo(sprintf('%s/X-.txt', folder));
y = readSPENVISilo(sprintf('%s/Y+.txt', folder));
ym = readSPENVISilo(sprintf('%s/Y-.txt', folder));
z = readSPENVISilo(sprintf('%s/Z+.txt', folder));
zm = readSPENVISilo(sprintf('%s/Z-.txt', folder));

% combine all the inputs in a matric to simplify calculations
% Columns description:
% 1 -> Sunlight / Shadow Flag
% 2 -> Direct Illumination - W / m^2
% 3 -> Earth IR Radiation - W / m^2
% 4 -> Albedo Radiation - W / m^2
% 5 -> Total Radiation - W / m/2
% 6 -> Earth ShadowAngle - deg
% 7 -> Solar Zenith Angle - deg
% 8 -> Angle Normal-Zenith - deg
% 9 -> Angle Normal-Sun - deg
inputE1 = [ x(:,2)' + x(:,4)'; xm(:,2)' + xm(:,4)'; 
            y(:,2)' + y(:,4)'; ym(:,2)' + ym(:,4)'; 
            z(:,2)' + z(:,4)'; zm(:,2)' + zm(:,4)'; ];
inputT1 = [ x(:,5)'; xm(:,5)'; 
            y(:,5)'; ym(:,5)'; 
            z(:,5)'; zm(:,5)'; ];
      
% resample the input matrix to have 1 point every second
inputE = interp2(inputE1,linspace(1, size(inputE1, 2), 60 * size(inputE1, 2)), (1:size(inputE1, 1))');
inputT = interp2(inputT1,linspace(1, size(inputT1, 2), 60 * size(inputT1, 2)), (1:size(inputT1, 1))');

% time step in seconds
dt = 1;
