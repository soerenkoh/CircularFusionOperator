%   \brief      Visualise von Mises and Wrapped Normal distribution
%   \details    Two plots: Compare Normal and Wrapped Normal distribution. 
%               And compare Wrapped Normal and von Mises Distribution

% Compare Normal and Wrapped Normal distribution.
sensors.var = pi;
sensors.mu = 0;
sensors.kappa = 1/sensors.var;

n = 500000;

gnn.samples = sensors.mu + randn(1,n) .* sqrt( sensors.var );
wnn.samples = atan2( sin( gnn.samples )  ,  cos( gnn.samples  )  );
vmn.samples = vonMises.vmrand( sensors.mu, sensors.kappa, [1,n] );

samples = [gnn.samples; wnn.samples; vmn.samples];

map = colormap('lines');

histogram(samples(1,:).','FaceAlpha',.5,'edgecolor','none', 'facecolor',map(1,:), 'Normalization', 'probability', 'BinWidth', 0.1)
hold on 
histogram(samples(2,:).','FaceAlpha',.5,'edgecolor','none','facecolor',map(5,:), 'Normalization', 'probability', 'BinWidth', 0.1)
hold off
xticks([-pi,0,pi])
xlim([-pi*2,pi*2])
h = gca();
h.TickLabelInterpreter = 'latex';
xticklabels(h, {'-$$\pi$$','0','$$\pi$$'})
legend('Normal', 'Wrapped Normal','interpreter','latex')
ylabel('Probability','interpreter','latex')
title('$$\sigma^2 \hat{=} 1 / \kappa = \pi$$','interpreter','latex')
style.plotSK(gcf)


% Compare Wrapped Normal and von Mises distribution
sensors.var =0.5;
sensors.mu = 0;
sensors.kappa = 1/sensors.var;

n = 500000;

gnn.samples = sensors.mu + randn(1,n) .* sqrt( sensors.var );
wnn.samples = atan2( sin( gnn.samples )  ,  cos( gnn.samples  )  );
vmn.samples = vonMises.vmrand( sensors.mu, sensors.kappa, [1,n] );

samples = [gnn.samples; wnn.samples; vmn.samples];

map = colormap('lines');

histogram(samples(2,:).','FaceAlpha',.5,'edgecolor','none','facecolor',map(5,:), 'Normalization', 'probability', 'BinWidth', 0.1)
hold on 
histogram(samples(3,:).','FaceAlpha',.5,'edgecolor','none','facecolor',map(10,:), 'Normalization', 'probability', 'BinWidth', 0.1)
hold off
h = gca();
xticks(h, [-pi,0,pi])
h.TickLabelInterpreter = 'latex';
xticklabels(h, {'-$$\pi$$','0','$$\pi$$'})

legend('Wrapped Normal', 'von Mises','interpreter','latex')
ylabel('Probability','interpreter','latex')
title('$$\sigma^2 \hat{=} 1 / \kappa = 0.5$$','interpreter','latex')
style.plotSK(gcf)

