function NDD_possi_list = Q_possi_2_NDD_possi(v_num_list,a_list)
global a_possi_table;
global Dis_FF;
a_possi_table = Dis_FF;
global a_label;
NDD_possi_list = zeros(1,max(size(a_list)));
for i = 1:max(size(a_list))
    v_num = v_num_list(i);
    a_num = find_num(a_list(i),a_label);
    possi = a_possi_table(v_num,a_num);
    NDD_possi_list(i) = possi;
end

end

