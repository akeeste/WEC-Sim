function Fext = excitationForce(time,amplitude,w,fExtRE,fExtIM,fExtMD,phaseRand)
%#codegen

% Calculate excitation force components
real      = fExtRE.*amplitude.*cos(w*time + phaseRand);
imaginary = fExtIM.*amplitude.*sin(w*time + phaseRand);
meanDrift = fExtMD.*amplitude.^2;
net = meanDrift + real - imaginary;

% Sum across all wave frequency components
Fext = sum(net,[1]);

end