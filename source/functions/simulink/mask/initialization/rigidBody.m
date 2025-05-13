classdef rigidBody

    methods(Static)

        
        % Following properties of 'maskInitContext' are available to use:
        %  - BlockHandle
        %  - MaskObject
        %  - MaskWorkspace - Use get/set APIs to work with mask workspace.
        function MaskInitialization(maskInitContext)
            %%
            % Hydro Body
            h = [gcb '/Hydrodynamic Body'];
            responseName = ['sv_b' num2str(body.number) '_hydroBody'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Morison Element: Off
            h = [gcb '/Hydrodynamic Body/Morison Element and Viscous Damping Force Calculation/Morison Element Variant Subsystem/Morison Element Off'];
            responseName = ['sv_b' num2str(body.number) '_MEOff'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Morison Element: On
            h = [gcb '/Hydrodynamic Body/Morison Element and Viscous Damping Force Calculation/Morison Element Variant Subsystem/Morison Element On'];
            responseName = ['sv_b' num2str(body.number) '_MEOn'];
            set_param(h,'VariantControl',responseName);

            % test
            
            %%
            % Hydro Body Nonlinear Froude Krylov Force: Off
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Nonlinear FK Force Variant Subsystem/No Nonlinear FroudeKrylov Force'];
            responseName = ['sv_b' num2str(body.number) '_linearHydro'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Nonlinear Froude Krylov Force: On
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Nonlinear FK Force Variant Subsystem/With Nonlinear FroudeKrylov Force'];
            responseName = ['sv_b' num2str(body.number) '_nonlinearHydro'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Nonlinear Restoring: Off
            h = [gcb '/Hydrodynamic Body/Hydrostatic Restoring Force Calculation/Linear and Nonlinear Restoring Force Variant Subsystem/Linear Hydrostatic Restoring Force'];
            responseName = ['sv_b' num2str(body.number) '_linearHydro'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Nonlinear Restoring: On
            h = [gcb '/Hydrodynamic Body/Hydrostatic Restoring Force Calculation/Linear and Nonlinear Restoring Force Variant Subsystem/Nonlinear Hydrostatic Restoring Force'];
            responseName = ['sv_b' num2str(body.number) '_nonlinearHydro'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Regular Excitation Passive Yaw: Off
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Linear Wave Excitation Force Variant Subsystem/Regular Wave ' newline 'Excitation Force'];
            responseName = ['sv_regularWaves_b' num2str(body.number)];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Regular Excitation Passive Yaw: On
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Linear Wave Excitation Force Variant Subsystem/Regular Wave ' newline 'NonLinear Yaw'];
            responseName = ['sv_regularWavesYaw_b' num2str(body.number)];
            set_param(h,'VariantControl',responseName);
            %%    
            % Hydro Body Irregular Excitation Passive Yaw: Off
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Linear Wave Excitation Force Variant Subsystem/Irregular Wave ' newline 'Excitation Force'];
            responseName = ['sv_irregularWaves_b' num2str(body.number)];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Irregular Excitation Passive Yaw: On
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Linear Wave Excitation Force Variant Subsystem/Irregular Wave ' newline 'NonLinearYaw'];
            responseName = ['sv_irregularWavesYaw_b' num2str(body.number)];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Nonlinear Froude Krylov or Restoring: Instantaneous Free Surface
            h = [gcb '/Hydrodynamic Body/Nonlinear Wave Elevation/Linear or Instantaneous Free Surface/Instantaneous Water Free Surface'];
            responseName = ['sv_b' num2str(body.number) '_instFS'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body Nonlinear Froude Krylov or Restoring: Mean Free Surface
            h = [gcb '/Hydrodynamic Body/Nonlinear Wave Elevation/Linear or Instantaneous Free Surface/Mean Water Free Surface'];
            responseName = ['sv_b' num2str(body.number) '_meanFS'];
            set_param(h,'VariantControl',responseName);
            %% Variable hydro on/off
            % Variable hydro control - variable hydro off
            h = [gcb '/Hydrodynamic Body/Variable Hydrodynamics Control/Variable Hydrodynamics Subsystem/noVariableHydro'];
            responseName = ['sv_b' num2str(body.number) '_noVariableHydro'];
            set_param(h,'VariantControl',responseName);
            % Variable hydro control - variable hydro on
            h = [gcb '/Hydrodynamic Body/Variable Hydrodynamics Control/Variable Hydrodynamics Subsystem/variableHydro'];
            responseName = ['sv_b' num2str(body.number) '_variableHydro'];
            set_param(h,'VariantControl',responseName);
            % CIC - variable hydro off
            h = [gcb '/Hydrodynamic Body/Wave Radiation Forces Calculation/SS CI and Constant-Damping-CoeVariant Subsystem/Convolution Integral Calculation/Convolution Variant Subsystem/Convolution Integral Calculation'];
            responseName = ['sv_b' num2str(body.number) '_noVariableHydro'];
            set_param(h,'VariantControl',responseName);
            % CIC - variable hydro on
            h = [gcb '/Hydrodynamic Body/Wave Radiation Forces Calculation/SS CI and Constant-Damping-CoeVariant Subsystem/Convolution Integral Calculation/Convolution Variant Subsystem/Convolution Integral Surface Calculation'];
            responseName = ['sv_b' num2str(body.number) '_variableHydro'];
            set_param(h,'VariantControl',responseName);
            %%
            % Non-Hydro Body
            h = [gcb '/Non-Hydro Body'];
            responseName = ['sv_b' num2str(body.number) '_nonHydroBody'];
            set_param(h,'VariantControl',responseName);
            %%
            % Drag Body
            h = [gcb '/Drag Body'];
            responseName = ['sv_b' num2str(body.number) '_dragBody'];
            set_param(h,'VariantControl',responseName);
            %%
            % Drag Body Morison Element: Off
            h = [gcb '/Drag Body/Morison Element and Viscous Damping Force Calculation/Morison Element Variant Subsystem/Morison Element Off'];
            responseName = ['sv_b' num2str(body.number) '_MEOff'];
            set_param(h,'VariantControl',responseName);
            %%
            % Drag Body Morison Element: On
            h = [gcb '/Drag Body/Morison Element and Viscous Damping Force Calculation/Morison Element Variant Subsystem/Morison Element On'];
            responseName = ['sv_b' num2str(body.number) '_MEOn'];
            set_param(h,'VariantControl',responseName);
            %% 
            % Hydro Body QTF: Off
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Second Order Excitation Force Variant Subsystem/No Second Order Excitation Force'];
            responseName = ['sv_b' num2str(body.number) '_noSecondOrderExt'];
            set_param(h,'VariantControl',responseName);
            %%
            % Hydro Body QTF: On
            h = [gcb '/Hydrodynamic Body/Wave Diffraction and Excitation Force Calculation/Second Order Excitation Force Variant Subsystem/With Second Order Excitation Force'];
            responseName = ['sv_b' num2str(body.number) '_secondOrderExt'];
            set_param(h,'VariantControl',responseName);
            %%
            % Set zero active variant controls to prevent label issue
            set_param(gcb,'AllowZeroVariantControls','on');
        end
        
        function nonHydro(callbackContext)
            bodyClassCallback(gcbh)
        end

        function option(callbackContext)
            bodyClassCallback(gcbh)
        end


        function H5button(callbackContext)
            h5ButtonCallback(gcbh)
        end

        function STLbutton(callbackContext)
            stlButtonCallback(gcbh)
        end



    end
end