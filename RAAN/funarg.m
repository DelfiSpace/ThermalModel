%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2012, David Eagle
% All rights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [el, elprim, f, d, omega] = funarg (t)

% this function computes fundamental arguments (mean elements)
% of the sun and moon.  see seidelmann (1982) celestial
% mechanics 27, 79-106 (1980 iau theory of nutation).

%      t      = tdb time in julian centuries since j2000.0 (in)
%      el     = mean anomaly of the moon in radians
%               at date tjd (out)
%      elprim = mean anomaly of the sun in radians
%               at date tjd (out)
%      f      = mean longitude of the moon minus mean longitude
%               of the moon's ascending node in radians
%               at date tjd (out)
%      d      = mean elongation of the moon from the sun in
%               radians at date tjd (out)
%      omega  = mean longitude of the moon's ascending node
%               in radians at date tjd (out)

% Orbital Mechanics with Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seccon = 206264.8062470964;

rev = 1296000;

% compute fundamental arguments in arcseconds

arg(1) = ((+0.064 * t + 31.310) * t + 715922.633) * t ...
         + 485866.733 + mod(1325.0 * t, 1.0) * rev;
      
arg(1) = mod(arg(1), rev);

arg(2) = ((-0.012 * t - 0.577) * t + 1292581.224) * t ...
         + 1287099.8040 + mod(99.0 * t, 1.0) * rev;
      
arg(2) = mod(arg(2), rev);

arg(3) = ((+0.011 * t - 13.257) * t + 295263.137) * t ...
         + 335778.877 + mod(1342.0 * t, 1.0) * rev;
      
arg(3) = mod(arg(3), rev);

arg(4) = ((+0.019 * t - 6.891) * t + 1105601.328) * t ...
         + 1072261.307 + mod(1236.0 * t, 1.0) * rev;
      
arg(4) = mod(arg(4), rev);

arg(5) = ((0.008 * t + 7.455) * t - 482890.539) * t ...
         + 450160.280  - mod(5.0 * t, 1.0) * rev;
      
arg(5) = mod(arg(5), rev);

% convert arguments to radians

for i = 1:1:5
    arg(i) = mod(arg(i), rev);

    if (arg(i) < 0.0)
       arg(i) = arg(i) + rev;
    end

    arg(i) = arg(i) / seccon;
end

el     = arg(1);
elprim = arg(2);
f      = arg(3);
d      = arg(4);
omega  = arg(5);

