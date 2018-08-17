clear;
clc;
Parameter;
possi_list = [];
possi_tmp = 0;
whole_test_num = 10000000;
for i = 1:whole_test_num
    i
    [r_num,rr_num,v_num] = threed_sample(final_table);
    range = range_label(r_num);
    range_rate = range_rate_label(rr_num);
    v = v_label(v_num);
    [~,a_list] = value_function3(range,range_rate,v);
    flag = value_function3_test_FVDM(range,range_rate,v,a_list);
    if flag == 0
        possi_tmp = (possi_tmp*(i-1)+1)/i;
    else
        possi_tmp = (possi_tmp*(i-1)+0)/i;
    end
    possi_list = [possi_list,possi_tmp];
    if possi_tmp > 0
    end
end
plot(possi_list);