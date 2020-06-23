
% read QB50P1 data and extract the temperature data for the 6th of May

file = 'qb50p1_busepswod_all.csv' ;

out = readmatrix(file) ;
[B,I] = sort(out(:,2)) ;
for i=1:size(out,2)
    out(:,i) = out(I,i) ;
end

date = [] ;

fid = fopen(file);
fgetl(fid);
for i=1:size(out,1)
    date = [date ; textscan(fid,'%*s %*d %*d %s', 'Delimiter', ',')] ;
    fgetl(fid);
end
fclose(fid);

date = date(I,1) ;
date1 = [] ;
for i=1:size(out,1)
    date1 = [date1 ; datetime(date{i,1}{1},'InputFormat','yyyy-MM-dd HH:mm:ss')];
end

% Find the line numbers for the 6th of May 2015
a = true ;
k = 1 ;
while a
    if strcmp(date{k,1}{1}(1:10),'2015-05-06')
        start_date = k ;
        while a
            k=k+1;
            if not(strcmp(date{k,1}{1}(1:10),'2015-05-06'))
                end_date = k-1 ; 
                a = false ;
            end % if
        end %while
    end %if
    k=k+1 ; 
end %while




