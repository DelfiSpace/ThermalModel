% Rotates the input array around the X-axis counter-clockwise by angle (in
% degrees).
function out = rotateX(input, angle)
    if (size(input, 2) ~= 6)
        error('The input array should be 1 row by 6 columns ([X+ X- Y+ Y- Z+ Z-])')
    end
    if (length(angle) ~= 1)
        error('Angle should be a scalar number')
    end
    tx = angle / 180 * pi;

    % rotation matrix around X
    Rx = [
        1 0  0                0                 0                 0;
        0 1  0                0                 0                 0;
        0 0  max(0, cos(tx)) -min(0, cos(tx))  -min(0, sin(tx))   max(0, sin(tx));
        0 0 -min(0, cos(tx))  max(0, cos(tx))   max(0, sin(tx))  -min(0, sin(tx));
        0 0  max(0, sin(tx)) -min(0, sin(tx))   max(0, cos(tx))  -min(0, cos(tx));
        0 0 -min(0, sin(tx))  max(0, sin(tx))  -min(0, cos(tx))   max(0, cos(tx));
    ];
    out = input * Rx;
end