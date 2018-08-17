function [flag,a_list] = value_function3( range,range_rate,v )
global v_label;
global a_possi_table;
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
    a_possi_list = a_possi_table(v_num,:);
    [a_tmp,~] = one_row_sample(a_label,a_possi_list);
    a_list(i) = a_tmp;
    %a_tmp = -4;
    [state,reward,a2] = update_state(state,a_tmp);
    a2_list = [a2_list,a2];
    range_list = [range_list,state(1)];
    range_rate_list = [range_rate_list,state(2)];
    v_list = [v_list,state(3)];
    if reward == 1
        flag = 0;
        %return
    end
end

end

