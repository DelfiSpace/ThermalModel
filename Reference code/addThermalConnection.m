function out = addThermalConnection(in, link1, link2, value)

% link1, link2: number of the nodes connected 

out = zeros(size(in, 1) + 1, size(in, 2) + 1);
out(1:size(in, 1), 1 : size(in, 2)) = in;

out(end, link1) = 1 ;
out(end, link2) = -1 ;
out(link1, end) = -1 ;
out(link2, end) = 1 ;
out(end, end) = value ;