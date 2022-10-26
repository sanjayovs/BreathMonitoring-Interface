function label(varargin)
% Give in this order : type,name,namex,namey
fontSize=10;
fontSize1=10
%% For all
if(strcmp(varargin{1},'all'))
    name=varargin{2};
    namex=varargin{3};
    namey=varargin{4};
title(name,'FontName','Century Gothic','FontSize',fontSize1,...
    'FontWeight','Bold');
ylabel(namey,'FontName','Century Gothic','FontSize',fontSize1,...
    'FontWeight','Bold');
xlabel(namex,'FontName','Century Gothic','FontSize',fontSize1,...
    'FontWeight','Bold')
set(gca,'FontName','Century Gothic','FontSize',fontSize,'FontWeight','Bold');
%gca.FontSize=fontSize;
end

%% For xy
if(strcmp('xy',varargin{1}))
    namex=varargin{2};
    namey=varargin{3};
ylabel(namey,'FontName','Century Gothic','FontSize',fontSize,...
    'FontWeight','Bold');
xlabel(namex,'FontName','Century Gothic','FontSize',fontSize,...
    'FontWeight','Bold')
set(gca,'FontName','Century Gothic','FontSize',fontSize,'FontWeight','Bold');
end

%% For x
if(strcmp('x',varargin{1}))
    namex=varargin{2};
xlabel(namex,'FontName','Century Gothic','FontSize',fontSize,...
    'FontWeight','Bold');
set(gca,'FontName','Century Gothic','FontSize',fontSize,'FontWeight','Bold');
end

%% For y
if(strcmp('y',varargin{1}))
    namey=varargin{2};
ylabel(namey,'FontName','Century Gothic','FontSize',fontSize,...
    'FontWeight','Bold');
set(gca,'FontName','Century Gothic','FontSize',fontSize,'FontWeight','Bold');
end

%% For title
if(strcmp('t',varargin{1}))
    name=varargin{2};
title(name,'FontName','Century Gothic','FontSize',fontSize,...
    'FontWeight','Bold');
end
set(gca,'FontName','Century Gothic','FontSize',fontSize,'FontWeight','Bold');
end