function plotAddedMass(hydro,varargin)
    
    clear X Y Legends
    Fig1 = figure('Position',[50,500,975,521]);
    Title = ['Normalized Added Mass: $$\bar{A}_{i,j}(\omega) = {\frac{A_{i,j}(\omega)}{\rho}}$$'];
    Subtitles = {'Surge','Heave','Pitch'};
    XLables = {'$$\omega (rad/s)$$','$$\omega (rad/s)$$','$$\omega (rad/s)$$'};
    YLables = {'$$\bar{A}_{1,1}(\omega)$$','$$\bar{A}_{3,3}(\omega)$$','$$\bar{A}_{5,5}(\omega)$$'};
    
    X = hydro.w;
    a = 0;
    for i = 1:hydro.Nb    
        m = hydro.dof(i);
        Y(1,i,:) = squeeze(hydro.A(a+1,a+1,:));
        Legends{1,i} = [hydro.body{i}];
        Y(2,i,:) = squeeze(hydro.A(a+3,a+3,:));
        Legends{2,i} = [hydro.body{i}];
        Y(3,i,:) = squeeze(hydro.A(a+5,a+5,:));
        Legends{3,i} = [hydro.body{i}];
        a = a + m;
    end
    
    Notes = {'Notes:',...
        ['$$\bullet$$ $$\bar{A}_{i,j}(\omega)$$ should tend towards a constant, ',...
        '$$A_{\infty}$$, within the specified $$\omega$$ range.'],...
        ['$$\bullet$$ Only $$\bar{A}_{i,j}(\omega)$$ for the surge, heave, and ',...
        'pitch DOFs are plotted here. If another DOF is significant to the system, ',...
        'that $$\bar{A}_{i,j}(\omega)$$ should also be plotted and verified before ',...
        'proceeding.']};
    if isempty(varargin)
        FormatPlot(Fig1,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes)
    end
    
    if length(varargin)==1
        try varargin{1}=varargin{1}{1}; end
        X1 = varargin{1}.w;
        Nb = varargin{1}.Nb;
        a = 0;
        for i = 1:Nb    
            m = varargin{1}.dof(i);
            Y1(1,i,:) = squeeze(varargin{1}.A(a+1,a+1,:));
            Legends{1,i+Nb} = [varargin{1}.body{i}];
            Y1(2,i,:) = squeeze(varargin{1}.A(a+3,a+3,:));
            Legends{2,i+Nb} = [varargin{1}.body{i}];
            Y1(3,i,:) = squeeze(varargin{1}.A(a+5,a+5,:));
            Legends{3,i+Nb} = [varargin{1}.body{i}];
            a = a + m;
        end
        FormatPlot(Fig1,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes,X1,Y1)    
    end
    
%     waitbar(1/6);

    saveas(Fig1,'Added_Mass.png');

end