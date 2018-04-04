%% Experiment 3 - Statistical Analysis

sigma = rand(50,1)*8; 
% This will be the input from NIck's function, right now I am just using a
% random number generator for 0-8 MPa (50 results)

% Central Tendency:
sigma_bar = mean(sigma)  % mean
sigma_med = median(sigma)  % median

% Dispersion:
sigma_std = std(sigma)   % standard deviation
sigma_var = var(sigma)   % variance

% Weibull
sigma_dist = wblfit(sigma)

a = sigma_dist(1)
b = sigma_dist(2)

figure(1)
wblplot(sigma)
xlabel('log(\sigma_T)')
title('Weibull Probability of Concrete Tensile Strength')
