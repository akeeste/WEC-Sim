clear all;clc; close all
%% From hydro structure (before h5)

%% Sphere (1 body)

WAMIT_hydro = struct();
WAMIT = '.\WAMIT\Sphere\sphere.out';
WAMIT_hydro = Read_WAMIT(WAMIT_hydro,WAMIT,[]);
WAMIT_hydro = Radiation_IRF(WAMIT_hydro,15,[],[],[],[]);
WAMIT_hydro = Excitation_IRF(WAMIT_hydro,15,[],[],[],[]);

AQWA_hydro = struct();
AQWA_AH1 = '.\AQWA\Sphere\sphere.AH1';
AQWA_LIS = '.\AQWA\Sphere\sphere.LIS';
AQWA_hydro = Read_AQWA(AQWA_hydro, AQWA_AH1, AQWA_LIS);
AQWA_hydro = Radiation_IRF(AQWA_hydro,15,[],[],[],[]);
AQWA_hydro = Excitation_IRF(AQWA_hydro,15,[],[],[],[]);

% load('wamit_aqwa_sphere.mat')

%% RM3 (2 bodies)

% WAMIT_hydro = struct();
% WAMIT_out = '.\WAMIT\RM3\rm3.out';
% WAMIT_hydro = Read_WAMIT(WAMIT_hydro,WAMIT_out,[]);
% WAMIT_hydro = Radiation_IRF(WAMIT_hydro,20,[],[],[],[]);
% WAMIT_hydro = Excitation_IRF(WAMIT_hydro,20,[],[],[],[]);
% 
% AQWA_hydro = struct();
% AQWA_AH1 = '.\AQWA\RM3\RM3.AH1';
% AQWA_LIS = '.\AQWA\RM3\RM3.LIS';
% AQWA_hydro = Read_AQWA(AQWA_hydro, AQWA_AH1, AQWA_LIS);
% AQWA_hydro = Radiation_IRF(AQWA_hydro,150,[],[],[],[]);
% AQWA_hydro = Excitation_IRF(AQWA_hydro,150,[],[],[],[]);

% load('wamit_aqwa_rm3.mat')

%% WEC3 (3 bodies)

WAMIT_hydro = struct();
WAMIT = '.\WAMIT\WEC3\wec3.out';
WAMIT_hydro = Read_WAMIT(WAMIT_hydro,WAMIT,[]);
WAMIT_hydro = Radiation_IRF(WAMIT_hydro,160,[],[],[],[]);
WAMIT_hydro = Excitation_IRF(WAMIT_hydro,160,[],[],[],[]);

AQWA_hydro = struct();
AQWA_AH1 = '.\AQWA\WEC3\wec3.AH1';
AQWA_LIS = '.\AQWA\WEC3\wec3.LIS';
AQWA_hydro = Read_AQWA(AQWA_hydro, AQWA_AH1, AQWA_LIS);
AQWA_hydro = Radiation_IRF(AQWA_hydro,160,[],[],[],[]);
AQWA_hydro = Excitation_IRF(AQWA_hydro,160,[],[],[],[]);

% load('wamit_aqwa_wec3.mat')

%% Plot 
% plotAddedMass(WAMIT_hydro)
% plotAddedMass(AQWA_hydro)
% plotAddedMass(WAMIT_hydro,AQWA_hydro)
% 
% plotRadiationDamping(WAMIT_hydro)
% plotRadiationDamping(AQWA_hydro)
% plotRadiationDamping(WAMIT_hydro,AQWA_hydro)
% 
% plotRadiationIRF(WAMIT_hydro)
% plotRadiationIRF(AQWA_hydro)
% plotRadiationIRF(WAMIT_hydro,AQWA_hydro)
% 
% plotExcitationMagnitude(WAMIT_hydro)
% plotExcitationMagnitude(AQWA_hydro)
% plotExcitationMagnitude(WAMIT_hydro,AQWA_hydro)
% 
% plotExcitationPhase(WAMIT_hydro)
% plotExcitationPhase(AQWA_hydro)
% plotExcitationPhase(WAMIT_hydro,AQWA_hydro)
% 
% plotExcitationIRF(WAMIT_hydro)
% plotExcitationIRF(AQWA_hydro)
% plotExcitationIRF(WAMIT_hydro,AQWA_hydro)

plotBEMIO(WAMIT_hydro,AQWA_hydro)

%% from h5 file

% WAMIT = 'rm3.h5';
% WAMIT = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\WAMIT\RM3\rm3.h5';
% % h5disp(WAMIT)
% WAMIT_body1 = readBEMIOH5(WAMIT,1);
% WAMIT_body2 = readBEMIOH5(WAMIT,2);
% 
% AQWA = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\AQWA\RM3\rm3.h5';
% % h5disp(AQWA)
% AQWA_body1 = readBEMIOH5(AQWA,1);
% AQWA_body2 = readBEMIOH5(AQWA,2);
% 
% 
% plotBEMIO(WAMIT_body1)
% hold on
% plotBEMIO(AQWA_body1)

