classdef quaternion2EulXYZTest < matlab.unittest.TestCase

    properties (TestParameter)
        Q = struct('acute',[0.9893 0.0789 0.0941 0.0789],...
            'obtuse',[-0.1839 -0.6937 -0.0607 0.6937],...
            'deg90',[sqrt(2)/2 0 0 sqrt(2)/2],...
            'deg90_2',[sqrt(2)/2 0 sqrt(2)/2 0],...
            'deg180',[0 1 0 0],...
            'deg180_2',[0 0 1 0]);
    end

    methods(Test)        
        function quaternionTest(testCase,Q)
            expected = zeros(3,1);
            expected(1) = atan2((2*(Q(1)*Q(2)+Q(3)*Q(4))), (1-2*(Q(2)^2+Q(3)^2)));
            expected(2) = asin(2*(Q(1)*Q(3)-Q(4)*Q(2)));
            expected(3) = atan2((2*(Q(1)*Q(4)+Q(2)*Q(3))), (1-2*(Q(3)^2+Q(4)^2)));

            actual = quaternion2EulXYZ(Q);
            
            % Check function value size, NaN, and value
            assertSize(testCase,actual,[3 1]);
            assertFalse(testCase,any(isnan(actual)));
            verifyEqual(testCase,actual,expected,'AbsTol',1e-10);
        end
    end
end
