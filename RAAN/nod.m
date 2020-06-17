%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2012, David Eagle
% All rights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dpsi, deps] = nod(jdate)

% this function evaluates the nutation series and returns the
% values for nutation in longitude and nutation in obliquity.
% wahr nutation series for axis b for gilbert & dziewonski earth
% model 1066a. see seidelmann (1982) celestial mechanics 27,
% 79-106. 1980 iau theory of nutation.

% jdate = tdb julian date (in)
% dpsi  = nutation in longitude in arcseconds (out)
% deps  = nutation in obliquity in arcseconds (out)

% NOTE: requires first time initialization via inutate flag

% Orbital Mechanics with Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global inutate xnod
inutate = 1 ;
if (inutate == 1)
   % read coefficient data file
   
   xnod = csvread('nut80.csv');
   
   inutate = 0;
end

% time argument in julian centuries

tjcent = (jdate - 2451545.0) / 36525.0;

% get fundamental arguments

[l, lp, f, d, om] = funarg (tjcent);

% sum nutation series terms, from smallest to largest

dpsi = 0.0d0;

deps = 0.0d0;

for j = 1:1:106
    
    i = 107 - j;
    
    % formation of multiples of arguments
    
    arg = xnod(i, 1) * l + xnod(i, 2) * lp + xnod(i, 3) * f ...
          + xnod(i, 4) * d + xnod(i, 5) * om;
    
    % evaluate nutation

    dpsi = (xnod(i, 6) + xnod(i, 7) * tjcent) * sin(arg) + dpsi;
    
    deps = (xnod(i, 8) + xnod(i, 9) * tjcent) * cos(arg) + deps;
    
end

dpsi = dpsi * 1.0d-4;

deps = deps * 1.0d-4;




