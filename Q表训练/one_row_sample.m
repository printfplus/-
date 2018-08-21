function [sample_result,possi,num] = one_row_sample(label_list,possi_list)

if sum(possi_list) == 0
    num = randi(size(label_list,1));
    sample_result = label_list(num);
    return;
end
mypossi = sum(possi_list)*rand(1);
possi_sum = 0;
for i = 1:max(size(possi_list))
    possi_sum = possi_sum+possi_list(i);
    if possi_sum > mypossi
        sample_result = label_list(i);
        possi = possi_list(i)/sum(possi_list);
        num = i;
        return;
    end
end

end

