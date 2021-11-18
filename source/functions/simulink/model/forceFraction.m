function fFraction = forceFraction(force, depthHi, depthLo, top, base, ...
    k, A, H, waterDepth, deepWaterWave)
% this function calculates the fraction of the total force between two
% depths (depthHi and depthLo). 
% 
% This intended to find the fraction of a hydrodynamic force (excitation,
% added mass, radiation damping, Morison) at a given depth, rather than
% split up linear damping, etc.

% Find dominant wave number
% TODO update formulation later on to consider the full irregular wave spectrum
if length(k) > 1
    [~,iMajor] = min(abs(A - H));
    kMajor = k(iMajor);
else
    kMajor = k;
end

h = waterDepth;
zmax = max(depthHi,0);
zmin = min(base,-h);
dz = (zmax-zmin)/(8*100);
z = zmin:dz:zmax;

[~,idepthHi] = min(abs(depthHi-z));
[~,idepthLo] = min(abs(depthLo-z));
[~,iTop] = min(abs(top-z));
[~,iBase] = min(abs(base-z));

if deepWaterWave == 0
    % shallow and intermediate depth waves used intermediate decay
    % formulation
    decay = cosh(kMajor*(z+h))/cosh(kMajor*h);
else
    % deep water decay formulation
    decay = exp(kMajor*z);
end
% remove decay components above SWL and below seabed 
% (allows beam to embed below seabed and rise above SWL)
decay(z>0) = 0;
decay(z<-h) = 0;


if top > 0 && base > 0
    % If the beam is entirely emerged, take the fraction of the force based
    % on the segment length compared to the total length
    fraction = (depthHi-depthLo)/(top-base);
else
    % If the beam is at least partially submerged, 
    % Calculate the fraction of the force over the entire beam, at the 
    % depth of this beam segment
    % TODO won't work well if only a small portion of the beam is 
    net = cumtrapz(z(iBase:iTop), decay(iBase:iTop));
    partial = cumtrapz(z(idepthLo:idepthHi), decay(idepthLo:idepthHi));
    fraction = partial(end)/net(end);
end
fFraction = force*fraction;
