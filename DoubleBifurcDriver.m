M = readmatrix("eta_beta_jointvaried_combined_heuristics.csv");
x = M(:,1) * 180/pi;
y = M(:,2);

xlab = 'Mass ratio';
ylab = 'Inclination (degrees)';


energy = M(:,3) / 1000;
ratio = M(:,4);
disp = M(:,5);

tiledlayout(3,1)

% Bottom plot
nexttile

scatter3(x, y, energy, 'filled');

title('Energy Harvesting')

xlabel(xlab);
ylabel(ylab);
zlabel('Average energy produced per collision (V)')

% Top plot
nexttile

scatter3(x, y, ratio, 'filled');

title('Ball:System KE ratio')

xlabel(xlab);
ylabel(ylab);
zlabel('Energy ratio')

% Middle plot
nexttile

scatter3(x, y, disp, 'filled');

title('Maximum displacement')

xlabel(xlab);
ylabel(ylab);
zlabel('Displacement (m)')
