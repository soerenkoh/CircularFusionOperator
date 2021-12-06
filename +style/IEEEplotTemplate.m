%   \brief      Make plots IEEE conform.
%   \details    Set the right size, make the ticklabels & legend latex, 
%               and save as pdf.
%
%   \remark     Inspired by: Junfei Tang (2021). Figure Configuration Code 
%               (IEEE Transaction Standard) (https://www.mathworks.com/
%               matlabcentral/fileexchange/56472-figure-configuration-code
%               -ieee-transaction-standard), MATLAB Central File Exchange. 

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
 
width = 8.8 * k_scaling;
hight = width / k_width_hight;
set(fig1,'Units','centimeters');
set(fig1, 'Position', [5 5 8.8*k_scaling hight*k_scaling])

% Export pdf from plot.
FileName='vonMisesCircVarStienne'; % <-- Specify name of file here.
pos = get(fig1,'Position');
if print_enable==1
    set(fig1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
    print(gcf, '-dpdf', [FileName,'.pdf']);
end