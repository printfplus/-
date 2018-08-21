function a_list = get_a_possi( range_num,range_rate_num,v_num,whole_list )
%load Q_table.mat;
Q_table = whole_list;
a_list_size = size(Q_table,4);
a_list = zeros(1,a_list_size);
for i = 1:a_list_size
    a_list(i) = Q_table(range_num,range_rate_num,v_num,i);
end

end

