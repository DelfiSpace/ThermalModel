function out = addThermalConnection(in, link, value)

out = zeros(size(in, 1) + 1, size(in, 2) + 1);
out(1:size(in, 1), 1 : size(in, 2)) = in;

% connection X+ Y+
a = [1 0 -1 0 0 0];
out(end, 1 : length(link)) = link;
out(1 : length(link), end) = -link';
out(end, end) = value;