function robot = add_soft_link(robot, current_idx, dhparams)
%ADD_LINK Each link of the robot is made up of three cc segments, each of
%them is made from 4 rigid links. The DH parameters are needed for each
%link and the current index is the idx of the last added link of the robot.

% The DH parameters for an equivalent rigid robot starting from a cc
% segment are:
% link_n | a | alpha |       d       | theta |  mu
%--------------------------------------------------
%    1   | 0 |  pi/2 |       0       |  qi/2 |  0
%    2   | 0 |   0   |Li*sin(qi/2)/qi|   0   | mu_i
%    3   | 0 | -pi/2 |Li*sin(qi/2)/qi|   0   |  0
%    4   | 0 |   0   |       0       |  qi/2 |  0
% with mu_i the mass of the link

    bodies = cell(3*4,1);
    joints = cell(3*4,1);
    idx_bodies = current_idx;
    for j=1:3
        for i = 1:4
            idx = 1+mod(idx_bodies-1,12);
            bodies{idx} = rigidBody(['body' num2str(idx_bodies)]);
            if i==1 || i==4
                joints{idx} = rigidBodyJoint(['jnt' num2str(idx_bodies)],"revolute");
            else
                joints{idx} = rigidBodyJoint(['jnt' num2str(idx_bodies)],"prismatic");
            end
            setFixedTransform(joints{idx},dhparams(idx,:),"dh");
            bodies{idx}.Joint = joints{idx};
            if idx_bodies == 1 % Add first body to base
                addBody(robot,bodies{idx},"base")
            else % Add current body to previous body by name
                addBody(robot,bodies{idx},['body' num2str(idx_bodies-1)])
            end
            idx_bodies = idx_bodies + 1;
        end
    end
end

