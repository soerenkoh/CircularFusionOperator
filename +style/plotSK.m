function plotSK(h)
% Make nice plots.
grid on 
% tmp=get(h,'Position');
tmp=[680 558 560 420];
tmp(4)=tmp(4)./1.4;
% tmp(1)=200;
% tmp(2)=200;
% tmp(3)=1000;
% tmp(4)=600;
set(h, 'Position', tmp);
%Change Linewidth
LineWidth=2;
hdl=findall(h,'type','line');
for k=1:length(hdl)
    set(hdl(k),'LineWidth',LineWidth);
end

set(h, 'Color', 'w');