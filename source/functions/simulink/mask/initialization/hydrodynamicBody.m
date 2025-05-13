classdef hydrodynamicBody

    methods(Static)

        
        % Following properties of 'maskInitContext' are available to use:
        %  - BlockHandle
        %  - MaskObject
        %  - MaskWorkspace - Use get/set APIs to work with mask workspace.
        function MaskInitialization(maskInitContext)
            % geometry file name
            h=[gcb '/Structure/Body Properties'];
            geomFile=body.geometryFile;
            set_param(h,'ExtGeomFileName',geomFile);
            geomType='STL';
            % split version e.g. '9.10.0.16028 (R2021a)' into 9, 10, 0, NaN.
            % cannot compare str2double('9.10') because it becomes '9.1' 
            ver=split(version,'.');
            ver=str2double(ver(1:3));
            if ver(1) < 9 || (ver(1) == 9 && ver(2) < 6)
               set_param(h,'ExtGeomFileType',geomType);
            end
            % toWorkSpace: outputs
            h=[gcb '/To Workspace'];
            responseName=['body' num2str(body.number) '_out'];
            set_param(h,'VariableName',responseName);
            % toWorkSpace: hydrostatic pressures
            h=[gcb '/Hydrostatic Restoring Force Calculation/Linear and Nonlinear Restoring Force Variant Subsystem/Nonlinear Hydrostatic Restoring Force/To Workspace1'];
            responseName=['body' num2str(body.number) '_hspressure_out'];
            set_param(h,'VariableName',responseName); 
            % toWorkSpace: wave pressures (non-linear Freude-Krylov)
            h=[gcb '/Wave Diffraction and Excitation Force Calculation/Nonlinear FK Force Variant Subsystem/With Nonlinear FroudeKrylov Force/To Workspace'];
            responseName=['body' num2str(body.number) '_wavenonlinearpressure_out'];
            set_param(h,'VariableName',responseName);
            % toWorkSpace: wave pressures (linear Freude-Krylov)
            h=[gcb '/Wave Diffraction and Excitation Force Calculation/Nonlinear FK Force Variant Subsystem/With Nonlinear FroudeKrylov Force/To Workspace1'];
            responseName=['body' num2str(body.number) '_wavelinearpressure_out'];
            set_param(h,'VariableName',responseName);
            % position GoTo 
            h=[gcb '/Goto'];
            responseName=['disp' num2str(body.number)];
            set_param(h,'GotoTag',responseName);
            % position From
            h=[gcb '/From'];
            responseName=['disp' num2str(body.number)];
            set_param(h,'GotoTag',responseName);
            % velocity GoTo 
            h=[gcb '/Goto1'];
            responseName=['vel' num2str(body.number)];
            set_param(h,'GotoTag',responseName);
            % velocity From 
            h=[gcb '/From1'];
            responseName=['vel' num2str(body.number)];
            set_param(h,'GotoTag',responseName);
            % acceleration GoTo
            h=[gcb '/Goto2'];
            responseName=['acc' num2str(body.number)];
            set_param(h,'GotoTag',responseName);
            % acceleration From 
            h=[gcb '/From2'];
            responseName=['acc' num2str(body.number)];
            set_param(h,'GotoTag',responseName);
            % excitation force GoTo
            h = [gcb '/Goto3'];
            responseName = ['b' num2str(body.number) '_f_excitation'];
            set_param(h, 'GotoTag', responseName);
            % total force GoTo
            h = [gcb '/Goto4'];
            responseName = ['b' num2str(body.number) '_f_total'];
            set_param(h, 'GotoTag', responseName);
            
            %% Variable Hydro:
            % Variant subsystem
            h = [gcb '/Variable Hydrodynamics Control/Variable Hydrodynamics Subsystem'];
            responseName = ['sv_b' num2str(body.number) '_variableHydro'];
            set_param(h,'VariantControl',responseName);
            % body_hydroForceIndex To Workspace tags
            h=[gcb '/Variable Hydrodynamics Control/Variable Hydrodynamics Subsystem/variableHydro/To Workspace'];
            responseName=['body' num2str(body.number) '_hydroForceIndex'];
            set_param(h,'VariableName',responseName); 
            % body_hydroForceIndex From tags
            h=[gcb '/Variable Hydrodynamics Control/Variable Hydrodynamics Subsystem/variableHydro/From'];
            responseName=['body' num2str(body.number) '_hydroForceIndex'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/Wave Radiation Forces Calculation/SS CI and Constant-Damping-CoeVariant Subsystem/Convolution Integral Calculation/Convolution Variant Subsystem/Convolution Integral Surface Calculation/From'];
            responseName=['body' num2str(body.number) '_hydroForceIndex'];
            set_param(h,'GotoTag',responseName);
            % body_hydroForce GoTo
            h=[gcb '/Variable Hydrodynamics Control/Goto'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            % body_hydroForce From tags
            h=[gcb '/Wave Diffraction and Excitation Force Calculation/From'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/Wave Radiation Forces Calculation/From'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/Wave Radiation Forces Calculation/SS CI and Constant-Damping-CoeVariant Subsystem/Constant Coefficients/From'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/Wave Radiation Forces Calculation/SS CI and Constant-Damping-CoeVariant Subsystem/Convolution Integral Calculation/Convolution Variant Subsystem/Convolution Integral Calculation/From'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/Hydrostatic Restoring Force Calculation/Linear and Nonlinear Restoring Force Variant Subsystem/Linear Hydrostatic Restoring Force/From'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/Hydrostatic Restoring Force Calculation/Linear and Nonlinear Restoring Force Variant Subsystem/Nonlinear Hydrostatic Restoring Force/From'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            h=[gcb '/From3'];
            responseName=['body' num2str(body.number) '_hydroForce'];
            set_param(h,'GotoTag',responseName);
            % Update body.hydroForce constant data type
            h=[gcb '/Variable Hydrodynamics Control/Constant'];
            busName=['Bus: bus_body' num2str(body.number) '_hydroForce'];
            set_param(h,'OutDataTypeStr',busName);
        end
        



    end
end