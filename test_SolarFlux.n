function test_suite=test_of_SolarFlux
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;

function test_SolarFlux_scalar
    assertTrue(SolarFlux_perso(1) == 1)
