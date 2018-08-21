function [flag,a_list,possi_list,v_num_list] = value_function3_generate_IDM( range,range_rate,v )
global v_label;
global a_possi_table;
global Q_table;

Parameter;
global range_label;
global range_rate_label;
global v_label;
a_label = -4:0.2:2;
flag = 1;
test_num = 30;
state = [range,range_rate,v];
a_list = zeros(1,test_num);
% range_list = [];
% range_rate_list = [];
 v_num_list = [];
% a2_list = [];
possi_list = zeros(1,test_num);
for i = 1:test_num
    v_num = find_num(state(3),v_label);
    
    if state_in_value_region(state)
        a_possi_list = get_a_list(range,range_rate,v,Q_table);
    else
        
        a_possi_list = a_possi_table(v_num,:);
    end
    [a_tmp,possi] = one_row_sample(a_label,a_possi_list);
    possi_list(i) = possi;
    a_list(i) = a_tmp;
    %a_tmp = -4;
    [state,reward,~] = update_state(state,a_tmp);
    %a2_list = [a2_list,a2];
    %range_list = [range_list,state(1)];
    %range_rate_list = [range_rate_list,state(2)];
    v_num_list = [v_num_list,v_num];
    if reward == 1
        flag = 0;
        %return
    end
end

end

