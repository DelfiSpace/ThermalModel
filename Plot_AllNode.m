
figure

time = 40000:55000 ;

subplot(2,3,1)
hold on
plot(t(1,time)+T0, 'r', 'LineWidth', 2)
plot(t(2,time)+T0, 'g', 'LineWidth', 2)
plot(t(3,time)+T0, 'k', 'LineWidth', 2)
plot(t(4,time)+T0, 'm', 'LineWidth', 2)
plot(t(5,time)+T0, 'c', 'LineWidth', 2)
title('X+ simulation')
grid on

subplot(2,3,2)
hold on
plot(t(6,time)+T0, 'r', 'LineWidth', 2)
plot(t(7,time)+T0, 'g', 'LineWidth', 2)
plot(t(8,time)+T0, 'k', 'LineWidth', 2)
plot(t(9,time)+T0, 'm', 'LineWidth', 2)
plot(t(10,time)+T0, 'c', 'LineWidth', 2)
title('X- simulation')
grid on

subplot(2,3,3)
hold on
plot(t(11,time)+T0, 'r', 'LineWidth', 2)
plot(t(12,time)+T0, 'g', 'LineWidth', 2)
plot(t(13,time)+T0, 'k', 'LineWidth', 2)
plot(t(14,time)+T0, 'm', 'LineWidth', 2)
plot(t(15,time)+T0, 'c', 'LineWidth', 2)
title('Y+ simulation')
grid on

subplot(2,3,4)
hold on
plot(t(16,time)+T0, 'r', 'LineWidth', 2)
plot(t(17,time)+T0, 'g', 'LineWidth', 2)
plot(t(18,time)+T0, 'k', 'LineWidth', 2)
plot(t(19,time)+T0, 'm', 'LineWidth', 2)
plot(t(20,time)+T0, 'c', 'LineWidth', 2)
title('Y- simulation')
grid on

subplot(2,3,5)
hold on
plot(t(21,time)+T0, 'r', 'LineWidth', 2)
plot(t(22,time)+T0, 'g', 'LineWidth', 2)
plot(t(23,time)+T0, 'k', 'LineWidth', 2)
plot(t(24,time)+T0, 'm', 'LineWidth', 2)
plot(t(25,time)+T0, 'c', 'LineWidth', 2)
title('Z+ simulation')
grid on

subplot(2,3,6)
hold on
plot(t(26,time)+T0, 'r', 'LineWidth', 2)
plot(t(27,time)+T0, 'g', 'LineWidth', 2)
plot(t(28,time)+T0, 'k', 'LineWidth', 2)
plot(t(29,time)+T0, 'm', 'LineWidth', 2)
plot(t(30,time)+T0, 'c', 'LineWidth', 2)
title('Z- simulation')
grid on

