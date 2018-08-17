function [flag,a_list] = value_function3q( range,range_rate,v )
global v_label;
%global a_possi_table;
global Q_table_little;

a_label = -4:0.2:2;
flag = 1;
test_num = 300;
dt = 0.1;
state = [range,range_rate,v];
a_list = zeros(1,300);
for i = 1:test_num
    %v_num = find_num(state(3),v_label);
    a_possi_list = Q_sample(state,Q_table_little);
    if isequal(a_possi_list,[])
        flag = -1;
        for j = i:test_num
            a_list(j) = 0;
        end
        return;
    end
    [a_tmp,~] =one_row_sample(a_label,a_possi_list);
    a_list(i) = a_tmp;
    %a_tmp = -4;
    [state,reward] = update_state(state,a_tmp);
    if reward == 1
        flag = 0;
        %return
    end
end

end

