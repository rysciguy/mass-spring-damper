function pos = state2pos(s)
% Extracts coordinates of each point from an n*6 state vector
    n = length(s)/6;
    pos = zeros(n, 3);
    for i = 1:n
        pos(i, :) = s(getindex(i, 1:3, 0));
    end
end