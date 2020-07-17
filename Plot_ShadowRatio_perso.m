
% Validation of the computation of eclipse time

inclinaition = 97.8 *pi/180 ;
h = 408E3 ;
% inclinaition = 97.004 *pi/180 ;
% h = 630E3 ;

close all
beta=0:90;
ratio=zeros(0,90);
for i=beta
    [temp1,temp2,temp3]=EclipseTime_perso(i*pi/180,inclinaition,h);
    ratio(i+1)=temp2;
end
% Points from slide39 part 3 of the lecture
beta_test = [0 20 40 50 54 60 65 68 70];
Ratio_test = [0.39 0.38 0.35 0.32 0.3 0.26 0.2 0.1 0];

plot(beta,ratio)
hold on
plot(beta_test, Ratio_test, 'r*')
legend('Ratio in umbra', 'Comparison with slide 39, part3 of the thermal environment lecture')
xlabel('beta angle')
ylabel('Fraction of orbit in shadow')
title('Eclipse Time Validation')


