function plotExcitationPhase(hydro,varargin)

    B=1;  % Wave heading index
    clear X Y Legends
    Fig5 = figure('Position',[950,300,975,521]);
    Title = ['Excitation Force Phase: $$\phi_i(\omega,\beta)$$'];
    Subtitles = {'Surge','Heave','Pitch'};
    XLables = {'$$\omega (rad/s)$$','$$\omega (rad/s)$$','$$\omega (rad/s)$$'};
    YLables = {['$$\phi_1(\omega,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ})$$'],...
        ['$$\phi_3(\omega,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)'],...
        ['$$\phi_5(\omega,\beta$$',' = ',num2str(hydro.beta(B)),'$$^{\circ}$$)']};
    
    X = hydro.w;
    a = 0;
    for i = 1:hydro.Nb
        m = hydro.dof(i);
        Y(1,i,:) = squeeze(hydro.ex_ph(a+1,B,:));
        Legends{1,i} = [hydro.body{i}];
        Y(2,i,:) = squeeze(hydro.ex_ph(a+3,B,:));
        Legends{2,i} = [hydro.body{i}];
        Y(3,i,:) = squeeze(hydro.ex_ph(a+5,B,:));
        Legends{3,i} = [hydro.body{i}];
        a = a + m;
    end
    
    Notes = {''};
    
    if isempty(varargin)
        FormatPlot(Fig5,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes)
    end

    if length(varargin)==1
        try varargin{1}=varargin{1}{1}; end
        X1 = varargin{1}.w;
        a = 0;
        for i = 1:varargin{1}.Nb
            m = varargin{1}.dof(i);
            Y1(1,i,:) = squeeze(varargin{1}.ex_ph(a+1,B,:));
            Legends{1,i+2} = [varargin{1}.body{i}];
            Y1(2,i,:) = squeeze(varargin{1}.ex_ph(a+3,B,:));
            Legends{2,i+2} = [varargin{1}.body{i}];
            Y1(3,i,:) = squeeze(varargin{1}.ex_ph(a+5,B,:));
            Legends{3,i+2} = [varargin{1}.body{i}];
            a = a + m;
        end
        FormatPlot(Fig5,Title,Subtitles,XLables,YLables,X,Y,Legends,Notes,X1,Y1)  
    end    
    
%     waitbar(5/6);
saveas(Fig5,'Excitation_Phase.png');

end