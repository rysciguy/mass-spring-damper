function output = mapFromTo(value,fromRange,toRange)
fromLow = fromRange(1);
fromHigh = fromRange(end);
toLow = toRange(1);
toHigh = toRange(end);
output = (value - fromLow) .* (toHigh - toLow) ./ (fromHigh - fromLow) + toLow;
if output > toHigh
    output = toHigh;
elseif output < toLow
    output = toLow;
end

end
