function h = h_conv(DT, L)

% Computes the heat transfer coefficient

rho     = 1.292 ; %kg/m^3
beta    = 1/(20+273.15) ; %K^-1
g       = 9.81 ; %m/s^2
eta     = 1.85e-5 ; %kg/m.s
alpha   = 2e-5 ; %m^2/s^1
Cp      = 1004 ; %J/K.kg
mu      = 1.85e-5 ; %kg/m.s
k       = 0.026 ; %W/m.K

% Rayleigh number
Ra = rho*beta*DT*L.^3*g / (eta*alpha); 

% Prandtl number
Pr = Cp*mu/k ;

% h
h = k./L * ( 0.68 + (0.67*Ra.^(1/4))/(1+(0.492/Pr)^(9/16))^(4/9)) ; %W.m^-2.K^-1

end