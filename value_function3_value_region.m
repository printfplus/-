function [flag] = value_function3_value_region( range,range_rate,v )
global v_label;
global Dis_FF;
a_label = -4:0.2:2;
flag = 1;
test_num = 300;
dt = 0.1;
state = [range,range_rate,v];
a_list = zeros(1,300);
range_list = [];
range_rate_list = [];
v_list = [];
a2_list = [];
for i = 1:test_num
    if i == 250
    end
    v_num = find_num(state(3),v_label);
    a_possi_list = Dis_FF(v_num,:);
    %[a_tmp,~] = one_row_sample(a_label,a_possi_list);
    
    a_tmp = -4;
    a_list(i) = a_tmp;
    [state,reward,a2] = update_state(state,a_tmp);
    
    if reward == 1
        flag = 0;
        %return
    end
end

end

