M = readmatrix("beta_energy_plots_varied_A_5.7.csv");


freqs = M(:,1) * 180/pi;
ratio = M(:,2);
energy = M(:,3) / 1000;
disp = M(:,4);

tiledlayout(3,1)

% Bottom plot
nexttile
scatter(freqs,energy)
title('Energy Harvesting')
xlabel('Inclination angle (degrees)');
ylabel('Average energy produced per collision (V)')

% Top plot
nexttile
scatter(freqs,ratio)
title('Ball:System KE ratio')
xlabel('Inclination angle (degrees)');
ylabel('Energy ratio')

% Middle plot
nexttile
scatter(freqs,disp)
title('Maximum displacement')
xlabel('Inclination angle (degrees)');
ylabel('Displacement (m)')
