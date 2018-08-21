function like = calculate_like( state,possi_list,NDD_possi_list )
% load mytable_matrix_possi.mat;
% load final_table.mat;
global mytable_matrix_possi;
global final_table;
%Parameter;
global range_label;
global range_rate_label;
global v_label;
like = 1;
range_num = find_num(state(1),range_label);
range_rate_num = find_num(state(2),range_rate_label);
v_num = find_num(state(3),v_label);
Q_possi = mytable_matrix_possi(range_num,range_rate_num,v_num);
NDD_possi = final_table(range_num,range_rate_num,v_num)/sum(sum(sum(final_table)));
like = NDD_possi/Q_possi;
for i = 1:max(size(possi_list))
    like = like * NDD_possi_list(i)/possi_list(i);
end
if like >0 
end

end

