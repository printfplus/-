function a_possi_list = Q_sample( state,Q_table )

global range_label;
global range_rate_label;
global v_label;
global mytable_num;

range_num  = find_num(state(1),range_label);
range_rate_num = find_num(state(2),range_rate_label);
v_num = find_num(state(3),v_label);
for i = 1:size(Q_table,1)
    if mytable_num(i,1) == range_num && mytable_num(i,2) == range_rate_num && mytable_num(i,3) == v_num
        a_possi_list = Q_table(i,:);
        return;
    end

end
a_possi_list = [];

