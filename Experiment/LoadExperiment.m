% Computes the illumination data for the experiment: 10min illumination of
% one face : X+

teta1 = 1:(3600+12*60+11) ; %for 1h12min11s of experiment

% Time step in second
dt = 1 ; 

% Lamp radiation
inputE = zeros(6,length(teta1)) ;
inputT = [ones(1,length(teta1)) ; zeros(5,length(teta1)) ] ;

%Form_factor = [8.6e-4*ones(26*60+35,1) ; 1.94e-3*ones(28*60+29,1) ; 3.2e-3*ones(17*60+9,1) ];
%Form_factor = 8.5e-1 *[1.2e-3*ones(26*60+35,1) ; 2.1e-3*ones(28*60+29,1) ; 2.7e-3*ones(17*60+9,1) ];
Form_factor = 7.5e-1 *[1.30e-3*ones(26*60+35,1) ; 2.2e-3*ones(28*60+29,1) ; 2.75e-3*ones(17*60+9,1) ];
