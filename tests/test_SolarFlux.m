function test_suite=test_SolarFlux
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;

function test_SolarFlux_scalar
    assertTrue(round(SolarFlux_perso(3)) == 1414) %3 january: perigee and value of Solar flux is 1414 W/m^2
    %assertTrue(true)
    
function test_SolarFlux_vector
    assertEqual(round(SolarFlux_perso([3 184])), [1414 1322]); %day 184 : apogee, Solar flux= 1322 W/m^2
