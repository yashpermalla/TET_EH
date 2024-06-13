%PARAMS Parameters that must be input by the user for the combined system.

%System parameters

clc, clear all, close all


beta = pi/3; %Angle from horizontal
M = 0.1245; %Capsule mass
m = 0.2*M; %Ball mass
r = 0.5; %Restitution coefficient
omega = 5 * pi; %Forcing frequency
phi = 0.8; %Forcing phase
A = 5; %Forcing amplitude
k = M;%25 * M;
c = 1;%(1 * M * omega) / pi;
s = .5 * A * pi^2 / omega^2 / M; %Capsule length
srange = linspace(0.6, 0.1, 100) * A * pi^2 / omega^2 / M;


equ = Equations(beta, M, m, s, r, omega, ...
                phi, A, k, c);


%Initial state parameters

t0 = 0; %Initial time of the system
z0 = [equ.d/2;.7;0;0]; %Four element vector for initial state of the system at
%time t0. First element is x1(t0); second is x1_dot(t0); third is x2(t0); fourth is x2_dot(t0).

%Simulation parameters

t_end = 5000; %Time at which to end the simulation
t_start_plot = 4900; %Time at which to start collecting data for plots.
%Plots will only display results from between t_start_plot and t_end.

%Numerical methods parameters

h = 10^-3; %Step size used by the ODE solver
coll_etol = 10^-5; %Maximum error for computations of collision times


save('hspaper.mat'); %Creates matrix file for this set of parameters that
%can be called in other files