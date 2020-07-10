
% plot the total input heat over the orbits

figure

subplot(2,3,1)
plot(inputT(1,:))
title('input X')

subplot(2,3,2)
plot(inputT(2,:))
title('input Xm')

subplot(2,3,3)
plot(inputT(3,:))
title('input Y')

subplot(2,3,4)
plot(inputT(4,:))
title('input Ym')

subplot(2,3,5)
plot(inputT(5,:))
title('input Z')

subplot(2,3,6)
plot(inputT(6,:))
title('input Zm')