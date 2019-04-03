% Plots the x and y position of point # PT_IDX over time

pt_idx = 2;
t = sol.x;
x = sol.y(getindex(pt_idx, 1, 0), :);
y = sol.y(getindex(pt_idx, 2, 0), :);
plot(t, x, t, y);
hline(1, 'k:');
xlabel('Time (s)');
ylabel('Position');
legend({'x', 'y'});
title('k = 1.0, c = 2.0');