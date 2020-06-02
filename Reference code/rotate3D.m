% Rotates the input argument around the X, Y and Z-axis counter-clockwise
function out = rotate3D(input, angleX, angleY, angleZ)
%angleZ = 0;

% create a canonical euler angle for internal use
angleY = rem(angleY, 360);
if (angleY > 180.0)
    angleY = angleY - 360.0;
end

angleZ = rem(angleZ, 360);
if (angleZ > 180.0)
    angleZ = angleZ - 360.0;
end

    out = rotateZ(rotateX(rotateY(input, angleZ), angleY), angleX);
    %out = rotateX(rotateY(input, angleY), angleX);

end