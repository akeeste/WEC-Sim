function Fext = regularExcitation(A,w,fExtRE,fExtIM,phaseRand,time,waveSpread,fExtMD)
% variable dimensions:
%            regular
% A          (1,1)
% w          (1,1)
% fExtRE     (nDir,nDOF)
% fExtIM     (nDir,nDOF)
% phaseRand  (nDir,1)
% dw         (1,1)
% waveSpread (1,nDir)
% fExtMD     (nDir,nDOF)

% Loop through all wave directions
Fext = zeros(1,size(fExtRE,2));
for ii = 1:length(waveSpread)
    amplitude = A*waveSpread(ii);
    directionalComponent = excitationForce(time,amplitude,w,fExtRE(ii,:),...
        fExtIM(ii,:),fExtMD(ii,:),phaseRand(ii,:));
    Fext = Fext + directionalComponent;
end

end
