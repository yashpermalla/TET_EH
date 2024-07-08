function U_ave = Energy_output(v, m)

    h = 2.6;
    K = 4.0847*10^5;
    %parameters of the elastic force of the membrane 

    R_cin = 6.3/1000; %active radius of the stretched membrane
    U_in = 2000; %constant imput voltage applied to the membrane
    r_b = 5/1000; %radius of the ball


    del = ((h+1)./(2*K) .* m .* v.^2).^(1/(h+1));
    %the largest deflection of the membrane at the ith impact

    b = 2*r_b.*(del-r_b);
    c = R_cin.^2+(del-r_b).^2;
    d = 2*R_cin.*(R_cin.^2+del.^2-2*del.*r_b).^(1/2);

    cosa = (d-b) ./ (2 * c);
    sina = (1 - cosa.^2).^(1/2);
    %sine and cosine function 

    A = 2*pi*(r_b.^2).*(1-cosa)+(pi*R_cin^2-pi*(r_b.*sina).^2)./cosa;
    %the area of the membrane in the largest deformation condition at the ith
    %impact

    U_imp = (A./(pi*(R_cin)^2)).^2 *U_in;
    %the output voltage across the deformed dialectric elastomer at the ith
    %impact.

    %U_ave = mean(U_imp)-U_in; %average 
    U_ave = mean(U_imp) - U_in;

end
