
% Load Funcube TLE (DelfiPQ will have an orbit similar to Funcube)
fid = fopen('TLE FUNCUBE Jul2014-2020.txt','r') ;

RAAN = [] ;
day = [] ;
year =[] ;

n = 1 ;

while(true)
    line = fgetl(fid);
    if(line == -1)
        break;
    else
        if mod(n,2) == 0
            RAAN = [RAAN ; str2double(line(18:25))] ;
        else
            day = [day ; floor(str2double(line(21:32)))] ;
            year = [year ; str2double(line(19:20))] ;
        end
        n = n + 1;
    end
end
fclose(fid);

% Find the coldest case scenario
i = 97.004 *pi/180 ; %inclination (in rad)
RAAN = RAAN *pi/180 ; 
beta = BetaAngle_perso(day,RAAN,i) ; %beta angle (in rad)





