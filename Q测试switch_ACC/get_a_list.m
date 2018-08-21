function a_list = get_a_list( range,range_rate,velocity,whole_list )

global range_label;
global range_rate_label;
global v_label;
range_num = find_num_state(range,range_label);
range_rate_num = find_num_state(range_rate,range_rate_label);
v_num = find_num_state(velocity,v_label);
a_list = get_a_possi(range_num,range_rate_num,v_num,whole_list);

end

