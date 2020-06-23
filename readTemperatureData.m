function out = readTemperatureData (name)

% Works only for FUNcube

% Read the data for the cubesat thermal profile

fid = fopen(name,'r') ;

formatSPec = ' %s %d %d %d %d %d %d %d %d %d %d %d %d %d %d ' ;

out = textscan(fid,formatSPec,'headerlines', 1,'delimiter', ',' ,'TreatAsEmpty','NA'); 

fclose(fid);
end