%COMB_BallCapsuleTimeSeriesPlot
%This script generates bifurcation diagrams of Z_dot just before collisions
%occur as a function of d for the VIEH system in Serdukova et al.

clc, clear all, close all

%import COMB_Simulation.*

load('grav_nograv_timeseries.mat')

simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);

%Create time series plot of x1(t) and x2(t)
plot_time = simulation_data(:,1) - t_start_plot;
x1 = simulation_data(:,2);
x2 = simulation_data(:,4);
x1_upper = x1 + equ.d/2;
x1_lower = x1 - equ.d/2;

figure
hold on
plot(plot_time, x1_upper, "LineWidth", 1.5, "Color", "blue")
plot(plot_time, x1_lower, "LineWidth", 1.5, "Color", "blue")
plot(plot_time, x2, "LineWidth", 1.5, "Color", "red")
title('Ball-and-Capsule Plot')
xlabel('$t$', 'Interpreter','latex')
ylabel('$w$', 'Interpreter', 'latex')
xlim([0 t_end - t_start_plot])
