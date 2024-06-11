z_m = []; %initialize empty vector for the kinetic energy of the capsule, 
%subject to change 
z_b = []; %initialize empty vector for the kinestic energy of the capsule, 
%subject to change

M = 3.0457;

K_m = (1/2).*M.*(z_m).^2; %kinetic energy of the capsule 

K_b = (1/2).*M.*(z_m).^2; %kinetic energy of the ball 

R = K_b./(K_m + K_b); %ratio of kinetic energy 