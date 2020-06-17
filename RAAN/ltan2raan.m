%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2012, David Eagle
% All rights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function raan = ltan2raan (jdate, mltan, ttype)

% convert local time of the ascending node (LTAN)
% to right ascension of the ascending node (RAAN)

% input

%  jdate = UTC Julian date
%  mltan = local time of ascending node (hours)
%  ttype = type of solar hour angle calculation (1 = mean, 2 = apparent)

% output

%  raan = right ascension of the ascending node (radians)
%         (0 <= raan <= 2 pi)

% Orbital Mechanics with Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global eot rasc_ts rasc_ms rsun

pi2 = 2.0 * pi;

% conversion factors

dtr = pi / 180.0;

atr = dtr / 3600.0;

% compute apparent right ascension of the sun (radians)

[rasc_ts, decl, rsun] = sun2 (jdate);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% equation of time (radians)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mean longitude of the sun (radians)

t = (jdate - 2451545) / 365250;

t2 = t * t;

t3 = t * t * t;

t4 = t * t * t * t;

t5 = t * t * t * t * t;

l0 = dtr * mod(280.4664567 + 360007.6982779 * t + 0.03032028 * t2 ...
    + t3 / 49931.0 - t4 / 15299.0 - t5 / 1988000.0, 360.0);

% nutations

[psi, eps] = nod(jdate);

% compute mean obliquity of the ecliptic in radians

t = (jdate - 2451545.0) / 36525.0;

t2 = t * t;

t3 = t2 * t;

obm = atr * (84381.4480 - 46.8150 * t - 0.00059 * t2 + 0.001813 * t3);

% compute true obliquity of the ecliptic in radians

obt = obm + atr * eps;

eot = l0 - dtr * 0.0057183 - rasc_ts + atr * psi * cos(obt);

% right ascension of the mean sun (radians)

rasc_ms = mod(rasc_ts + eot, pi2);

% right ascension of the ascending node (radians)

if (ttype == 1)
    
    % based on local mean solar time
    
    raan = mod(rasc_ms + dtr * 15.0 * (mltan - 12.0), pi2);
    
else
    
    % based on local apparent solar time
    
    raan = mod(rasc_ts + dtr * 15.0 * (mltan - 12.0), pi2);
    
end




