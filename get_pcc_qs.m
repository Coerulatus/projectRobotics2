function [theta1,d2,d3,theta4,theta5,d6,d7,theta8,theta9,d10,d11,theta12] = get_pcc_qs(qi,lengths)
%GET_PCC_QS returns the qs for each rigid link that makes up a soft link.
%Each cc segment is made of 4 rigid links so there are 12 links in total
%for each soft link.


qi = qi/3;

Li = lengths(1);
theta1 = qi/2;
theta4 = qi/2;
d2 = Li*sin(qi/2)/qi;
d3 = Li*sin(qi/2)/qi;

Li = lengths(2);
theta5 = qi/2;
theta8 = qi/2;
d6 = Li*sin(qi/2)/qi;
d7 = Li*sin(qi/2)/qi;

Li = lengths(3);
theta9 = qi/2;
theta12 = qi/2;
d10 = Li*sin(qi/2)/qi;
d11 = Li*sin(qi/2)/qi;
if qi==0
    Li = lengths(1);
    d2 = Li/2;
    d3 = Li/2;
    Li = lengths(2);
    d6 = Li/2;
    d7 = Li/2;
    Li = lengths(3);
    d10 = Li/2;
    d11 = Li/2;
end
end

