function plotRadiationIRF(hydro,varargin)

    clear X Y Legends
    Fig3 = figure('Position',[50,100,975,521]);
    Title = ['Normalized Radiation Impulse Response Functions: ',...
        '$$\bar{K}_{i,j}(t) = {\frac{2}{\pi}}\int_0^{\infty}{\frac{B_{i,j}(\omega)}{\rho}}\cos({\omega}t)d\omega$$'];
    Subtitles = {'Surge','Heave','Pitch'};
    XLables = {'$$t (s)$$','$$t (s)$$','$$t (s)$$'};
    YLables = {'$$\bar{K}_{1,1}(t)$$','$$\bar{K}_{3,3}(t)$$','$$\bar{K}_{3,3}(t)$$'};
    
    X = hydro.ra_t;
    n = 1;
    a = 0;
    for i = 1:hydro.Nb
        m = hydro.dof(i);
        Y(1,n,:) = squeeze(hydro.ra_K(a+1,a+1,:));
        Legends{1,n} = [hydro.body{i}];
        Y(2,n,:) = squeeze(hydro.ra_K(a+3,a+3,:));
        Legends{2,n} = [hydro.body{i}];
        Y(3,n,:) = squeeze(hydro.ra_K(a+5,a+5,:));
        Legends{3,n} = [hydro.body{i}];
        if isfield(hydro,'ss_A')==1
            n = n+1;
            Y(1,n,:) = squeeze(hydro.ss_K(a+1,a+1,:));
            Legends{1,n} = [hydro.body{i},' (SS)'];
            Y(2,n,:) = squeeze(hydro.ss_K(a+3,a+3,:));
            Legends{2,n} = [hydro.body{i},' (SS)'];
            Y(3,n,:) = squeeze(hydro.ss_K(a+5,a+5,:));
            Legends{3,n} = [hydro.body{i},' (SS)'];
        end
        n = n+1;
        a = a + m;
    end
    
    Notes = {'Notes:',...
        ['$$\bullet$$ The IRF should tend towards zero within the specified timeframe. ',...
        'If it does not, attempt to correct this by adjusting the $$\omega$$ and ',...
        '$$t$$ range and/or step size used in the IRF calculation.'],...
        ['$$\bullet$$ Only the IRFs for the surge, heave, and pitch DOFs are plotted ',...
        'here. If another DOF is significant to the system, that IRF should also ',...
        'be plotted and verified before proceeding.']};
    
    if isempty(varargin)
        FormatPlot(Fig3,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes)
    end
        
    if length(varargin)==1
        try varargin{1}=varargin{1}{1}; end
        X1 = hydro.ra_t;
        n = 1;
        a = 0;    
        for i = 1:varargin{1}.Nb
            m = varargin{1}.dof(i);
            Y1(1,n,:) = squeeze(varargin{1}.ra_K(a+1,a+1,:));
            Legends{1,n+2} = [varargin{1}.body{i}];
            Y1(2,n,:) = squeeze(varargin{1}.ra_K(a+3,a+3,:));
            Legends{2,n+2} = [varargin{1}.body{i}];
            Y1(3,n,:) = squeeze(varargin{1}.ra_K(a+5,a+5,:));
            Legends{3,n+2} = [varargin{1}.body{i}];
            if isfield(varargin{1},'ss_A')==1
                n = n+1;
                Y1(1,n,:) = squeeze(varargin{1}.ss_K(a+1,a+1,:));
                Legends{1,n+2} = [varargin{1}.body{i},' (SS)'];
                Y1(2,n,:) = squeeze(varargin{1}.ss_K(a+3,a+3,:));
                Legends{2,n+2} = [varargin{1}.body{i},' (SS)'];
                Y1(3,n,:) = squeeze(varargin{1}.ss_K(a+5,a+5,:));
                Legends{3,n+2} = [varargin{1}.body{i},' (SS)'];
            end
            n = n+1;
            a = a + m;
        end  
        FormatPlot(Fig3,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes,X1,Y1)  
    end
    
%     waitbar(3/6);
saveas(Fig3,'Radiation_IRFs.png');

end