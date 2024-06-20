classdef Equations < handle
    %COMB_Equations: Class defining the differential equation of motion for
    %the combined VIEH-TET model.

    properties
        %Parameters
        beta double {mustBeGreaterThanOrEqual(beta,0)}
        %Angle of the VI EH with respect to the ground. TODO: ADD THAT THIS
        %MUST BE LESS THAN OR EQUAL TO PI/2

        M double {mustBePositive}
        %Mass of the capsule

        m double {mustBeNonnegative}
        %Mass of the ball

        s double {mustBePositive}
        %dimensional length of the VI EH

        r double {mustBeNonnegative, mustBeLessThanOrEqual(r, 1)}
        %Coefficient of restitution

        omega double {mustBePositive}
        %Frequency of forcing. Period of the forcing is 2pi/omega.

        phi double
        %Phase of forcing.

        A double {mustBeNonnegative}
        %Amplitude of forcing

        k double {mustBeNonnegative}
        %Spring constant

        c double {mustBeNonnegative}
        %Damping coefficient

        eta double{mustBeNonnegative}
        %Ratio of ball mass to capsule mass

        omega0 double{mustBeNonnegative}
        %Natural frequency of the linear oscillator

        Omega double{mustBePositive}
        %Ratio of forcing frequency to natural frequency

        d double {mustBePositive}
        %Non-dimensional length of the VI EH

        Lambda double {mustBeNonnegative}
        %Non-dimensional damping

        kappa double {mustBeNonnegative}
        %Non-dimensional spring constant

        g double {mustBeNonnegative}
        %Acceleration due to gravity; should always be 9.8.

        g_bar double {mustBeNonnegative}
        %Dimensionless gravity

    end

    methods

        function obj = Equations(angle, cap_mass, ball_mass, length, ...
                rest, freq, phase, amp, spr_const, damp_coef)
        %Constructor method.
        %   angle the choice of beta.
        %   Mass the choice of M.
        %   mass the choice of m.
        %   length the choice of d.
        %   rest the choice of r.
        %   freq the choice of omega.
        %   phase the choice of phi.
        %   amp the choice of A.
        %   spr_const the choice of k
        %   damp_coef the choice of c
            obj.beta = angle;
            obj.M = cap_mass;
            obj.m = ball_mass;
            obj.s = length;
            obj.r = rest;
            obj.omega = freq;
            obj.phi = phase;
            obj.A = amp;
            obj.k = spr_const;
            obj.c = damp_coef;

            %See Overleaf files for equations here
            obj.eta = obj.m / obj.M;
            obj.omega0 = (obj.k/obj.M)^(1/2);
            obj.Omega = obj.omega/obj.omega0;
            obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
            obj.Lambda = (pi * obj.c) / (obj.M * obj.omega);
            obj.kappa = (pi / obj.Omega)^2;
            obj.g = 9.8; %Should always be 9.8
            obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
        end

        function dzdt = between_impacts_motion(obj, t, z)
        %BETWEEN_IMPACTS_MOTION Numerically simulates the first-order
        %differential equation describing Z(t) between impacts.
            %t: time.
            %z: a four-element vector. The first element represents x1(t),
            %the second x1_dot(t), the third x2(t), the fourth x2_dot(t)
            x1 = z(1);
            x1_dot = z(2);
            x2 = z(3);
            x2_dot = z(4);

            dx1 = x1_dot;
            dx1_dot = sin(pi * t + obj.phi) - obj.kappa * x1 - obj.Lambda * x1_dot; %- obj.g_bar;
            dx2 = x2_dot;
            dx2_dot = -obj.g_bar;

            dzdt = [dx1;dx1_dot;dx2;dx2_dot];
        end

        function [x1new, x2new] = collision_update(obj, xvel)
            % Computes velocities after collision based on pre-collision
            % velocities. xvel is [x1-, x2-], and we return [x1+,x2+].
            E_1 = -obj.r * (xvel(1) - xvel(2));
            E_2 = xvel(1) + obj.eta * xvel(2);
            x1new = E_1 + (E_2 - E_1)/(obj.eta + 1);
            x2new = (E_2 - E_1)/(obj.eta + 1);
        end

        function update(obj, field, val)
            switch field
                case 'angle'
                    obj.beta = val;
                    %obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
                case 'capmass'
                    obj.M = val;
                    %obj.eta = obj.m / obj.M;
                    %obj.omega0 = (obj.k/obj.M)^(1/2);
                    %obj.Omega = obj.omega/obj.omega0;
                    %obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
                    %obj.Lambda = (pi * obj.c) / (obj.M * obj.omega);
                    %obj.kappa = (pi / obj.Omega)^2;
                    %obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
                case 'length'
                    obj.s = val;
                    obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
                    return;
                case 'restitution'
                    obj.r = val;
                case 'frequency'
                    obj.omega = val;
                    %obj.eta = obj.m / obj.M;
                    %obj.omega0 = (obj.k/obj.M)^(1/2);
                    %obj.Omega = obj.omega/obj.omega0;
                    %obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
                    %obj.Lambda = (pi * obj.c) / (obj.M * obj.omega);
                    %obj.kappa = (pi / obj.Omega)^2;
                    %obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
                case 'phase'
                    obj.phi = val;
                case 'amplitude'
                    obj.A = val;
                    %obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
                    %obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
                case 'ballmass'
                    obj.m = val;
                    %obj.eta = obj.m / obj.M;
                case 'sprconst'
                    obj.k = val;
                    %obj.eta = obj.m / obj.M;
                    %obj.omega0 = (obj.k/obj.M)^(1/2);
                    %obj.Omega = obj.omega/obj.omega0;
                    %obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
                    %obj.Lambda = (pi * obj.c) / (obj.M * obj.omega);
                    %obj.kappa = (pi / obj.Omega)^2;
                    %obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
                case 'dampcoef'
                    obj.c = val;  
                    %obj.Lambda = (pi * obj.c) / (obj.M * obj.omega);

            end
            
            obj.eta = obj.m / obj.M;
            obj.omega0 = (obj.k/obj.M)^(1/2);
            obj.Omega = obj.omega/obj.omega0;
            obj.d = obj.s * obj.M * (obj.omega)^2 / pi^2 / obj.A;
            obj.Lambda = (pi * obj.c) / (obj.M * obj.omega);
            obj.kappa = (pi / obj.Omega)^2;
            obj.g_bar = obj.g * sin(obj.beta) * obj.M * (1/obj.A);
            

        end
    end
end