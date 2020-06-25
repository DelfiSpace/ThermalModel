
readQB50P1;

figure
plot(date1(start_date:end_date),out(start_date:end_date,41),'b:','LineWidth', 1.8)
hold on
plot(date1(start_date:end_date),out(start_date:end_date,42),'c:','LineWidth', 1.8)
plot(date1(start_date:end_date),out(start_date:end_date,43),'g:','LineWidth', 1.8)
plot(date1(start_date:end_date),out(start_date:end_date,44),'r:','LineWidth', 1.8)
plot(date1(start_date:end_date),out(start_date:end_date,45),'m:','LineWidth', 1.8)


date_test=[] ;
for i=0:700
    h = 8 + floor((55*60+i+6)/3600) ;
    s = mod(6+i , 60) ;
    m = mod(55 + floor((i+6 - (h-8)*3600) / 60) , 60);
    
    ch = [date_str ' ' num2str(h) ':' num2str(m) ':' num2str(s)] ;
    date_test = [date_test ; datetime(ch,'InputFormat','yyyy-MM-dd HH:mm:ss')];
end


a = 43840:43840+length(date_test)-1 ; %05/06/2015
plot(date_test, t(1,a)+T0, 'b', 'LineWidth', 2)
plot(date_test, t(2,a)+T0, 'c', 'LineWidth', 2)
plot(date_test, t(3,a)+T0, 'g', 'LineWidth', 2)
plot(date_test, t(4,a)+T0, 'r', 'LineWidth', 2)
plot(date_test, t(5,a)+T0, 'LineWidth', 2)
plot(date_test, t(6,a)+T0, 'm', 'LineWidth', 2)
%plot(date_test, t(7,a)+T0, 'LineWidth', 2)
legend('X+','X-','Y+','Y-','Z-','X+ simulation','X- simulation','Y+ simulation',...
    'Y- simulation','Z+ simulation','Z- simulation','payload')
title(['Temperature measurements for QB50-P1 (' date_str ') VS Simulation'])
grid on
xlabel('Time - s')
ylabel('Temperature - degC')
axis tight