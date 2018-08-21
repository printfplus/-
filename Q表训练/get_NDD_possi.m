function possi = get_NDD_possi( a,state )
 global Dis_FF;
 global v_label;
 global a_label;
 v = state(3);
 v_num = find_num(v,v_label);
 a_list = Dis_FF(v_num,:);
 a_num = find_num(a,a_label);
 possi = a_list(a_num);

end

