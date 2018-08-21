function possi_list = get_NDD_possi_list( v )
 global Dis_FF;
 global v_label;
 %global a_label;
 %v = state(3);
 v_num = find_num(v,v_label);
 possi_list = Dis_FF(v_num,:);
 

end

