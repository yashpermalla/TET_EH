M = readmatrix("eta_energy_plots.csv");


freqs = M(:,1) / .1245;
ratio = M(:,2);
energy = M(:,3) / 1000;
disp = M(:,4);

tiledlayout(3,1)

% Bottom plot
nexttile
scatter(freqs,energy)
title('Energy Harvesting')
xlabel('Mass ratio');
ylabel('Average energy produced per collision (V)')

% Top plot
nexttile
scatter(freqs,ratio)
title('Ball:System KE ratio')
xlabel('Mass ratio');
ylabel('Energy ratio')

% Middle plot
nexttile
scatter(freqs,disp)
title('Maximum displacement')
xlabel('Mass ratio');
ylabel('Displacement (m)')
