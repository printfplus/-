function [flag] = find_row( row,matrix )
flag = 0;

global range_label;
global range_rate_label;
global v_label;
global mytable_matrix;

if mytable_matrix(row(1),row(2),row(3))  == 1
    flag = 1;
    
end


end

