% Rotates the input array around the Z-axis counter-clockwise by angle (in
% degrees).
function out = rotateZ(input, angle)
    if (size(input, 2) ~= 6)
        error('The input array should be 1 row by 6 columns ([X+ X- Y+ Y- Z+ Z-])')
    end
    if (length(angle) ~= 1)
        error('Angle should be a scalar number')
    end
    tz = angle / 180 * pi;

    % rotation matrix around Z
    Rz = [
         max(0, cos(tz)) -min(0, cos(tz)) -min(0, sin(tz))  max(0, sin(tz)) 0 0;
        -min(0, cos(tz))  max(0, cos(tz))  max(0, sin(tz)) -min(0, sin(tz)) 0 0;
         max(0, sin(tz)) -min(0, sin(tz))  max(0, cos(tz)) -min(0, cos(tz)) 0 0;
        -min(0, sin(tz))  max(0, sin(tz)) -min(0, cos(tz))  max(0, cos(tz)) 0 0;
         0                0                0                0               1 0;
         0                0                0                0               0 1;
        ];
    out = input * Rz;
end