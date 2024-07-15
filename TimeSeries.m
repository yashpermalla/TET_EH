%COMB_TimeSeries
%This script generates time series plots of x_1 - x_2, x_1_dot - x_2_dot as 
%a function of t for the VIEH system in Serdukova et al.

clc, clear all, close all


%**run params.m before proceeding**
load("kys.mat")

%Conduct simulation
simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);

%Create time series plot of Z(t) and Z_dot(t)
time = simulation_data(:,1);
x1 = simulation_data(:,2);
x1_dot = simulation_data(:,3);
x2 = simulation_data(:,4);
x2_dot = simulation_data(:,5);

w = (x1-x2) * equ.A * pi^2 / equ.M / equ.omega^2;
w_dot = (x1_dot-x2_dot) * equ.A * pi / equ.M / equ.omega;

figure
hold on
set(gcf,'position',[200,200,1100,1100])
tiledlayout(2,2);

%x_1/t plot
nexttile
plot(time, w , "LineWidth", 1.5)
title('$w(t)$ vs. $t$', 'Interpreter', 'latex')
xlabel('$t$', 'Interpreter','latex')
ylabel('$w(t)$', 'Interpreter', 'latex')
axis([t_start_plot t_end 1.2*min(w) 1.2*max(w)])

%x_1_dot/t plot
nexttile
plot(time, w_dot, "LineWidth", 1.5)
title('$\dot{w}(t)$ vs. $t$', 'Interpreter', 'latex')
xlabel('$t$', 'Interpreter','latex')
ylabel('$\dot{w}(t)$', 'Interpreter', 'latex')
axis([t_start_plot t_end 1.2*min(w_dot) 1.2*max(w_dot)])

equ.d

%x_2/t plot
%nexttile
%plot(time, x2, "LineWidth", 1.5)
%title('$x_{2}(t)$ vs. $t$', 'Interpreter', 'latex')
%xlabel('$t$', 'Interpreter','latex')
%ylabel('$Z(t)$', 'Interpreter', 'latex')
%axis([t_start_plot t_end 1.2*min(x2) 1.2*max(x2)])

%x_2_dot/t plot
%nexttile
%plot(time, x2_dot, "LineWidth", 1.5)
%title('$\dot{x_{2}}(t)$ vs. $t$', 'Interpreter', 'latex')
%xlabel('$t$', 'Interpreter','latex')
%ylabel('$\dot{Z}(t)$', 'Interpreter', 'latex')
%axis([t_start_plot t_end 1.2*min(x2_dot) 1.2*max(x2_dot)])

hold off
