M = readmatrix("eta_omega_combined_heuristics.csv");
%M = readmatrix("beta_eta_combined_heuristics.csv");


massratio = M(:,1);
frequency = M(:,2) / (2 * pi);

%inclination = M(:,1) * 180/pi;
%massratio = M(:,2);

energy = M(:,3) / 1000;
ratio = M(:,4);
disp = M(:,5);

tiledlayout(3,1)

% Bottom plot
nexttile

scatter3(frequency, massratio, energy, 'filled');
%scatter3(inclination, massratio, energy, 'filled');

title('Energy Harvesting')

xlabel('Frequency (Hz)');
%xlabel('Inclination (degrees)');

ylabel('Mass ratio');
zlabel('Average energy produced per collision (V)')

% Top plot
nexttile

scatter3(frequency, massratio, ratio, 'filled');
%scatter3(inclination, massratio, ratio, 'filled');

title('Ball:System KE ratio')

xlabel('Frequency (Hz)');
%xlabel('Inclination (degrees)');

ylabel('Mass ratio');
zlabel('Energy ratio')

% Middle plot
nexttile

scatter3(frequency, massratio, disp, 'filled');
%scatter3(inclination, massratio, disp, 'filled');

title('Maximum displacement')

xlabel('Frequency (Hz)');
%xlabel('Inclination (degrees)');


ylabel('Mass ratio');
zlabel('Displacement (m)')
