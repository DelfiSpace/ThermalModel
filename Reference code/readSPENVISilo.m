function out = readSPENVISilo(name)
% read the orbital data from SPENVIS

fid = fopen(name);

skipLines = fscanf(fid, '''*'', %d,',1);

for h = 1 : skipLines
    fgetl(fid);
end

first = sscanf(fgetl(fid), '%f,', Inf)';
out = first;
s = fgetl(fid);
while(length(s) > 1 && s(1) ~= '''')
    out = [out; sscanf(s, '%f,', Inf)'];
    s = fgetl(fid);
end

fclose(fid);