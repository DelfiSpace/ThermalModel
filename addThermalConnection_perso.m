function out = addThermalConnection_perso(in, link, value)

out = in ;

indice = find(link);  %find the indice of the non zero elements

if link(indice(1)) == 1
    indice1 = indice(1) ; %indice of the element that is equal to 1
    indicem1 = indice(2) ;%indice of the element that is equal to -1 
else
    indice1 = indice(2) ;
    indicem1 = indice(1) ;
end

out(indice1,indice1) = out(indice1,indice1) + value ;
out(indice1,indicem1) = -value ;

end