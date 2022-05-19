function stroboscopic_view(robot,qs_in,qs_fin,lengths,n_views)
%STROBOSCOPIC_VIEW Plots n_views of the robot, from the initial
%configuration to the final one

s = linspace(0,1,n_views);
qs = qs_in+s'.*(qs_fin-qs_in);
figure;
hold on;
for i=1:n_views
    if i == n_views
        show_soft_robot(robot,qs(i,:),lengths,'default');
    else
        show_soft_robot(robot,qs(i,:),lengths,'black');
    end
end

end

