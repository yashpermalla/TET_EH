v = []; %empty vector to take in velocity at each impact


h = 2.6;
K = 4.0847*10^5;
%parameters of the elastic force of the membrane 

R_cin = 6.3; %active radius of the stretched membrane
U_in = 2000; %constant imput voltage applied to the membrane
r_b = 5; %radius of the ball



g = ((h+1./(2*K)).*m.*v.^2).^(1./(h+1));
%the largest deflection of the membrane at the ith impact

f = cos(((-2.*r_b.*(g-r_b)).*(1./(2.*(R_cin^2+(g-r_b).^2).^(1/2))))+(2.*r_b.*(R_cin^2 ...
    +g.^2-2.*g.*r_b).^(1/2))./(2.*(R_cin^2+(g-r_b).^2)));
h = -cos(((-2.*r_b.*(g-r_b)).*(1./(2.*(R_cin^2+(g-r_b).^2).^(1/2))))+(2*r_b.*(R_cin^2 ...
    +g.^2-2.*g.*r_b).^(1/2))./(2.*(R_cin^2+(g-r_b).^2))+pi/2);
%angle for the argument of the sine and cosine function 

A = 2*pi*(r_b^2).*(1-f)+(pi*R_cin^2-pi.*(r_b.*h).^2)./(f);
%the area of the membrane in the largest deformation condition at the ith
%impact

U_imp = ((A/(pi*(R_cin)^2)^2)*U_in);
%the output voltage across the deformed dialectric elastomer at the ith
%impact.

U_ave = mean(U_imp)-2000; %average 
