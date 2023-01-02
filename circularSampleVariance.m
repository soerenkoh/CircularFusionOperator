% \brief Compare different methods to determine circular sample variance of
%        von Mises and Wrapped Normal distribution.

clear all
numSamples = 1e5;
valueToInspect = 1 ./ linspace (0.02, 5, 100);

mu = 1;

for idx=1:length(valueToInspect)
    
    vm.mu = mu;
    vm.var = 1 / valueToInspect(idx);
    vm.kappa = valueToInspect(idx);
    
    wn.mu = mu;
    wn.var = 1 / valueToInspect(idx);
    wn.kappa = valueToInspect(idx);
    
    % Sampling von Mises
    vm.samples = vonMises.vmrand(vm.mu, vm.kappa, [numSamples,1]);
    % Sampling Normal Distribution
    wn.samples = wn.mu + randn(numSamples,1) * sqrt( wn.var );
    % Map Normal Distribution on Unit Circle
    wn.samples = atan2( sin( wn.samples )  ,  cos( wn.samples  )  );
    
    %% Mean
    wn.est.mu(idx,1) = circular.estCircularMean( wn.samples );
    vm.est.mu(idx,1) = circular.estCircularMean( vm.samples );
    
    %% Variance
    % Wrapped Normal
    wn.est.varStupavsky(idx,1) = circular.estVarStupavsky( wn.samples );
    wn.est.varWN(idx,1) = wrappedNormal.estVarWrappedNormal( wn.samples );

    % von Mises
    vm.est.varStupavsky(idx,1) = circular.estVarStupavsky( vm.samples );
    vm.est.kappaSra(idx,1) = vonMises.estKappaVonMises( vm.samples );
    
end
%%
figure(1)
plot(1./valueToInspect, wn.est.varStupavsky, ...
    1./valueToInspect, wn.est.varWN, ...
    1./valueToInspect, vm.est.varStupavsky, ...
    1./valueToInspect, 1 ./ vm.est.kappaSra)
legend('$$\mathcal{WN}$$ - Stupavsky (9)',...
       '$$\mathcal{WN}$$ - Kutil (12)',...
       '$$\mathcal{VM}$$ - Stupavsky (9)',...
       '$$\mathcal{VM}$$ - Banerjee (13)', 'Interpreter', 'Latex')
ylabel([{'Estimated Dispersion'},{'$$\hat{\sigma}^2$$ $$\hat{=}$$ $$1/\hat{\kappa}$$ [rad$$^2$$]'}], 'Interpreter','Latex')
xlabel('Dispersion $$\sigma^2$$ $$\hat{=}$$ $$1/\kappa$$ [rad$$^2$$]', 'Interpreter','Latex')
% ylim([0 5])
% xlim([0 5])
style.plotSK(gcf)
    

