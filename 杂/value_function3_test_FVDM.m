function [flag,v_num_list] = value_function3_test_FVDM( range,range_rate,v,a_list )

flag = 1;
global v_label;
state = [range,range_rate,v];
%range_list = [];
v_num_list = [];
for i = 1:size(a_list,2)
    v_num = find_num(state(3),v_label);
    [state,reward] = update_state_test(state,a_list(i));
    %range_list = [range_list,state(1)];
    if reward == 1
        flag = 0;
        %return
    end
    v_num_list = [v_num_list,v_num];
end

end

