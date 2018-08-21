function flag = value_function3_test_NDD( range,range_rate,v,a_list )

flag = 1;

state = [range,range_rate,v];
for i = 1:size(a_list,1)
    [state,reward] = update_state_test(state,a_list(i));
    if reward == 1
        flag = 0;
    end
end

end

