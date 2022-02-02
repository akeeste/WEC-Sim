function Fext = irregularExcitation(A,w,fExtRE,fExtIM,phaseRand,dw,time,waveSpread,fExtMD)
% variable dimensions:
%            irregular
% A          (nA,1)
% w          (nA,1)
% fExtRE     (nDir,nA,nDOF)
% fExtIM     (nDir,nA,nDOF)
% phaseRand  (nA,nDir)
% dw         (nA,1)
% waveSpread (1,nDir)
% fExtMD     (nDir,nA,nDOF)

% Loop through all wave directions
Fext = zeros(1,size(fExtRE,3));
for ii = 1:length(waveSpread)
    amplitude = sqrt(A.*dw.*waveSpread(ii));
    exRe = squeeze(fExtRE(ii,:,:));
    exIm = squeeze(fExtIM(ii,:,:));
    exMd = squeeze(fExtMD(ii,:,:));
    directionalComponent = excitationForce(time,amplitude,w,exRe,...
        exIm,exMd,phaseRand(:,ii));
    Fext = Fext + directionalComponent;
end

end
