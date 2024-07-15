%PARAMS Parameters that must be input by the user for the combined system.

%System parameters

clc, clear all, close all

beta = 0.4;
M = .1245;
m = 0.2 * M;
r = 0.5;
omega = 5*pi;
phi = 0.8;
A = 5 * cos(beta);
k = 25 * pi^2 * M;
c = M;
s = .56224;

s_range = linspace(0.6, 0.1, 50) * A * pi^2 / M / omega^2;

A_range = linspace(10, 0.4, 25);

omega_range = linspace(10*pi, pi, 20);

m_range = linspace(0.5, 0.05, 20) * M;

beta_range = linspace(1.3, pi/100, 100);

equ = Equations(beta, M, m, s, r, omega, ...
                phi, A, k, c);

%Initial state parameters

t0 = 0; %Initial time of the system

%{
const1 = equ.kappa - pi^2;
const2 = equ.Lambda * pi;

sincoeff = const1 / (const1^2 + const2^2);
coscoeff = -const2 / (const1^2 + const2^2);

capinitx = sincoeff * sin(phi) + coscoeff * cos(phi);
capinitv = sincoeff * pi * cos(phi) - coscoeff * pi * sin(phi);

ballinitx = capinitx - equ.d/2;
ballinitv = capinitv + 2 * equ.d * equ.r / (1 + equ.eta);
%}



capinitx = -sin(phi)/pi^2;
capinitv =  -cos(phi)/pi;

ballinitx = capinitx - equ.d/2;
ballinitv = capinitv + r * .6;

z0 = [capinitx;capinitv;ballinitx;ballinitv]; %Four element vector for initial state of the system at
%time t0. First element is x1(t0); second is x1_dot(t0); third is x2(t0); fourth is x2_dot(t0).

%Simulation parameters

t_end = 5000; %Time at which to end the simulation
t_start_plot = 4980; %Time at which to start collecting data for plots.
%Plots will only display results from between t_start_plot and t_end.

%Numerical methods parameters

h = 10^-3; %Step size used by the ODE solver
coll_etol = 10^-5; %Maximum error for computations of collision times


save('kys.mat'); %Creates matrix file for this set of parameters that
%can be called in other files