%COMB_Bifurc_Diagrams_Vary_s.m
%This script generates bifurcation diagrams of the relative velocity 
%just before collisions occur as a function of d for the VIEH system in 
%Serdukova et al. (2019).

clc, clear all, close all

import COMB_Simulation.*
import plotter.*

name = 'hspaper';
load(name+".mat");

d_for_plot = zeros(1000000,1);
vals_for_plot = zeros(1000000,1); %Will store values of Z_dot to plot in the bifurcation
%diagrams

d_index = 0;

%NOTE: srange must be in parameters file

dimconst = M * omega^2 / pi^2 / A;

for i=1:length(srange)
    i
    s_curr = srange(i);
    %Conduct simulation

    %equ.update('length', s_curr);
    equ.s = srange(i);
    equ.d = equ.s * dimconst;
    
    simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);

    %Find top membrane collisions that happened late enough
    upper_collisions = simulation_data(simulation_data(:,6) == 1,:);
    upper_collisions = upper_collisions(upper_collisions(:,1) >= t_start_plot,:);
    w_dot_upper = upper_collisions(:,5) - upper_collisions(:,3);
    %RELATIVE VELOCITY at collisions

    %Same for bottom membrane collisions
    lower_collisions = simulation_data(simulation_data(:,6) == -1,:);
    lower_collisions = lower_collisions(lower_collisions(:,1) >= t_start_plot,:);
    w_dot_lower = lower_collisions(:,5) - lower_collisions(:,3);

    num_pts = length(w_dot_upper) + length(w_dot_lower);

    curr_len = numel(d_for_plot);
    temp = curr_len;

    while d_index + num_pts > temp
        temp = temp + 100000;
    end

    if temp > curr_len
        d_for_plot(curr_len+1:temp) = 0;
        vals_for_plot(curr_len+1:temp) = 0;
    end
    
    d_for_plot(d_index+1:d_index+num_pts) = equ.d;
    vals_for_plot(d_index+1:d_index+numel(w_dot_upper)) = w_dot_upper;
    vals_for_plot(d_index+numel(w_dot_upper)+1:d_index+num_pts) = w_dot_lower;
    
    d_index = d_index + num_pts;

    %z0 = transpose(upper_collisions(end,2:5));
    %Changes the initial condition for the next value of d to the last
    %upper collision from the previous one
end

d_for_plot = d_for_plot(d_for_plot > 0);

writematrix([d_for_plot, vals_for_plot(1:numel(d_for_plot))], 'hsbifurc.csv');