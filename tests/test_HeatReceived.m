function test_suite=test_HeatReceived
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
    
function test_HeatReceived_nadir
    % For a nadir facing plate, beta=0°, Reference values are taken in the
    % fourth part of the nasa lecture about thermal analysis: Steven L. 
    % Rickman.  Introduction to on-orbit thermal environment part iv,
    % September 2011. https://nescacademy.nasa.gov/
    beta = 0*pi/180 ;
    h = 408E3 ;
    pol = pi/2 ;
    azi = pi ;
    teta = pi/180 *[0 30 60 90 95 100 109 180 251 260 265 270 300 330 360] ;
    Fpla = zeros(1,length(teta));
    Falb = zeros(1,length(teta));
    Fs = zeros(1,length(teta));
    
    for i=1:length(teta)
        [temp1,temp2,temp3] = HeatReceived_perso(94,beta,teta(1,i),h,pol,azi,0.3);
        Fpla(i)=temp1;
        Falb(i)=temp2;
        Fs(i)=temp3;
    end
    % assertTrue
%     assertEqual(round([Fpla ; Falb ; Fs]), [210*ones(1,length(teta)) ; ...
%         [360 320 180 0 0 0 0 0 0 0 0 0 180 320 360] ; ...
%         [0 0 0 0 100 220 460 0 460 220 100 0 0 0 0]]); 
    Falb_test = [360 320 180 0 0 0 0 0 0 0 0 0 180 320 360] ;
    Fs_test = [0 0 0 0 110 230 460 0 460 230 110 0 0 0 0] ;
    if Fpla <= (210+210*0.1)*ones(1,length(teta)) & Fpla >= (210-210*0.1)*ones(1,length(teta)) ...
            & round(Falb) <= 1.1*Falb_test & round(Falb) >= 0.9*Falb_test ...
            & round(Fs) <= 1.1*Fs_test & round(Fs) >= 0.9*Fs_test
        a = true ;
    else
        a = false;
    end
    assertTrue(a);
    
function test_HeatReceived_forward
    % For a forward facing plate, beta=0°
    beta = 0*pi/180 ;
    h = 408E3 ;
    pol = 0 ;
    azi = 0 ;
    teta = pi/180 *[0 30 60 90 251 270 300 330 360];
    Fpla = zeros(1,length(teta));
    Falb = zeros(1,length(teta));
    Fs = zeros(1,length(teta));
    
    for i=1:length(teta)
        [temp1,temp2,temp3] = HeatReceived_perso(94,beta,teta(1,i),h,pol,azi,0.3);
        Fpla(i)=temp1;
        Falb(i)=temp2;
        Fs(i)=temp3;
    end
    Falb_test = [110 100 55 0 0 0 55 100 110] ;
    Fs_test = [0 0 0 0 1295 1370 1190 680 0] ;
%     assertEqual(round([Fpla ; Falb ; Fs]), [70*ones(1,length(teta)) ; ...
%         [110 100 50 0 0 0 50 100 110] ; [0 0 0 0 1295 1370 1190 680 0]]); 
    if Fpla <= (70+70*0.1)*ones(1,length(teta)) & Fpla >= (70-70*0.1)*ones(1,length(teta)) ...
            & round(Falb) <= 1.1*Falb_test & round(Falb) >= 0.9*Falb_test ...
            & round(Fs) <= 1.1*Fs_test & round(Fs) >= 0.9*Fs_test
        a = true ;
    else
        a = false ;
    end
    assertTrue(a);
    
    
function test_HeatReceived_North
    % For a North facing plate, beta=-60°
    beta = -60*pi/180 ;
    h = 408E3 ;
    pol = pi/2 ; 
    azi = 3*pi/2 ;
    teta = pi/180 *[0 90 130 180 230 270 360];
    Fpla = zeros(1,length(teta));
    Falb = zeros(1,length(teta));
    Fs = zeros(1,length(teta));
    
    for i=1:length(teta)
        [temp1,temp2,temp3] = HeatReceived_perso(94,beta,teta(1,i),h,pol,azi,0.3);
        Fpla(i)=temp1;
        Falb(i)=temp2;
        Fs(i)=temp3;
    end
    
    Falb_test = [55 0 0 0 0 0 55] ; 
    Fs_test = [1185 1185 1185 0 1185 1185 1185] ;
%     assertEqual(round([Fpla ; Falb ; Fs]), [60*ones(1,length(teta)) ; [55 0 0 0 0 0 55] ; [1185 1185 1185 0 1185 1185 1185]])
    if Fpla <= (60+60*0.1)*ones(1,length(teta)) & Fpla >= (60-60*0.1)*ones(1,length(teta)) ...
            & Falb <= 1.1*Falb_test & Falb >= 0.9*Falb_test ...
            & Fs <= 1.1*Fs_test & Fs >= 0.9*Fs_test
        a = true ;
    else
        a = false ;
    end
    assertTrue(a);
    
    
    