clc, clear all, close all

import COMB_Simulation.*
import plotter.*

%CHANGE
name = 'kys';
load(name+".mat");

plotmat = zeros(numel(beta_range) * numel(omega_range), 5);

%Will store values of Z_dot to plot in the bifurcation diagrams

param_index = 1;

%FIX THIS LATER
for i=1:length(omega_range)
    for j=1:length(beta_range)
        20*(i-1) + j

        %CHANGE
        equ.beta = beta_range(j);
        equ.A = 5 * cos(equ.beta);
        equ.omega = omega_range(i);

        equ.recalibrate();

        simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);

        vel_conversion = equ.A * pi / equ.M / equ.omega;
        dist_conversion = equ.A * pi^2 / equ.M / equ.omega^2;

        simulation_data = simulation_data(simulation_data(:,1) >= t_start_plot,:);
        collisions = simulation_data(simulation_data(:,6) ~= 0,:);

        w_dot = (collisions(:,3) - collisions(:,5)) * vel_conversion;

        ball_vel_energy = equ.m * sum(simulation_data(:,5).^2);
        cap_vel_energy = equ.M * sum(simulation_data(:,3).^2);

        ratioval = ball_vel_energy/(ball_vel_energy + cap_vel_energy);
        energyval = Energy_output(w_dot, equ.m);
        dispval = max(abs(simulation_data(:,2))) * dist_conversion;

        %CHANGE
        plotmat(param_index, :) = [equ.beta equ.omega energyval ratioval dispval];
        param_index = param_index + 1;

    end
end

writematrix(plotmat, 'beta_omega_jointvaried_combined_heuristics.csv');