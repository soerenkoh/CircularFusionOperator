k_scaling=2; % A scaled-down legend looks better than a normal one. No idea why.
print_enable=1; % pdf Export
 
fig1=figure(4)

hp1 = findobj(gca,'Type','line');

leg1 = findobj(gcf, 'Type', 'Legend');
set(leg1,'Interpreter','latex');
set(leg1,'fontSize',8*k_scaling);
set(gca,'fontSize',8*k_scaling);
set(gca,'TickLabelInterpreter','latex');
set(hp1,'LineWidth',0.8* k_scaling*2);

grid on
k_width_hight = 3.3; 
% k_width_hight = 1;
% k_width_hight = 1.65;%3     % width:hight ratio of the figure
 
width = 8.8 * k_scaling;
hight = width / k_width_hight;
set(fig1,'Units','centimeters');
set(fig1, 'Position', [5 5 8.8*k_scaling hight*k_scaling])
 %%
FileName='vonMisesCircVarStienne';
pos = get(fig1,'Position');
if print_enable==1
    set(fig1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
    print(gcf, '-dpdf', [FileName,'.pdf']);
end