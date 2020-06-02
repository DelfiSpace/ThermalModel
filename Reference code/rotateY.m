% Rotates the input array around the Y-axis counter-clockwise by angle (in
% degrees).
function out = rotateY(input, angle)
    if (size(input, 2) ~= 6)
        error('The input array should be 1 row by 6 columns ([X+ X- Y+ Y- Z+ Z-])')
    end
    if (length(angle) ~= 1)
        error('Angle should be a scalar number')
    end
    ty = angle / 180 * pi;
    
    % rotation matrix around Y
    Ry = [
         max(0, cos(ty))  -min(0, cos(ty))  0 0 -min(0, sin(ty))  max(0, sin(ty));
        -min(0, cos(ty))   max(0, cos(ty))  0 0  max(0, sin(ty)) -min(0, sin(ty));
         0                 0                1 0  0                0;
         0                 0                0 1  0                0;
         max(0, sin(ty))  -min(0, sin(ty))  0 0  max(0, cos(ty)) -min(0, cos(ty));
        -min(0, sin(ty))   max(0, sin(ty))  0 0 -min(0, cos(ty))  max(0, cos(ty));
        ];
    out = input * Ry;
end