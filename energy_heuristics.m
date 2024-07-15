%COMB_Bifurc_Diagrams_Vary_s.m
%This script generates bifurcation diagrams of the relative velocity 
%just before collisions occur as a function of d for the VIEH system in 
%Serdukova et al. (2019).

clc, clear all, close all

%CHANGE
load("kys.mat");


%CHANGE
varying_param = beta_range';

ratio_for_plot = zeros(numel(varying_param),1);
energy_for_plot = zeros(numel(varying_param),1);
disp_for_plot = zeros(numel(varying_param),1);

%NOTE: srange must be in parameters file

for i=1:length(varying_param)
    i
    %Conduct simulation

    %CHANGE
    equ.beta = varying_param(i);
    equ.A = 5 * cos(equ.beta);
                                     
    equ.recalibrate();
    
    simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);

    vel_conversion = equ.A * pi / equ.M / equ.omega;
    dist_conversion = equ.A * pi^2 / equ.M / equ.omega^2;


    %Find collisions that happened late enough
    simulation_data = simulation_data(simulation_data(:,1) >= t_start_plot,:);
    collisions = simulation_data(simulation_data(:,6) ~= 0,:);


    w_dot = (collisions(:,3) - collisions(:,5)) * vel_conversion;

    %RELATIVE VELOCITY at collisions

    ball_vel_energy = equ.m * sum(simulation_data(:,5).^2);
    cap_vel_energy = equ.M * sum(simulation_data(:,3).^2);

    ratio_for_plot(i) = ball_vel_energy/(ball_vel_energy + cap_vel_energy);
    energy_for_plot(i) = Energy_output(w_dot, equ.m);
    disp_for_plot(i) = max(abs(simulation_data(:,2))) * dist_conversion;

    

    %z0 = transpose(upper_collisions(end,2:5));
    %Changes the initial condition for the next value of d to the last
    %upper collision from the previous one
end

writematrix([varying_param, ratio_for_plot, energy_for_plot, disp_for_plot], 'beta_energy_plots_varied_A_5.7.csv');