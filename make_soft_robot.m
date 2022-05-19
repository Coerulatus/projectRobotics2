clc;clear;close all;

Li = 0.1;
dhparams = [0 pi/2 0 0;
            0 0 Li/2 0;
            0 -pi/2 Li/2 0;
            0 0 0 0
            0 pi/2 0 0;
            0 0 Li/2 0;
            0 -pi/2 Li/2 0;
            0 0 0 0
            0 pi/2 0 0;
            0 0 Li/2 0;
            0 -pi/2 Li/2 0;
            0 0 0 0];

robot = rigidBodyTree("DataFormat",'row');

for k=1:2
    robot = add_soft_link(robot,1+12*(k-1),dhparams);
end

showdetails(robot);