function elevation  = stlWaveElevation(x,center,cg,AH,w,dw,k,typeNum,t,rampT,phaseRand,waveDir,waveSpread)
% Function to calculate the wave elevation at the centroids of triangulated surface
% NOTE: This function assumes that the STL file is imported with its CG at 0,0,0

% Compute new tri center coords after cog rotation and translation
center = rotateXYZ(center,[1 0 0],x(4));
center = rotateXYZ(center,[0 1 0],x(5));
center = rotateXYZ(center,[0 0 1],x(6));
center = offsetXYZ(center,x);
center = offsetXYZ(center,cg);

% Calculate the free surface
elevation = zeros(length(center),1);
elevation = waveElevation(AH,w,dw,t,k,center(:,1),center(:,2),waveDir,waveSpread,phaseRand,typeNum);
elevation = elevation*rampFunction(t,rampT);
end
