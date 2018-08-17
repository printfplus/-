function flag = value_function3_test_FVDM( range,range_rate,v,a_list )

flag = 1;
dt = 0.1;
state = [range,range_rate,v];
range_list = [];
for i = 1:size(a_list,1)
    [state,reward] = update_state(state,a_list(i));
    range_list = [range_list,state(1)];
    if reward == 1
        flag = 0;
        %return
    end
end

end

