possi_table_3d = final_table;
value_table = zeros(size(possi_table_3d));
mytable = [];
mytable_num = [];
final_possi = 0;
for i = 1:size(possi_table_3d,1)
    i
    for j = 1:size(possi_table_3d,2)
        j;
        for k = 1:size(possi_table_3d,3)
            %if possi_table_3d(i,j,k) ~= 0
                for w = 1:1
                    if value_function3(range_label(i),range_rate_label(j),v_label(k)) == 0
                        value_table(i,j,k) = 1;
                        mytable = [mytable;[range_label(i),range_rate_label(j),v_label(k)]];
                        mytable_num = [mytable_num;[i,j,k]];
                        final_possi = final_possi + possi_table_3d(i,j,k);
                    end
                end
            %end
        end
    end
end
save mytable.mat mytable
save mytable_num.mat mytable_num
                
                