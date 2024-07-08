%COMB_Bifurc_Diagrams_Vary_s.m
%This script generates bifurcation diagrams of the relative velocity 
%just before collisions occur as a function of d for the VIEH system in 
%Serdukova et al. (2019).

clc, clear all, close all

import COMB_Simulation.*
import plotter.*


%CHANGE
name = 'kys';
load(name+".mat");

param_for_plot = zeros(10000000,1);
vals_for_plot = zeros(10000000,1); %Will store values of Z_dot to plot in the bifurcation
%diagrams

%CHANGE
varying_param = m_range';

param_index = 0;

%NOTE: srange must be in parameters file

for i=1:length(varying_param)
    i
    %Conduct simulation

    %equ.update('length', s_curr);

    %CHANGE
    equ.m = varying_param(i);
    equ.recalibrate();
    
    simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);

    %Find top membrane collisions that happened late enough
    simulation_data = simulation_data(simulation_data(:,1) >= t_start_plot,:);
    collisions = simulation_data(simulation_data(:,6) ~= 0,:);

    w_dot = collisions(:,3) - collisions(:,5);
    %RELATIVE VELOCITY at collisions

    %Same for bottom membrane collisions


    num_pts = length(w_dot);

    curr_len = numel(param_for_plot);
    temp = curr_len;

    while param_index + num_pts > temp
        temp = temp + 1000000;
    end

    if temp > curr_len
        param_for_plot(curr_len+1:temp) = 0;
        vals_for_plot(curr_len+1:temp) = 0;
    end
    
    param_for_plot(param_index+1:param_index+num_pts) = varying_param(i) / equ.M;
    vals_for_plot(param_index+1:param_index+num_pts) = w_dot;
    
    param_index = param_index + num_pts;

    %z0 = transpose(upper_collisions(end,2:5));
    %Changes the initial condition for the next value of d to the last
    %upper collision from the previous one
end

param_for_plot = param_for_plot(param_for_plot > 0);

writematrix([param_for_plot, vals_for_plot(1:numel(param_for_plot))], 'eta_bifurc_resonance.csv');