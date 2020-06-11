function [New_pol,New_azi] = Rotation(pol, azi, spinX, spinY, spinZ)

% Computes the new spherical coordinates for the normal to a surface after
% a rotation around X-axis counter-clockwise by spinX, a rotation around 
% Y-axis counter-clockwise by spinY, and a rotation around Z-axis
% counter-clockwise by spinZ (all angles in radian)

% Rx = rotx(spinX *180/pi) ;
% Ry = roty(spinY *180/pi) ;
% Rz = rotz(spinZ *180/pi) ; %Takes too much time
Rx = [1 0 0 ; 0 cos(spinX) -sin(spinX) ; 0 sin(spinX) cos(spinX)] ;
Ry = [cos(spinY) 0 sin(spinY) ; 0 1 0 ; -sin(spinY) 0 cos(spinY)] ;
Rz = [cos(spinZ) -sin(spinZ) 0 ; sin(spinZ) cos(spinZ) 0 ; 0 0 1] ;

nx = sin(pol)*cos(azi) ;
ny = sin(pol)*sin(azi) ;
nz = cos(pol) ;

New_n = Rz*Ry*Rx * [nx ; ny ; nz] ;
New_pol = acos(New_n(3,1)) ;

if New_pol == 0 || New_pol == pi
    New_azi = 0 ;
else
    c = real(acos(New_n(1,1)/sin(New_pol))) ;
    s = real(asin(New_n(2,1)/sin(New_pol))) ;
    if c>=0 && c<=pi/2 && s>=0 && s<=pi/2
        New_azi = c ;
    elseif c>pi/2 && c<=pi && s>=0 && s<=pi/2
        New_azi = c ;
    elseif c>=0 && c<=pi/2 && s>=-pi/2 && s<0
        New_azi = s ;
    elseif c>pi/2 && c<=pi && s>=-pi/2 && s<0
        New_azi = -c+2*pi ;
    end
end


end