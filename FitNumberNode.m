function out = FitNumberNode(input,Nface)

% Adapt the size of the input array to have an output with the same number
% of lines than the number of nodes (Nface)

out = ones(Nface,size(input,2)) ;

for i = 1:6
    out((i-1)*Nface/6+1:i*Nface/6,:) = input(i,:) .* ones(Nface/6,size(input,2)) ;
end

% Adapt the size of the input matrices to fit the number of nodes
% temp1 = ones(Nface,size(inputE,2)) ;
% temp2 = ones(Nface,size(inputT,2)) ;
% 
% temp1(1:Nface/6,:) = inputE(1,:) .* ones(Nface/6,size(temp1,2)) ;
% temp2(1:Nface/6,:) = inputT(1,:) .* ones(Nface/6,size(temp2,2)) ;
% 
% temp1(Nface/6+1:2*Nface/6,:) = inputE(2,:) .* ones(Nface/6,size(temp1,2)) ;
% temp2(Nface/6+1:2*Nface/6,:) = inputT(2,:) .* ones(Nface/6,size(temp2,2)) ;
% 
% temp1(2*Nface/6+1:3*Nface/6,:) = inputE(3,:) .* ones(Nface/6,size(temp1,2)) ;
% temp2(2*Nface/6+1:3*Nface/6,:) = inputT(3,:) .* ones(Nface/6,size(temp2,2)) ;
% 
% temp1(3*Nface/6+1:4*Nface/6,:) = inputE(4,:) .* ones(Nface/6,size(temp1,2)) ;
% temp2(3*Nface/6+1:4*Nface/6,:) = inputT(4,:) .* ones(Nface/6,size(temp2,2)) ;
% 
% temp1(4*Nface/6+1:5*Nface/6,:) = inputE(5,:) .* ones(Nface/6,size(temp1,2)) ;
% temp2(4*Nface/6+1:5*Nface/6,:) = inputT(5,:) .* ones(Nface/6,size(temp2,2)) ;
% 
% temp1(5*Nface/6+1:6*Nface/6,:) = inputE(6,:) .* ones(Nface/6,size(temp1,2)) ;
% temp2(5*Nface/6+1:6*Nface/6,:) = inputT(6,:) .* ones(Nface/6,size(temp2,2)) ;
% 
% inputE = temp1 ;
% inputT = temp2 ;

end