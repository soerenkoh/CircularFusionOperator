%% \brief    Evaluate circular fusion operators
%  \details  Fusion of the headings from two different sensors.
%            Comparision between weighted and unweighted solution.
%            As well as MC Simulation to prove the results

clear all
close all
numSamples = 1e5;
% valueToInspect = linspace(1e-2,1.5,15);
valueToInspect=1./linspace(0.01,10,20); % Like Stienne

for varIdx=1:length(valueToInspect)
    
    % Parameterize
    sensors.mu(1) = pi-1;
%     sensors.var(1) = 0.3;
    sensors.var(1) = 0.5; % Like Stienne
    sensors.kappa(1) = 1/sensors.var(1);
    sensors.mu(2) = pi-1;
    sensors.var(2) = valueToInspect(varIdx);
    sensors.kappa(2) = 1/sensors.var(2);
    
    % Estimate Circular Variance
    n = 5000;
    gnn(1).samples = sensors.mu(1) + randn(1,n) .* sqrt( sensors.var(1) );
    gnn(2).samples = sensors.mu(2) + randn(1,n) .* sqrt( sensors.var(2) );
    wnn(1).samples = atan2( sin( gnn(1).samples )  ,  cos( gnn(1).samples  )  );
    wnn(2).samples = atan2( sin( gnn(2).samples )  ,  cos( gnn(2).samples  )  );
    vmn(1).samples = vonMises.vmrand( sensors.mu(1), sensors.kappa(1), [1,n] );
    vmn(2).samples = vonMises.vmrand( sensors.mu(2), sensors.kappa(2), [1,n] );
    
    vm.circVar(1) = circular.estCircularVariance( vmn(1).samples );
    vm.circVar(2) = circular.estCircularVariance( vmn(2).samples );
    wn.circVar(1) = circular.estCircularVariance( wnn(1).samples );
    wn.circVar(2) = circular.estCircularVariance( wnn(2).samples );
    
    for mcIdx = 1:numSamples
        
        % Sample Distributions
        gn.samples(1) = sensors.mu(1) + randn(1) * sqrt( sensors.var(1) );
        gn.samples(2) = sensors.mu(2) + randn(1) * sqrt( sensors.var(2) );
        wn.samples(1) = atan2( sin( gn.samples(1) )  ,  cos( gn.samples(1)  )  );
        wn.samples(2) = atan2( sin( gn.samples(2) )  ,  cos( gn.samples(2)  )  );
        vm.samples(1) = vonMises.vmrand( sensors.mu(1), sensors.kappa(1), [1,1] );
        vm.samples(2) = vonMises.vmrand( sensors.mu(2), sensors.kappa(2), [1,1] );
        
        % Estimate Mean
        gn.est.mean( mcIdx ) = mean( gn.samples );
        wn.est.mean( mcIdx ) = circular.estCircularMean( wn.samples );
        vm.est.mean( mcIdx ) = circular.estCircularMean( vm.samples );
        
        % Estimate Weighted Mean
        gn.est.meanWeighted( mcIdx ) = gaussian.estWeightedMean( gn.samples, sensors.var );
        wn.est.meanWeighted( mcIdx ) = circular.estCircularWeightedMean( wn.samples, sensors.var );
        vm.est.meanWeighted( mcIdx ) = circular.estCircularWeightedMean( vm.samples, sensors.var );
        
        % Estimate Variance of von Mises
%         vm.est.kappa(mcIdx) = vonMises.fuseKappaVonMisesWeighted( vm.samples, [1 1] );
%         vm.est.kappaWeighted(mcIdx) = vonMises.fuseKappaVonMisesWeighted( vm.samples, sensors.kappa );
%         vm.est.var(mcIdx) = 1 ./ vm.est.kappa(mcIdx);
%         vm.est.varWeighted(mcIdx) = 1 ./ vm.est.kappaWeighted(mcIdx);
        
    end
    %% Extract MC Values
    gn.mc.var( varIdx ) = wrappedNormal.estVarWrappedNormal( gn.est.mean );
    wn.mc.var( varIdx ) = wrappedNormal.estVarWrappedNormal( wn.est.mean );
%     vm.mc.var( varIdx ) = estCircularMean( vm.est.mean );
    vm.mc.kappa( varIdx ) = vonMises.estKappaVonMises( vm.est.mean );
    vm.mc.circVar( varIdx ) = circular.estCircularVariance( vm.est.mean );
    wn.mc.circVar( varIdx ) = circular.estCircularVariance( wn.est.mean );
    vm.mc.var( varIdx ) = 1 ./ vm.mc.kappa( varIdx );
    
    gn.mc.varWeighted( varIdx ) = wrappedNormal.estVarWrappedNormal( gn.est.meanWeighted );
    wn.mc.varWeighted( varIdx ) = wrappedNormal.estVarWrappedNormal( wn.est.meanWeighted );
%     vm.mc.varWeighted( varIdx ) = estCircularMean( vm.est.varWeighted );
    vm.mc.kappaWeighted( varIdx ) = vonMises.estKappaVonMises( vm.est.meanWeighted );
    vm.mc.circVarWeighted( varIdx ) = circular.estCircularVariance( vm.est.meanWeighted );
    wn.mc.circVarWeighted( varIdx ) = circular.estCircularVariance( wn.est.meanWeighted );
    
    vm.mc.varWeighted( varIdx ) =  1 ./ vm.mc.kappaWeighted( varIdx );
    
    %% Extract theoretical values
    % Fuse Variance
    gn.theo.var( varIdx ) = gaussian.fuseVariance( sensors.var );
    wn.theo.var( varIdx ) = gaussian.fuseVariance( sensors.var );
    vm.theo.kappa( varIdx ) = gaussian.fuseVariance( 1 ./ sensors.kappa );
    vm.theo.var( varIdx ) = 1 / vm.theo.kappa( varIdx );
    vm.theo.var( varIdx ) = gaussian.fuseVariance( 1 ./ sensors.kappa );
    
   
    vm.theo.circVar( varIdx ) = gaussian.fuseVariance( vm.circVar );
    wn.theo.circVar( varIdx ) = gaussian.fuseVariance( wn.circVar );
    
    vm.sensor(1).circVar(varIdx) = vm.circVar(1);
    vm.sensor(2).circVar(varIdx) = vm.circVar(2);
    
    wn.sensor(1).circVar(varIdx) = wn.circVar(1);
    wn.sensor(2).circVar(varIdx) = wn.circVar(2);
    
    % Fuse Variance (weighted samples)
    gn.theo.varWeighted( varIdx ) = gaussian.fuseVarianceWeighted( sensors.var );
    wn.theo.varWeighted( varIdx ) = gaussian.fuseVarianceWeighted( sensors.var );
    
    vm.theo.circVarWeighted( varIdx ) = gaussian.fuseVarianceWeighted( vm.circVar );
    wn.theo.circVarWeighted( varIdx ) = gaussian.fuseVarianceWeighted( wn.circVar );
   
%     vm.theo.kappaWeighted( varIdx ) =  1 ./ fuseVarianceNormalWeighted( 1./sensors.kappa );
    vm.theo.kappaWeighted( varIdx ) =  sum( sensors.kappa );
%     vm.theo.kappaWeighted1( varIdx ) = vonMises.fuseKappaVonMisesWeighted( sensors.mu, sensors.kappa );
    
    
    vm.theo.varWeighted( varIdx ) = 1 / vm.theo.kappaWeighted( varIdx );
%     vm.theo.varWeighted1( varIdx ) = 1 / vm.theo.kappaWeighted1( varIdx );
end

%%
figure(1) % Normal
plot(valueToInspect, gn.mc.var, valueToInspect, gn.mc.varWeighted, valueToInspect, gn.theo.var, valueToInspect, gn.theo.varWeighted)
legend('MC', 'MC weighted', 'estimate', 'estimate weighted','interpreter','latex')
ylabel([{'Fused Dispersion'}; {'$$\sigma^2_{fused} \hat{=} 1/\kappa_{fused}$$'}],'interpreter','latex')
xlabel('Dispersion $$\sigma^2_{Sensor 2} \hat{=} 1/\kappa_{Sensor 2}$$ ','interpreter','latex')
title('Mean $$\mu = \pi-0.1$$, Dispersion $$\sigma_{Sensor 1}= 0.3$$','interpreter','latex')
style.plotSK(gcf)

figure(2) % WrappedNormal
plot(valueToInspect, wn.mc.var, valueToInspect, wn.mc.varWeighted, valueToInspect, wn.theo.var, valueToInspect, wn.theo.varWeighted, valueToInspect, vm.theo.varWeighted)
legend('MC', 'MC weighted', 'estimate', 'estimate weighted','interpreter','latex')
ylabel([{'Fused Dispersion'}; {'$$\sigma^2_{fused} \hat{=} 1/\kappa_{fused}$$ [rad$$^2$$]'}],'interpreter','latex')
xlabel('Dispersion $$\sigma^2_{Sensor 2} \hat{=} 1/\kappa_{Sensor 2}$$ [rad$$^2$$]','interpreter','latex')
title('Mean $$\mu = \pi-0.1$$, Dispersion $$\sigma_{Sensor 1}= 0.3$$ rad$$^2$$','interpreter','latex')
style.plotSK(gcf)

% figure(3) % Von Mises
% plot(valueToInspect, vm.mc.var, valueToInspect, vm.mc.varWeighted, valueToInspect, vm.theo.var, valueToInspect, vm.theo.varWeighted, valueToInspect, vm.theo.varWeighted1)
% legend('MC', 'MC weighted', 'estimate', 'estimate weighted','interpreter','latex')
% ylabel([{'Fused Dispersion'}; {'$$\sigma^2_{fused} \hat{=} 1/\kappa_{fused}$$ [rad$$^2$$]'}],'interpreter','latex')
% xlabel('Dispersion $$\sigma^2_{Sensor 2} \hat{=} 1/\kappa_{Sensor 2}$$ [rad$$^2$$]','interpreter','latex')
% title('Mean $$\mu = \pi-0.1$$, Dispersion $$\sigma_{Sensor 1}= 0.3$$ rad$$^2$$','interpreter','latex')
% style.plotSK(gcf)

figure(4) % Von Mises like Stienne
plot( 1./valueToInspect, vm.mc.circVarWeighted, 1./valueToInspect, vm.theo.circVarWeighted, 1./valueToInspect,vm.sensor(1).circVar, 1./valueToInspect,vm.sensor(2).circVar)
legend( 'fused wavrg. MC', 'fused wavrg. analyt. [5]','Sensor 1','Sensor 2','interpreter','latex')
ylabel('Circular Variance V','interpreter','latex')
xlabel('Concentration Parameter $$\kappa$$','interpreter','latex')
% title('Mean $$\mu = \pi-0.1$$, Concentration parameter $$\kappa_{Sensor 2} = 0.5$$','interpreter','latex')
style.plotSK(gcf)

figure(8) % Wrapped Normal like Stienne
plot( 1./valueToInspect, wn.mc.circVarWeighted, 1./valueToInspect, wn.theo.circVarWeighted, 1./valueToInspect,wn.sensor(1).circVar, 1./valueToInspect,wn.sensor(2).circVar)
legend( 'Fusion MC', 'Fusion V$$_c$$ Estimator', 'Sensor 1','Sensor 2','interpreter','latex')
ylabel('Circular Variance V$$_c$$','interpreter','latex')
xlabel('Concentration Parameter $$\kappa_{Sensor 2}$$','interpreter','latex')
title('Mean $$\mu = \pi-0.1$$, Concentration parameter $$\kappa_{Sensor 2} = 0.5$$','interpreter','latex')
style.plotSK(gcf)


figure(5) % Von Mises Circ Var
plot(valueToInspect, vm.mc.circVar, valueToInspect, vm.mc.circVarWeighted, valueToInspect, vm.theo.circVar, valueToInspect, vm.theo.circVarWeighted)
legend('MC', 'MC weighted', 'estimate', 'estimate weighted','interpreter','latex')
ylabel([{'Fused Variance'}, {'$$V_{fused}$$'}],'interpreter','latex')
xlabel('Dispersion $$\sigma^2_{Sensor 2}$$','interpreter','latex')
title('Mean $$\mu = \pi-0.1$$, Circular Variance $$V_{Sensor 1}= 0.17$$','interpreter','latex')
style.plotSK(gcf)

figure(6) % Wrapped Normal Circ Var
plot(valueToInspect, wn.mc.circVar, valueToInspect, wn.mc.circVarWeighted, valueToInspect, wn.theo.circVar, valueToInspect, wn.theo.circVarWeighted)
legend('MC', 'MC weighted', 'estimate', 'estimate weighted','interpreter','latex')
ylabel([{'Fused Variance'}, {'$$V_{fused}$$'}],'interpreter','latex')
xlabel('Dispersion $$\sigma^2_{Sensor 2}$$','interpreter','latex')
title('Mean $$\mu = \pi-0.1$$, Circular Variance $$V_{Sensor 1}= 0.13$$','interpreter','latex')
style.plotSK(gcf)


figure(7) % Von Mises & Wrapped Normal
plot( valueToInspect, vm.theo.var, valueToInspect, vm.mc.var, valueToInspect, wn.mc.var, valueToInspect, vm.theo.varWeighted,  valueToInspect, vm.mc.varWeighted,  valueToInspect, wn.mc.varWeighted)
legend('mean analyt.','$$\mathcal{VM}$$ mean MC', '$$\mathcal{WN}$$ mean MC', 'wavrg. analyt.', '$$\mathcal{VM}$$ wavrg MC',  '$$\mathcal{WN}$$ wavrg MC ', 'interpreter', 'latex')
ylabel([{'Dispersion of fused measurements'}; {'$$\sigma^2_\mathrm{fused} \hat{=} 1/\kappa_\mathrm{fused}$$ [rad$$^2$$]'}],'interpreter','latex')
xlabel('Dispersion of measurement $$\sigma^2_{\mathrm{Sensor 2}} \hat{=} 1/\kappa_\mathrm{Sensor2}$$ [rad$$^2$$]','interpreter','latex')
%title('Mean $$\mu = \pi-0.1$$, Dispersion $$\sigma_{Sensor 1}= 0.3$$ rad$$^2$$','interpreter','latex')
ylim([0 0.6])
xlim([0 1.5])
h = findobj(gca,'Type','line');
h(1).LineStyle = '--';
h(2).LineStyle = ':';
h(3).LineStyle = '-';
h(4).LineStyle = '--';
h(5).LineStyle = ':';
h(6).LineStyle = '-';
style.plotSK(gcf)



