%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2012, David Eagle
% All rights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rasc, decl, rsun] = sun2 (jdate)

% precision ephemeris of the Sun

% input
    
%  jdate = julian ephemeris date

% output

%  rasc = right ascension of the Sun (radians)
%         (0 <= rasc <= 2 pi)
%  decl = declination of the Sun (radians)
%         (-pi/2 <= decl <= pi/2)
%  rsun = eci position vector of the Sun (km)

% note

%  coordinates are inertial, geocentric,
%  equatorial and true-of-date

% Orbital Mechanics with Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global suncoef sdata rlsun

if (suncoef == 1)
   
   sdata = [403406;      0; 4.721964;      1.621043;
            195207; -97597; 5.937458;  62830.348067;
            119433; -59715; 1.115589;  62830.821524;
            112392; -56188; 5.781616;  62829.634302;
              3891;  -1556; 5.5474  ; 125660.5691;
              2819;  -1126; 1.5120  ; 125660.9845;
              1721;   -861; 4.1897  ;  62832.4766;
                 0;    941; 1.163   ;      0.813;
               660;   -264; 5.415   ; 125659.310;
               350;   -163; 4.315   ;  57533.850;
               334;      0; 4.553   ;    -33.931;
               314;    309; 5.198   ; 777137.715;
               268;   -158; 5.989   ;  78604.191;
               242;      0; 2.911   ;      5.412;
               234;    -54; 1.423   ;  39302.098;
               158;      0; 0.061   ;    -34.861;
               132;    -93; 2.317   ; 115067.698;
               129;    -20; 3.193   ;  15774.337;
               114;      0; 2.828   ;   5296.670;
                99;    -47; 0.52    ;  58849.27;
                93;      0; 4.65    ;   5296.11;
                86;      0; 4.35    ;  -3980.70;
                78;    -33; 2.75    ;  52237.69;
                72;    -32; 4.50    ;  55076.47;
                68;      0; 3.23    ;    261.08;
                64;    -10; 1.22    ;  15773.85;
                46;    -16; 0.14    ; 188491.03;
                38;      0; 3.44    ;  -7756.55;
                37;      0; 4.37    ;    264.89;
                32;    -24; 1.14    ; 117906.27;
                29;    -13; 2.84    ;  55075.75;
                28;      0; 5.96    ;  -7961.39;
                27;     -9; 5.09    ; 188489.81;
                27;      0; 1.72    ;   2132.19;
                25;    -17; 2.56    ; 109771.03;
                24;    -11; 1.92    ;  54868.56;
                21;      0; 0.09    ;  25443.93;
                21;     31; 5.98    ; -55731.43;
                20;    -10; 4.03    ;  60697.74;
                18;      0; 4.27    ;   2132.79;
                17;    -12; 0.79    ; 109771.63;
                14;      0; 4.24    ;  -7752.82;
                13;     -5; 2.01    ; 188491.91;
                13;      0; 2.65    ;    207.81;
                13;      0; 4.98    ;  29424.63;
                12;      0; 0.93    ;     -7.99;
                10;      0; 2.21    ;  46941.14;
                10;      0; 3.59    ;    -68.29;
                10;      0; 1.50    ;  21463.25;
                10;     -9; 2.55    ; 157208.40];
   suncoef = 0;          
end

% extract data and load arrays

sl(1:1:50) = sdata(1:4:200);
sr(1:1:50) = sdata(2:4:200);
sa(1:1:50) = sdata(3:4:200);
sb(1:1:50) = sdata(4:4:200);

% fundamental time argument
          
u = (jdate - 2451545) / 3652500;

% compute nutation in longitude

a1 = 2.18 + u * (-3375.7 + u * 0.36);
a2 = 3.51 + u * (125666.39 + u * 0.1);
   
psi = 0.0000001 * (-834 * sin(a1) - 64 * sin(a2));

% compute nutation in obliquity

deps = 0.0000001 * u * (-226938 + u * (-75 + u * (96926 + ...
       u * (-2491 - u * 12104))));

meps = 0.0000001 * (4090928 + 446 * cos(a1) + 28 * cos(a2));
   
eps = meps + deps;
   
seps = sin(eps);
ceps = cos(eps);

dl = 0;
dr = 0;

for i = 1:1:50
    w = sa(i) + sb(i) * u;
    dl = dl + sl(i) * sin(w);
    if (sr(i) ~= 0)
       dr = dr + sr(i) * cos(w);
    end    
end

dl = mod(dl * 0.0000001 + 4.9353929 + 62833.196168 * u, 2.0 * pi);
   
dr = 149597870.691 * (dr * 0.0000001 + 1.0001026);

% geocentric ecliptic position vector of the Sun

rlsun = mod(dl + 0.0000001 * (-993 + 17 * cos(3.1 + 62830.14 * u)) + psi, 2.0 * pi);

rb = 0;

% compute declination and right ascension

cl = cos(rlsun);
sl = sin(rlsun);
cb = cos(rb);
sb = sin(rb);

decl = asin(ceps * sb + seps * cb * sl);

sra = -seps * sb + ceps * cb * sl;
cra = cb * cl;

rasc = atan3(sra, cra);

% geocentric equatorial position vector of the Sun

rsun(1) = dr * cos(rasc) * cos(decl);
rsun(2) = dr * sin(rasc) * cos(decl);
rsun(3) = dr * sin(decl);


