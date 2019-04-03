function pos = state2pos(s)
    n = length(s)/6;
    pos = zeros(n, 3);
    for i = 1:n
        pos(i, :) = s(getindex(i, 1:3, 0));
    end
end