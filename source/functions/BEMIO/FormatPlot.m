function FormatPlot(fig,heading,subtitle,x_lables,y_lables,X_data,Y_data,legends,notes,varargin)

% Heading
annotation(fig,'textbox',[0.0 0.9 1.0 0.1],...
    'String',heading,...
    'Interpreter','latex',...
    'HorizontalAlignment','center',...
    'FitBoxToText','off',...
    'FontWeight','bold',...
    'FontSize',12,...
    'EdgeColor','none');

% Figures
[p,b,s]=size(Y_data);
for i = 1:b
    subplot('Position',[0.0731 0.3645 0.2521 0.4720])
    hold('on');
    box('on');
    plot(X_data,squeeze(Y_data(1,i,:)),'LineWidth',1); 
    hold on
    if ~isempty(varargin)
        plot(varargin{1},squeeze(varargin{2}(1,i,:)),'LineWidth',1) 
    end
    if i==b
        legend(legends(1,:),'location','best','Box','off','Interpreter','none')
        title(subtitle(1));
        xlabel(x_lables(1),'Interpreter','latex');
        ylabel(y_lables(1),'Interpreter','latex');    
    end
    
    subplot('Position',[0.3983 0.3645 0.2521 0.4720]);
    hold('on');
    box('on');
    plot(X_data,squeeze(Y_data(2,i,:)),'LineWidth',1);  
    hold on
    if ~isempty(varargin)
        plot(varargin{1},squeeze(varargin{2}(2,i,:)),'LineWidth',1);  %,'Parent',axes2);
    end
    if i==b
        legend(legends(2,:),'location','best','Box','off','Interpreter','none')
        title(subtitle(2));
        xlabel(x_lables(2),'Interpreter','latex');
        ylabel(y_lables(2),'Interpreter','latex');
    end
    
    subplot('Position',[0.7235 0.3645 0.2521 0.4720]);
    hold('on');
    box('on');
    plot(X_data,squeeze(Y_data(3,i,:)),'LineWidth',1);  %,'Parent',axes3);
    hold on
    if ~isempty(varargin)
        plot(varargin{1},squeeze(varargin{2}(3,i,:)),'LineWidth',1);  %,'Parent',axes3);    
    end
    if i==b
        legend(legends(3,:),'location','best','Box','off','Interpreter','none')
        title(subtitle(3));
        xlabel(x_lables(3),'Interpreter','latex');
        ylabel(y_lables(3),'Interpreter','latex');
    end
end

% Footer
annotation(fig,'textbox',[0.0 0.0 1.0 0.2628],...
    'String',notes,...
    'Interpreter','latex',...
    'FitBoxToText','off',...
    'EdgeColor','none');

end