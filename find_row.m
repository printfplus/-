function row_num = find_row( row,matrix )
row_num = 0;
% for i = 1:size(matrix,1)
%     if isequal(row,matrix(i,:))
%         row_num = i;
%         return;
%     end
% end
global range_label;
global range_rate_label;
global v_label;

range = range_label(row(1));
range_rate = range_rate_label(row(2));
v = v_label(row(3));

if value_function3_value_region(range,range_rate,v)  == 0
    row_num = 1;
end


end
