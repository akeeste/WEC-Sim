function plotExcitationMagnitude(hydro,varargin)

    B=1;  % Wave heading index
    clear X Y Legends
    Fig4 = figure('Position',[950,500,975,521]);
    Title = ['Normalized Excitation Force Magnitude: ',...
        '$$\bar{X_i}(\omega,\beta) = {\frac{X_i(\omega,\beta)}{{\rho}g}}$$'];
    Subtitles = {'Surge','Heave','Pitch'};
    XLables = {'$$\omega (rad/s)$$','$$\omega (rad/s)$$','$$\omega (rad/s)$$'};
    YLables = {['$$\bar{X_1}(\omega,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)'],...
        ['$$\bar{X_3}(\omega,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)'],...
        ['$$\bar{X_5}(\omega,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)']};
    
    X = hydro.w;
    a = 0;
    for i = 1:hydro.Nb
        m = hydro.dof(i);
        Y(1,i,:) = squeeze(hydro.ex_ma(a+1,B,:));
        Legends{1,i} = [hydro.body{i}];
        Y(2,i,:) = squeeze(hydro.ex_ma(a+3,B,:));
        Legends{2,i} = [hydro.body{i}];
        Y(3,i,:) = squeeze(hydro.ex_ma(a+5,B,:));
        Legends{3,i} = [hydro.body{i}];
        a = a + m;
    end
    
    Notes = {''};
    
    if isempty(varargin)
        FormatPlot(Fig4,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes)
    end
    
    if length(varargin)==1
        try varargin{1}=varargin{1}{1}; end
        X1 = varargin{1}.w;
        Nb=varargin{1}.Nb;
        a = 0;
        for i = 1:Nb
            m = varargin{1}.dof(i);
            Y1(1,i,:) = squeeze(varargin{1}.ex_ma(a+1,B,:));
            Legends{1,i+Nb} = [varargin{1}.body{i}];
            Y1(2,i,:) = squeeze(varargin{1}.ex_ma(a+3,B,:));
            Legends{2,i+Nb} = [varargin{1}.body{i}];
            Y1(3,i,:) = squeeze(varargin{1}.ex_ma(a+5,B,:));
            Legends{3,i+Nb} = [varargin{1}.body{i}];
            a = a + m;
        end
        FormatPlot(Fig4,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes,X1,Y1)  
    end
   
    
%     waitbar(4/6);
    saveas(Fig4,'Excitation_Magnitude.png');

end