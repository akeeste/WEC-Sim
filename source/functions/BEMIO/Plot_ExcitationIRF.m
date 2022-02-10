function Plot_ExcitationIRF(hydro,varargin)

    B=1;  % Wave heading index
    clear X Y Legends
    Fig6 = figure('Position',[950,100,975,521]);
    Title = ['Normalized Excitation Impulse Response Functions:   ',...
        '$$\bar{K}_i(t) = {\frac{1}{2\pi}}\int_{-\infty}^{\infty}{\frac{X_i(\omega,\beta)e^{i{\omega}t}}{{\rho}g}}d\omega$$'];
    Subtitles = {'Surge','Heave','Pitch'};
    XLables = {'$$t (s)$$','$$t (s)$$','$$t (s)$$'};
    YLables = {['$$\bar{K}_1(t,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)'],...
        ['$$\bar{K}_3(t,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)'],...
        ['$$\bar{K}_5(t,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)']};
    
    X = hydro.ex_t;
    a = 0;
    for i = 1:hydro.Nb
        m = hydro.dof(i);
        Y(1,i,:) = squeeze(hydro.ex_K(a+1,B,:));
        Legends{1,i} = [hydro.body{i}];
        Y(2,i,:) = squeeze(hydro.ex_K(a+3,B,:));
        Legends{2,i} = [hydro.body{i}];
        Y(3,i,:) = squeeze(hydro.ex_K(a+5,B,:));
        Legends{3,i} = [hydro.body{i}];
        a = a + m;
    end
    
    Notes = {'Notes:',...
        ['$$\bullet$$ The IRF should tend towards zero within the specified timeframe. ',...
        'If it does not, attempt to correct this by adjusting the $$\omega$$ and ',...
        '$$t$$ range and/or step size used in the IRF calculation.'],...
        ['$$\bullet$$ Only the IRFs for the first wave heading, surge, heave, and ',...
        'pitch DOFs are plotted here. If another wave heading or DOF is significant ',...
        'to the system, that IRF should also be plotted and verified before proceeding.']};
    
    if isempty(varargin)
        FormatPlot(Fig6,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes)
    end

    
    if length(varargin)==1
        try varargin{1}=varargin{1}{1}; end
        X1 = varargin{1}.ex_t;
        a = 0;
        for i = 1:varargin{1}.Nb
            m = varargin{1}.dof(i);
            Y1(1,i,:) = squeeze(varargin{1}.ex_K(a+1,B,:));
            Legends{1,i+2} = [varargin{1}.body{i}];
            Y1(2,i,:) = squeeze(varargin{1}.ex_K(a+3,B,:));
            Legends{2,i+2} = [varargin{1}.body{i}];
            Y1(3,i,:) = squeeze(varargin{1}.ex_K(a+5,B,:));
            Legends{3,i+2} = [varargin{1}.body{i}];
            a = a + m;
        end
        FormatPlot(Fig6,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes,X1,Y1)  
    end    
    
    % waitbar(6/6);

end