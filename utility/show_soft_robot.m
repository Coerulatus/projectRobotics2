function show_soft_robot(robot,qs,link_lengths,color_type)
%SHOW_SOFT_ROBOT Plots the robot in the given configuration. 
% The qs needed are one for each link of the robots, while the lengths
% needed are one for each cc segment (3 segments for each link).
% color_type=='default' colors each segment of a different color, while
% anything else makes the whole robot black.
    n_segments = robot.NumBodies/4;
    if ~floor(n_segments)==n_segments
        disp('Error, each soft segment should be made of 4 rigid links');
        return
    end
    configuration = zeros(1,robot.NumBodies);
    for i = 1:length(qs)
        [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12] = get_pcc_qs(qs(i),link_lengths(1+(i-1)*3:i*3));
        configuration(1+(i-1)*12) = q1;
        configuration(2+(i-1)*12) = q2;
        configuration(3+(i-1)*12) = q3;
        configuration(4+(i-1)*12) = q4;
        configuration(5+(i-1)*12) = q5;
        configuration(6+(i-1)*12) = q6;
        configuration(7+(i-1)*12) = q7;
        configuration(8+(i-1)*12) = q8;
        configuration(9+(i-1)*12) = q9;
        configuration(10+(i-1)*12) = q10;
        configuration(11+(i-1)*12) = q11;
        configuration(12+(i-1)*4) = q12;
    end
    
    Ti_1 = eye(4);
    z_rot_angle_past = 0;
    for i=1:n_segments
        link_name = strcat('body',num2str(i*4));
        Ti = getTransform(robot,configuration,link_name);
        qi = qs(ceil(i/3))/3;
        Li = link_lengths(i);
        ro_i = abs(Li/qi);
        z_rot_angle = atan2(-Ti(1,2),Ti(1,1));
        z_ang_positive = z_rot_angle > z_rot_angle_past;
        z_rot_angle_past = z_rot_angle;

        [xc,yc] = get_circle_center(Ti_1(1:2,4),Ti(1:2,4),ro_i,z_ang_positive);

        if strcmp(color_type,'default')
            if i<3
                color = [1/4*mod(i,4),1/4*mod(i,4),1];
            else
                color = [1,1/4*mod(i,4),1/4*mod(i,4)];
            end
        else
            color = [0.3,0.3,0.3];
        end

        if isinf(xc) || isinf(yc)
            s = linspace(0, 1, 25);
            % draw line
            plot(Ti_1(1,4)+s*(Ti(1,4)-Ti_1(1,4)),Ti_1(2,4)+s*(Ti(2,4)-Ti_1(2,4)),'-','LineWidth',2,'Color',color);
        else
            pc = [xc,yc];
%             plot(xc,yc,'kx')
            starting_angle = atan2(Ti_1(2,4)-yc,Ti_1(1,4)-xc);
            
            draw_arc(pc,ro_i,starting_angle,starting_angle+qi,color);
        end
        Ti_1 = Ti;
    end
    axis equal;
end

