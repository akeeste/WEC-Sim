classdef runFromSimTest < matlab.unittest.TestCase
    
    properties
        testDir = '';
        wsDir = '';
        runFromSimDir = '';
        
        runFromSim = 1;
    end
    
    methods (Access = 'public')
        function obj = runFromSimTest(runFromSim)
            % Set WEC-Sim, test and applications directories
            temp = mfilename('fullpath');
            i = strfind(temp,filesep);
            obj.testDir = temp(1:i(end));
            
            obj.wsDir = fullfile(obj.testDir,'..');
            obj.runFromSimDir = fullfile(obj.testDir,'runFromSimulinkTests\');
            
            % Add directories to path
            addpath(genpath(obj.testDir))
            
            if exist('runFromSim','var')
                obj.runFromSim = runFromSim;
            end
        end
    end
    
    methods(TestClassSetup)
        function copyInputFiles(testCase)
            bdclose('all');
            
            % Create directory if necessary
            cd(testCase.testDir)
            if ~exist('runFromSimulinkTests','dir')
                mkdir('runFromSimulinkTests');
            end
            
            % Copy relevant input files
            copyfile(fullfile(testCase.wsDir,'/examples/RM3FromSimulink/wecSimInputFile.m'),...
                fullfile(testCase.runFromSimDir));
            copyfile(fullfile(testCase.wsDir,'/examples/RM3FromSimulink/geometry'),...
                fullfile(testCase.runFromSimDir,'geometry'));
            copyfile(fullfile(testCase.wsDir,'/examples/RM3FromSimulink/hydroData'),...
                fullfile(testCase.runFromSimDir,'hydroData'));
            
            copyfile(fullfile(testCase.wsDir,'/examples/RM3FromSimulink/RM3FromSimulink.slx'),...
                fullfile(testCase.runFromSimDir,'fromSimInput.slx'));
            copyfile(fullfile(testCase.wsDir,'/examples/RM3FromSimulink/RM3FromSimulink.slx'),...
                fullfile(testCase.runFromSimDir,'fromSimCustom.slx'));
            
            cd(testCase.runFromSimDir);
        end
        
        function editInputFiles(testCase)
            % Set proper parameters fromSimInput case
            load_system('fromSimInput.slx');
            
            blocks = find_system(bdroot,'Type','Block');
            for i=1:length(blocks)
                % Variable names and values of a block
                names = get_param(blocks{i},'MaskNames');
                values = get_param(blocks{i},'MaskValues');
                
                % Check if the block is the global reference frame
                if contains(names,{'simu','waves'})
                    grfBlockHandle = getSimulinkBlockHandle(blocks{i});
                    j = strcmp(names,'ParamInput');
                    values(j) = 'Input File';
                    
                    set_param(grfBlockHandle,'MaskValues',values);
                end
            end
            save_system('fromSimInput.slx');
            close_system('fromSimInput.slx');
            
            % Alter input file 
            fileID = fopen(fullfile(testCase.runFromSimDir, 'wecSimInputFile.m'),'a');
            fprintf(fileID,'%s\n',"simu.explorer = 'off';");
            fprintf(fileID,'%s\n',"simu.startTime = 0;");
            fprintf(fileID,'%s\n',"simu.rampTime = 2;");
            fprintf(fileID,'%s\n',"simu.endTime = 4;");
            fprintf(fileID,'%s\n',"simu.dt = 0.01;");
            fclose(fileID);
            
            bdclose('all');
            
            % Set proper parameters fromSimCustom case
            load_system('fromSimCustom.slx');
            
            blocks = find_system(bdroot,'Type','Block');
            for i=1:length(blocks)
                % Variable names and values of a block
                names = get_param(blocks{i},'MaskNames');
                values = get_param(blocks{i},'MaskValues');
                
                % Check if the block is the global reference frame
                if contains(names,{'simu','waves'})
                    grfBlockHandle = getSimulinkBlockHandle(blocks{i});
                    j = strcmp(names,'ParamInput');
                    values(j) = 'Input File';
                    
                    j = strcmp(names,'explorer');
                    values(j) = 'off';
                    
                    j = strcmp(names,'startTime');
                    values(j) = 0;
                    
                    j = strcmp(names,'rampTime');
                    values(j) = 2;
                    
                    j = strcmp(names,'endTime');
                    values(j) = 4;
                    
                    j = strcmp(names,'dt');
                    values(j) = 0.01;
                    
                    set_param(grfBlockHandle,'MaskValues',values);
                end
            end
            save_system('fromSimCustom.slx');
            close_system('fromSimCustom.slx');
            
            cd(testCase.testDir);
        end
    end
    
    methods(TestClassTeardown)
        function removeInputFiles(testCase)
            bdclose('all');
            cd(testCase.wsDir)
        end
    end
    
    methods(Test)
        function fromSimCustom(testCase)
            % Run WEC-Sim from Simulink with custom parameters
            testCase.assumeEqual(testCase.runFromSim,1,'Test off (runFromSim=0).')
            cd(testCase.runFromSimDir)
            
            simFile = fullfile(testCase.runFromSimDir,'fromSimCustom.slx');
            load_system(simFile);
            run('wecSimInitialize');
            sim(simFile, [], simset('SrcWorkspace','current'));
            
            close_system(simFile,0);
            bdclose('all')
            clear body constraint output pto simu waves
        end
        
        function fromSimInput(testCase)
            % Run WEC-Sim from Simulink with input file
            testCase.assumeEqual(testCase.runFromSim,1,'Test off (runFromSim=0).')
            cd(testCase.runFromSimDir)
            
            simFile = fullfile(testCase.runFromSimDir,'fromSimInput.slx');
            load_system(simFile);
            run('wecSimInitialize');
            sim(simFile, [], simset('SrcWorkspace','current'));
            
            close_system(simFile,0);
            bdclose('all')
            clear body constraint output pto simu waves
            
            cd(testCase.wsDir);
        end
        
    end
end