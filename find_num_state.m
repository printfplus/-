function [num] = find_num_state(value,label)
num = [];
delta = label(2)-label(1);

for i = 1:max(size(label))
    if label(i)+0.5*delta >= value
        num = i;
        break
    end
end

