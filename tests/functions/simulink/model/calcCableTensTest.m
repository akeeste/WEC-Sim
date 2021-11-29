classdef calcCableTensTest < matlab.unittest.TestCase

    properties (TestParameter)
        position = struct('compressed',[0 0 -2],'equilibrium',[0 0 0],'extended',[0 0 2]);
        initialLength = struct('compressed',2,'equilibrium',5,'extended',8);
    end

    methods(Test)        
        function tensionTest(testCase,position,initialLength)
            k = 1e3;
            c = 1e2;
            L0 = 5;
            x = position(3) + initialLength;
            velocity = [0 0 -1];
            expected = (-k*(x-L0) - c*velocity(3))*(x>L0);
            actual = calcCableTens(k, c, L0, initialLength, position, velocity);
            
            % Check function value size, NaN, and value
            assertSize(testCase,actual,[1 1]);
            assertFalse(testCase,isnan(actual));
            verifyEqual(testCase,actual,expected,'AbsTol',1e-10);
        end
    end
end
