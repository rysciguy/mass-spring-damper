function output = mapFromTo(value,fromRange,toRange)
fromLow = fromRange(1);
fromHigh = fromRange(end);
toLow = toRange(1);
toHigh = toRange(end);
output = (value - fromLow) .* (toHigh - toLow) ./ (fromHigh - fromLow) + toLow;

% Enforce toRange boundaries
less = output < toLow;
output(less) = toLow;
more = output > toHigh;
output(more) = toHigh;

% Handle NaNs
output(isnan(output)) = toLow;

end
