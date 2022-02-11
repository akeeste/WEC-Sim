function plotRadiationDamping(hydro,varargin)
    
    clear X Y Legends
    Fig2 = figure('Position',[50,300,975,521]);
    Title = ['Normalized Radiation Damping: $$\bar{B}_{i,j}(\omega) = {\frac{B_{i,j}(\omega)}{\rho\omega}}$$'];
    Subtitles = {'Surge','Heave','Pitch'};
    XLables = {'$$\omega (rad/s)$$','$$\omega (rad/s)$$','$$\omega (rad/s)$$'};
    YLables = {'$$\bar{B}_{1,1}(\omega)$$','$$\bar{B}_{3,3}(\omega)$$','$$\bar{B}_{5,5}(\omega)$$'};

    X = hydro.w;
    a = 0;
    for i = 1:hydro.Nb
        m = hydro.dof(i);
        Y(1,i,:) = squeeze(hydro.B(a+1,a+1,:));
        Legends{1,i} = [hydro.body{i}];
        Y(2,i,:) = squeeze(hydro.B(a+3,a+3,:));
        Legends{2,i} = [hydro.body{i}];
        Y(3,i,:) = squeeze(hydro.B(a+5,a+5,:));
        Legends{3,i} = [hydro.body{i}];
        a = a + m;
    end

    Notes = {'Notes:',...
        ['$$\bullet$$ $$\bar{B}_{i,j}(\omega)$$ should tend towards zero within ',...
        'the specified $$\omega$$ range.'],...
        ['$$\bullet$$ Only $$\bar{B}_{i,j}(\omega)$$ for the surge, heave, and ',...
        'pitch DOFs are plotted here. If another DOF is significant to the system ',...
        'that $$\bar{B}_{i,j}(\omega)$$ should also be plotted and verified before ',...
        'proceeding.']};

    if isempty(varargin)
        FormatPlot(Fig2,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes)
    end

    if length(varargin)==1
        try varargin{1}=varargin{1}{1}; end
        X1 = varargin{1}.w;
        a = 0;
        for i = 1:varargin{1}.Nb
            m = varargin{1}.dof(i);
            Y1(1,i,:) = squeeze(varargin{1}.B(a+1,a+1,:));
            Legends{1,i+2} = [varargin{1}.body{i}];
            Y1(2,i,:) = squeeze(varargin{1}.B(a+3,a+3,:));
            Legends{2,i+2} = [varargin{1}.body{i}];
            Y1(3,i,:) = squeeze(varargin{1}.B(a+5,a+5,:));
            Legends{3,i+2} = [varargin{1}.body{i}];
            a = a + m;
        end
        FormatPlot(Fig2,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes,X1,Y1)  
    end
   
    % waitbar(2/6);
    saveas(Fig2,'Radiation_Damping.png');

end