function elevation = waveElevation(A,w,dw,time,k,x,y,waveDir,waveSpread,phaseRand,typeNum)
% Calculates the wave elevation at a point in space with given wave properties. 
% 
% Note: cannot input multiple time steps and multiple locations at once.
% i.e. Simulink nonlinear wave elevation inputs multiple locations (stl
% centers) while the pre/post-processing input multiple times at a single
% wave gauge location

% Reshape variables so that their dimensions work together. New dimensions
% should be:
% [nXPoints, nDirections, nFrequencies] or [nTimesteps, nDirections, nFrequencies];
totalSize = ones(length(x), length(waveDir), length(A));
x = reshape(x,[length(x) 1 1]);
y = reshape(y,[length(y) 1 1]);
time = reshape(time,[length(time) 1 1]);
A = reshape(A,[1 1 length(A)]);
w = reshape(w,[1 1 length(w)]);
dw = reshape(dw,[1 1 length(dw)]);
k = reshape(k,[1 1 length(k)]);
phaseRand = reshape(phaseRand,[1 length(waveDir) length(A)]);
waveDir = reshape(waveDir,[1 length(waveDir) 1]);
waveSpread = reshape(waveSpread,[1 length(waveSpread) 1]);

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
elevation = sum(temp,[2 3]);

end
