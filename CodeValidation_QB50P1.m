
readQB50P1;

close all
plot(date1(start_date:end_date),out(start_date:end_date,41),'LineWidth', 2)
hold on
plot(date1(start_date:end_date),out(start_date:end_date,42),'LineWidth', 2)
plot(date1(start_date:end_date),out(start_date:end_date,43),'LineWidth', 2)
plot(date1(start_date:end_date),out(start_date:end_date,44),'LineWidth', 2)
plot(date1(start_date:end_date),out(start_date:end_date,45),'LineWidth', 2)


date_test=[] ;
for i=0:800
    h = 8 + floor((55*60+i+6)/3600) ;
    s = mod(6+i , 60) ;
    m = mod(55 + floor((i+6 - (h-8)*3600) / 60) , 60);
    
    ch = ['2015-05-06 0' num2str(h) ':' num2str(m) ':' num2str(s)] ;
    date_test = [date_test ; datetime(ch,'InputFormat','yyyy-MM-dd HH:mm:ss')];
end

a=t(1,43000:43000+length(date_test)-1)+T0;
plot(date_test, a, 'LineWidth', 2)
legend('X+','X-','Y+','Y-','Z-','X+ simulation')
title('Temperature measurements for QB50-P1 (05/06/2015)')
grid on
xlabel('Time - s')
ylabel('Temperature - degC')
axis tight