function draw_arc(center,radius,angle_start,angle_end,color)
%DRAW_ARC Draws an arc with given center, radius, from angle_start to 
% angle_end and of the given color.

circr = @(center,radius,rad_ang)  [center(1)+radius*cos(rad_ang);  center(2)+radius*sin(rad_ang)];         

N = 25;

r_angl = linspace(angle_start, angle_end, N);

xy_r = circr(center,radius,r_angl);

plot(xy_r(1,:), xy_r(2,:), '-', 'LineWidth',2, 'Color',color);

end

