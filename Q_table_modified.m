Parameter;
% Q_table_initialize;
load('Q_table.mat');

%Q_table = whole_list;
Q_table_little = zeros(size(mytable,1),31);
for i = 1:size(mytable,1)
    for j = 1:31
        range_num = mytable_num(i,1);
        range_rate_num = mytable_num(i,2);
        v_num = mytable_num(i,3);
        Q_table_little(i,j) = Q_table(range_num,range_rate_num,v_num,j);
    end
end
V_state = sum(Q_table_little');
table_err = [];
end_flag = 1;
road_num =1;
%begin_flag = 1;
for i = 1:test_num
%     alpha = 0.1-0.1*i/test_num;
    if mod(i,1e4)==0
        i
        alpha;
        max(abs(table_err(i-9999:end)))
        sum(abs(table_err(i-9999:end)))
    end
    %if end_flag == 1 %|| begin_flag == 1
        num_tmp = randi(size(mytable,1));
        state_tmp = mytable(num_tmp,:);
        %state_num_tmp = mytable_num(num_tmp,:);
        % sample the range, range rate and  v
        end_flag = 0;
        train_step = 0;
        %road_num = road_num + 1;
    %else
       % statetmp = state_new;
    %end
    range_tmp = state_tmp(1);
    range_num = find_num(range_tmp,range_label);
    range_rate_tmp = state_tmp(2);
    range_rate_num = find_num(range_rate_tmp,range_rate_label);  
    v_tmp = state_tmp(3);
    v_num = find_num(v_tmp,v_label);
    %state_num = [range_num,range_rate_num,v_num];
    
    % get a_list and sample
    a_list_tmp = get_a_list(range_tmp,range_rate_tmp,v_tmp,Q_table);
    
    if max(abs(a_list_tmp))<1e-300
        table_err(i) = 0;
        continue;
    end
    
    [newa_tmp,a_tmp_num] = one_row_sample(a_label,a_list_tmp);
    state_tmp = [range_tmp,range_rate_tmp,v_tmp];
    
    % update the state and get reward
    [state_new,reward] = update_state(state_tmp,newa_tmp);
    
    %state_new
    if reward == 1
        %nowvalue
        end_flag = 1;
        www = get_NDD_possi(newa_tmp,state_tmp)-Q_table(range_num,range_rate_num,v_num,a_tmp_num);
        table_err(i) = www / Q_table(range_num,range_rate_num,v_num,a_tmp_num);
        Q_table(range_num,range_rate_num,v_num,a_tmp_num) = Q_table(range_num,range_rate_num,v_num,a_tmp_num) + alpha * www;
        
    else
        state_new_num = [find_num_state(state_new(1),range_label),find_num_state(state_new(2),range_rate_label),find_num_state(state_new(3),v_label)];
        train_step = train_step+1;
        if find_row(state_new_num,mytable_num) ~= 0
            newrange_num = state_new_num(1);
            newrange_rate_num = state_new_num(2);
            newv_num = state_new_num(3);
            nowvalue = Q_table(range_num,range_rate_num,v_num,a_tmp_num);
    
            % update the Q table
            www = reward+get_NDD_possi(newa_tmp,state_tmp)*sum(get_a_list(state_new(1),state_new(2),state_new(3),Q_table))-nowvalue;
            
            table_err(i) = www / Q_table(range_num,range_rate_num,v_num,a_tmp_num);
            if abs(table_err(i)) == 1
            end
            Q_table(range_num,range_rate_num,v_num,a_tmp_num) =  alpha_Q * reward+alpha_Q * get_NDD_possi(newa_tmp,state_tmp)*sum(get_a_list(state_new(1),state_new(2),state_new(3),Q_table)) + (1-alpha_Q) * nowvalue;    
        else
            end_flag = 1;
            nowvalue = Q_table(range_num,range_rate_num,v_num,a_tmp_num);
            www = (0-Q_table(range_num,range_rate_num,v_num,a_tmp_num));
            table_err(i) = www / Q_table(range_num,range_rate_num,v_num,a_tmp_num);
            Q_table(range_num,range_rate_num,v_num,a_tmp_num) = Q_table(range_num,range_rate_num,v_num,a_tmp_num) + alpha * www;
        end
    end
    if abs(table_err(i)) >0.9
    end
end

Q_table_little = zeros(size(mytable,1),31);
for i = 1:size(mytable,1)
    for j = 1:31
        range_num = mytable_num(i,1);
        range_rate_num = mytable_num(i,2);
        v_num = mytable_num(i,3);
        Q_table_little(i,j) = Q_table(range_num,range_rate_num,v_num,j);
    end
end
V_state = sum(Q_table_little');
save Q_table_little.mat Q_table_little  
save Q_table.mat Q_table
    
    