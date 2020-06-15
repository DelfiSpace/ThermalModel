
% Plot the evolution of polar and azimuthal angles for given rotation rates

pol = zeros(1,1000);
azi = zeros(1,1000);

pol(1,1) = 0;
azi(1,1) = 0;

spinX = 0.1 ;
spinY = 0 ;
spinZ = 0 ;

for i=2:length(pol)
    [pol(1,i), azi(1,i)] = Rotation(pol(1,i-1), azi(1,i-1), spinX,spinY,spinZ) ;
end

subplot(2,1,1)
plot(pol)
title('polar angle')

subplot(2,1,2)
plot(azi)
title('azimuthal angle')
