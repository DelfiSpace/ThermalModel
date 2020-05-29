function VF = ViewFactor_perso(h,eta)

% Computing the view factor for a face oriented of eta compared to the
% local zenith, valid for the case of Earth 
% h = altitude of the satellite (m)
% eta = angle between the normal to the surface and the local zenith (rad)
% (0<=eta<=pi)

Re = 6371E3 ; % m
r = Re/(Re+h) ;
e = -160.31*r^6+723.36*r^5-1380*r^4+1394.6*r^3-780.65*r^2+226.81*r-21.232 ;

VF = r^2.1*(sin(eta/2)).^e ;

end