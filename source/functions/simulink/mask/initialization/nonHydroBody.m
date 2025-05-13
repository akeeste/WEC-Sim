classdef nonHydroBody

    methods(Static)

        
        % Following properties of 'maskInitContext' are available to use:
        %  - BlockHandle
        %  - MaskObject
        %  - MaskWorkspace - Use get/set APIs to work with mask workspace.
        function MaskInitialization(maskInitContext)
            if exist('body','var')
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
            end
        end
        



    end
end