%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2012, David Eagle
% All rights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mltan.m       November 13, 2012

% conversion to/from mean local time of the ascending node (MLTAN)
% and right ascension of the ascending node (RAAN)

% precision solar ephemeris
% Meeus equation-of-time algorithm

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

global suncoef inutate eot rasc_ms

% initialize solar ephemeris

suncoef = 1;

% initialize nutation algorithm

inutate = 1;

% conversion constants

pi2 = 2.0 * pi;

dtr = pi / 180.0;

rtd = 180.0 / pi;

clc; home;

fprintf('\n\nMLTAN/RAAN relationship')
fprintf('\n-----------------------\n');

% request type of conversion

while (1)
    
    fprintf('\nplease select the type of conversion\n');
    
    fprintf('\n <1> MLTAN to RAAN\n');
    
    fprintf('\n <2> RAAN to MLTAN\n');
    
    fprintf('\nselection (1 or 2)\n');
    
    choice = input('? ');
    
    if (choice >= 1 && choice <= 2)
        
        break;
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% request ascending node UTC epoch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n\nascending node UTC epoch\n');

[month, day, year] = getdate;

[utc_an_hr, utc_an_min, utc_an_sec] = gettime;

dday = utc_an_hr / 24 + utc_an_min / 1440 + utc_an_sec / 86400.0;

% julian date of ascending node crossing

jdate_an = julian(month, day + dday, year);

[cdstr_an, utstr_an] = jd2str(jdate_an);

% greenwich apparent sidereal time at ascending node

gast_an = gast2 (jdate_an, 0.0, 1);

if (choice == 1)
    
    %%%%%%%%%%%%%%%
    % mltan to raan
    %%%%%%%%%%%%%%%
    
    [mltan_hr, mltan_min, mltan_sec] = getmltan;
    
    mltan_an = mltan_hr + mltan_min / 60.0 + mltan_sec / 3600.0;
    
    % compute raan from mltan
    
    raan = mltan2raan (jdate_an, mltan_an);
    
    dday = mltan_an / 24.0;
    
    % working julian date
    
    jdate_wrk = julian(month, day + dday, year);
    
    [cdstr_wrk, utstr_wrk] = jd2str(jdate_wrk);
    
else
    
    % raan to mltan
    
    while(1)
        
        fprintf('\nplease input the RAAN (degrees)');
        
        raan = input('? ');
        
        if (raan >= 0 && raan <= 360)
            
            break;
            
        end
    end
    
    raan = dtr * raan;
    
    mltan_an = raan2mltan (jdate_an, raan);
    
    dday = mltan_an / 24.0;
    
    % working julian date
    
    jdate_wrk = julian(month, day + dday, year);
    
    [cdstr_wrk, utstr_wrk] = jd2str(jdate_wrk);
    
end

% east longitude of the ascending node

elan = mod(raan - 2.0 * pi * gast_an / 24.0, 2 * pi);

% print results

if (choice == 1)
    
    fprintf('\n\nMLTAN to RAAN conversion\n');
    
else
    
    fprintf('\n\nRAAN to MLTAN conversion\n');
    
end

fprintf('\nascending node calendar date             ');

disp(cdstr_an);

fprintf('\nascending node universal time            ');

disp(utstr_an);

fprintf('\nmean local time of the ascending node    ');

disp(utstr_wrk);

fprintf('\nright ascension of the ascending node  %12.6f degrees\n', rtd * raan);

fprintf('\neast longitude of the ascending node   %12.6f degrees\n', rtd * elan);

fprintf('\nright ascension of the mean sun        %12.6f degrees\n', rtd * rasc_ms);

fprintf('\nGreenwich apparent sidereal time       %12.6f degrees\n', 360.0 * gast_an / 24.0);

fprintf('\nequation of time                       %12.6f minutes\n\n', 4.0 * rtd * eot);






