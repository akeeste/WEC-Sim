function elevation = waveElevation(A,w,dw,time,k,x,y,waveDir,waveSpread,phaseRand,typeNum)
% Calculates the wave elevation at a point in space with given wave properties. 
% 
% Note: cannot currently take multiple time steps and multiple locations at
% once. e.g. Simulink nonlinear wave elevation inputs multiple locations
% (stl centers) while the pre/post-processing input multiple times at a
% single wave gauge location

arguments
    A (1,1,:) double {mustBeNonnegative}
    w (1,1,:) double {mustBeNonnegative}
    dw (1,1,:) double {mustBeNonnegative}
    time (:,1,1) double {mustBeNonnegative}
    k (1,1,:) double {mustBeNonnegative}
    x (:,1,1) double {mustBeReal isfinite}
    y (:,1,1) double {mustBeReal isfinite}
    waveDir (1,:,1) double {mustBeReal isfinite}
    waveSpread (1,:,1) double {mustBeNonnegative}
    phaseRand (1,:,:) double {mustBeReal isfinite}
    typeNum (1,1) double {mustBeNonnegative}
end

% Argument validation reshapes variables so that their dimensions work 
% together. New dimensions should be:
% [nXPoints, nDirections, nFrequencies] or [nTimesteps, nDirections, nFrequencies];
totalSize = ones(length(x), length(waveDir), length(A));

% Calculate the wave elevation for each wave type
X = x.*cos(waveDir*pi/180) + y.*sin(waveDir*pi/180);
temp = 0.*totalSize;
if typeNum <10
elseif typeNum <20
    temp = A(1).*waveSpread.*cos(w(1).*time - k(1).*X);
elseif typeNum <30
    temp = sqrt(A.*dw).*waveSpread.*cos(w.*time - k.*X + phaseRand);
end
elevation = zeros(length(x),1);
elevation = sum(temp,[2 3]); % sum across all directions (2) and frequencies (3)

end
