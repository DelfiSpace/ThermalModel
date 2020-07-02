
% Validation of the computation of eclipse time

close all
beta=0:0.5:90;
ratio=zeros(1,length(beta));
for i=1:length(beta)
    [temp1,temp2,temp3]=EclipseTime_perso(beta(i)*pi/180,97.8,408E3);
    ratio(i)=temp2;
end
% Points from slide39 part 3 of the lecture
beta_test = [0 20 40 50 54 60 65 68 70];
Ratio_test = [0.39 0.38 0.35 0.32 0.3 0.26 0.2 0.12 0];

plot(beta,ratio, 'LineWidth',2)
hold on
plot(beta_test, Ratio_test, 'r*','LineWidth',1.8)
legend('\fontsize{14} Ratio in umbra', '\fontsize{14}Reference Value (slide 39,[5])')
xlabel('\fontsize{14}beta angle')
ylabel('\fontsize{14}Fraction of orbit in shadow')
title('\fontsize{20}Eclipse Time Validation')


