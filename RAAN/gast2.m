%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2012, David Eagle
% All rights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gst = gast2 (tjdh, tjdl, k)

% this function computes the greenwich sidereal time
% (either mean or apparent) at julian date tjdh + tjdl

% nutation parameters from function nod

% input

%  tjdh = julian date, high-order part

%  tjdl = julian date, low-order part

%         julian date may be split at any point, but for
%         highest precision, set tjdh to be the integral part of
%         the julian date, and set tjdl to be the fractional part

%  k    = time selection code
%         set k=0 for greenwich mean sidereal time
%         set k=1 for greenwich apparent sidereal time

% output

%  gst = greenwich (mean or apparent) sidereal time in hours

% Orbital Mechanics with Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seccon = 206264.8062470964;

t0 = 2451545.0;

tjd = tjdh + tjdl;
th = (tjdh - t0) / 36525;
tl = tjdl / 36525.0;
t = th + tl;
t2 = t * t;
t3 = t2 * t;

% for apparent sidereal time, obtain equation of the equinoxes

eqeq = 0.0;

if (k == 1)
    
   % obtain nutation parameters in seconds of arc

   [psi, eps] = nod(tjd);

   % compute mean obliquity of the ecliptic in seconds of arc

   obm = 84381.4480 - 46.8150 * t - 0.00059 * t2 + 0.001813 * t3;

   % compute true obliquity of the ecliptic in seconds of arc

   obt = obm + eps;

   % compute equation of the equinoxes in seconds of time

   eqeq = psi / 15.0 * cos (obt / seccon);

end

st = eqeq - 6.2e-6 * t3 + 0.093104 * t2 + 67310.54841 ...
     + 8640184.812866 * tl + 3155760000 * tl ...
     + 8640184.812866 * th + 3155760000 * th;

gst = mod(st / 3600.0, 24.0);

if (gst < 0.0)
    
   gst = gst + 24;
   
end

