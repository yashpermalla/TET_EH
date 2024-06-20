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
c = 1 * M;%(1 * M * omega) / pi;
s = .35 * A * pi^2 / omega^2 / M; %Capsule length
%s_range = linspace(0.6, 0.1, 100) * A * pi^2 / omega^2 / M;
%srange = linspace(0.6, 0.1, 100) * A * pi^2 / omega^2 / M;
beta_range = linspace(pi/2, 0, 10);
m_range = linspace(0.4 * M, 0, 10);


%{

beta = 2*pi/7;
M = 0.1245;
m = 0.3 * M;
r = 0.5;
omega = 5 * pi;
phi = 0.8;
A = 4;
k = 0.3 * M;
c = 0.2 * M;
s = .35;

%}


equ = Equations(beta, M, m, s, r, omega, ...
                phi, A, k, c);

impart = equ.Lambda^2 - 4 * equ.kappa;

if impart < 0
    alpha = sqrt(-impart)/2;
    
else

end
%Initial state parameters

t0 = 0; %Initial time of the system
z0 = [0;0;0;0]; %Four element vector for initial state of the system at
%time t0. First element is x1(t0); second is x1_dot(t0); third is x2(t0); fourth is x2_dot(t0).

%Simulation parameters

t_end = 200; %Time at which to end the simulation
t_start_plot = 0; %Time at which to start collecting data for plots.
%Plots will only display results from between t_start_plot and t_end.

%Numerical methods parameters

h = 10^-3; %Step size used by the ODE solver
coll_etol = 10^-5; %Maximum error for computations of collision times


save('grav_nograv_timeseries.mat'); %Creates matrix file for this set of parameters that
%can be called in other files