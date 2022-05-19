function [xc,yc] = get_circle_center(p1,p2,r,z_rot_positive)
%GET_CIRCLE_CENTER given two points and a radius there are two points
%distant r from both points. z_rot_positive is a boolean value used to
%select one of them.

% median point
M = (p1+p2)/2;
% segment slope
m = (p2(2)-p1(2))/(p2(1)-p1(1));

% checking for horizontal and vertical segments
if m==0
    xcs = [M(1),M(1)];
    ycs = [M(2)+sqrt(r^2-(p1(1)-M(1))^2),M(2)-sqrt(r^2-(p1(1)-M(1))^2)];
elseif isinf(m)
    xcs = [M(1)+sqrt(r^2-(p1(2)-M(2))^2),M(2)-sqrt(r^2-(p1(2)-M(2))^2)];
    ycs = [M(2),M(2)];
else
    k = M(2)+M(1)/m;
    % coeff of second degree equation
    a = 1+1/m^2;
    b = (-2*p1(1)-2*k/m+2*p1(2)/m);
    c = p1(1)^2+k^2+p1(2)^2-2*k*p1(2)-r^2;
    
    xcs = roots([a,b,c]);
    ycs = -1/m*xcs+k;
end

if is_left(p1,p2,[xcs(1),ycs(1)]) && z_rot_positive
    xc = xcs(1);
    yc = ycs(1);
elseif ~is_left(p1,p2,[xcs(1),ycs(1)]) && ~z_rot_positive
    xc = xcs(1);
    yc = ycs(1);
else
    xc = xcs(2);
    yc = ycs(2);
end

end

function isLeft = is_left(a,b,c)
    isLeft = ((b(1) - a(1))*(c(2) - a(2)) - (b(2) - a(2))*(c(1) - a(1))) > 0;
end
