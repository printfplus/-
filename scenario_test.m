function flag = scenario_test(scenario)

whole_num = size(scenario,1);
range = scenario(1);
range_rate = scenario(2);
v = scenario(3);
a_list = scenario(4:end);
flag = value_function3_test_FVDM(range,range_rate,v,a_list);

end

