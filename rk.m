function [mat] = rk(equ, z, h, ti, t_end, coll_etol)
% Simulates via RK4 algorithm.
% df takes in (t, [x1, x1 dot, x2, x2 dot])
% z is initial [x1, x1 dot, x2, x2 dot]
% dotoutputs 4-by-1 vector [dx1, dx1 dot, dx2, dx2 dot]
% collisionf takes in [x1dot old, x2dot old] and outputs news

d = equ.d;

numiter = (t_end - ti)/h;

mat = zeros(numiter,6);

mat(1,:) = [ti, z(1), z(2), z(3), z(4), 0];

mat(:,1) = linspace(ti, t_end, numiter);



for i=2:numiter

    currarr = [mat(i-1,2); mat(i-1,3); mat(i-1,4); mat(i-1,5)];

    k1 = equ.between_impacts_motion(mat(i-1, 1), currarr);
    k2 = equ.between_impacts_motion(mat(i-1, 1) + h/2, currarr + h * k1/2);
    k3 = equ.between_impacts_motion(mat(i-1, 1) + h/2, currarr + h * k2/2);
    k4 = equ.between_impacts_motion(mat(i-1, 1) + h, currarr + h * k3);


    y = currarr + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    mat(i, 2) = y(1);
    mat(i, 3) = y(2);
    mat(i, 4) = y(3);
    mat(i, 5) = y(4);

    if (abs(y(1) - y(3)) > d/2 + 10^-5)

        yold = currarr;

        left = mat(i-1,1);

        right = mat(i,1);

        mid = (right + left)/2;

        bis_h = mid - left;

        while (right - left) > coll_etol

            k1 = equ.between_impacts_motion(left, yold);
            k2 = equ.between_impacts_motion(left + bis_h/2, yold + bis_h * k1/2);
            k3 = equ.between_impacts_motion(left + bis_h/2, yold + bis_h * k2/2);
            k4 = equ.between_impacts_motion(left + bis_h, yold + bis_h * k3);

            ynew = yold + bis_h/6 * (k1 + 2*k2 + 2*k3 + k4);
            
            if (abs(ynew(1)-ynew(3)) > d/2)

                right = mid;

            else
                
                yold = ynew;
                left = mid;

            end

            mid = (left + right)/2;

            bis_h = mid - left;

        end

        mat(i,1) = mid;

        [mat(i,3), mat(i,5)] = equ.collision_update([mat(i-1,3); mat(i-1,5)]);

        mat(i,2) = ynew(1);
        mat(i,4) = ynew(3);

        if (y(1) - y(3) > d/2)
            mat(i,4) = mat(i,2) - d/2; %Keeps the ball in
            mat(i-1,6) = -1;
        else
            mat(i,4) = mat(i,2) + d/2;
            mat(i-1,6) = 1;
        end

    end 

end


end