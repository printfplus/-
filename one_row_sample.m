function [sample_result,num] = one_row_sample(label_list,possi_list)
mypossi = sum(possi_list)*rand(1);
possi_sum = 0;
for i = 1:max(size(possi_list))
    possi_sum = possi_sum+possi_list(i);
    if possi_sum > mypossi
        sample_result = label_list(i);
        num = i;
        return;
    end
end

end

