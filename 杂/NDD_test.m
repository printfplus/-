clear;
clc;
Parameter;
possi_list = [];
possi_tmp = 0;
whole_test_num = 1e8;
result = {};
parfor i = 1:whole_test_num
    if mod(i,1e3) == 0
        i
    end
    [r_num,rr_num,v_num] = threed_sample(final_table);
    range = range_label(r_num);
    range_rate = range_rate_label(rr_num);
    v = v_label(v_num);
    [~,a_list] = value_function3(range,range_rate,v);
    flag = value_function3_test_Q(range,range_rate,v,a_list);
    result{i} = flag;
    
end
for i=1:whole_test_num
    if result{i} == 0
        possi_list(i) = 1;
    else
        possi_list(i) = 0;
    end
end
final_possi_list = [];
unit = 1e3;
for i = 1:whole_test_num/unit
    final_possi_list(i) = sum( possi_list(1:i*unit) ) / (i*unit);
end
plot(final_possi_list);