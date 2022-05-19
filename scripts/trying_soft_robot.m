clc;clear;close all;

% loading the model made with "make_soft_robot.m" script, has two soft
% links made of 3 ccp
load("soft_robot_2links.mat");

Li = 0.1;
lengths = [Li,Li,Li,Li/2,Li/2,Li/2];

% plots stroboscopic view of the robot, from q=[0,0] to q=[pi/2,-pi/2]
stroboscopic_view(robot,[0,0],[pi/2,-pi/2],lengths,10)

