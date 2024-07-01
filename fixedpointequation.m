syms 
%set up know parameters 
T = 2;
lambda = 1;
gbar = 3;
r = 0.5;
b_1 = (-pi^2 + kappa) ./ ((lambda .^2).*(pi^2) + pi^4 - 2*pi^2.*kappa ...
    + kappa.^2);
b_2 = (lambda .* pi)./((lambda .^2).*pi^2 + pi^4 - 2.* kappa *pi^2 ...
    + kappa.^2);
%set up matrices for unknown variables
q_1dot = [];
q_2 = [];
q_2dot = [];
q_1 = [];
R = []; 
B = [];
t = [];
%%%%%%% 
%intermediate values
e = (exp(lambda .* t ./ 2) ./ a);
d = (1-eta .* r)./ (1 + eta) .* q_1dot + (eta .*(1+r))./ (1 + eta) .* v_2 ...
    + gbar.*(delt) - pi* b_1.* cos(pi .* t + phi) + pi .* b_2 .* cos(pi .* t + phi) ;
c = q_1 - b_1 .* sin(pi .* t + phi) - b_2 .* cos(pi .* t + phi);

%coefficents 
A_1 = e .*...
    (d .* (cos(a .*t))...
    - (c).*(- lambda ./ 2 .* cos(a .* t) - a ...
    .* sin(a .*t)));
%first coefficient
A_2 = (e) .* ((c.*(- lambda ./ 2 ...
    .* sin(a .* t) + a .* cos(a .*t))) - d.*(sin(a .* t)));
%second coefficient
%%%%%%%%%%
for eta = 0.1
    %general equations
    t(3) = t(1) + T;
    q_1(1) = q_1(3);
    q_2(1) = q_1(3);
    q_1dot(1) = q_1dot(3);
    q_2dot(1) = q_2dot(3);
    %first cycle equations 
    q_1(2) = q_2(2) - (d ./2);
    q_1(1) = q_2(1) + (d ./ 2);
    P = A_1 .* exp(- lambda .* t(2) ./ 2) .* sin(a .* t(2)) + A_2...
        .* exp(- lambda .* t(2) ./ 2) .* cos(a .* t(2)) + b_1 .* sin(pi .* t(2) + phi) ...
        + b_2 .* cos(pi . t(2) + phi)-q_1(2);
    Q = A_1 .* exp(- lambda .* t(2) ./ 2) .* (-lambda ./ 2 .*sin(a .* t(2)) + ...
        a .* cos(a .*t(2))) + A_2 .* exp(- lambda .* t(2) ./ 2) .* (- lambda ./2 ...
        .* cos(a .* t(2))- a .* sin(a .* t(2))) + b_1 .* pi .* cos(pi .* t(2) + phi)...
        - b_2 .* pi .* sin(pi .* t(2) + phi)- q_1dot(2);
    S = q_2(1)+((1 + r) ./(1 + eta) * q_1(1) + (eta - r) ./ (1 + eta) .* q_2dot(1))...
        .* (t(2)-t(1)) - gbar ./ 2 .* (t(2)-t(1)).^2 q_2(2);
    U = (1 + r) ./(1 + eta) * q_1(1) + (eta - r) ./ (1 + eta) .* q_2dot(1)...
        - gbar .* (t(2)-t(1)) - q_2dot (2);
    %second cycle equations 
    V = A_1 .* exp(- lambda .* t(3) ./ 2) .* sin(a .* t(3)) + A_2...
        .* exp(- lambda .* t(3) ./ 2) .* cos(a .* t(3)) + b_1 .* sin(pi .* t(3) + phi) ...
        + b_2 .* cos(pi . t(3) + phi) - q_1(3);
    H = A_1 .* exp(- lambda .* t(3) ./ 2) .* (-lambda ./ 2 .*sin(a .* t(3)) + ...
        a .* cos(a .*t(3))) + A_2 .* exp(- lambda .* t(3) ./ 2) .* (- lambda ./2 ...
        .* cos(a .* t(3))- a .* sin(a .* t(3))) + b_1 .* pi .* cos(pi .* t(3) + phi)...
        - b_2 .* pi .* sin(pi .* t(3) + phi) - q_1dot(3);
    X = q_2(2)+((1 + r) ./(1 + eta) * q_1(2) + (eta - r) ./ (1 + eta) .* q_2dot(2))...
        .* (t(3)-t(2)) - gbar ./ 2 .* (t(3)-t(2)).^2 - q_2(3);
    Z = (1 + r) ./(1 + eta) * q_1(2) + (eta - r) ./ (1 + eta) .* q_2dot(2)...
        - gbar .* (t(3)-t(2)) - q_2dot (3);
    %plug  the points into the jacobian and find eigenvalues 
    %find and call product of eigenvalues (E?)
    %%%%%%%%%%%%%
    % if E < 1
    %     R(1,end+1)
    % elseif E > 1
    %     B(1,end+1)
    % 
    % end
end

