load('mytable.mat');
load('mytable_num.mat');
load('Q_table');
load V_table;
load D_table;
range_num = size(Q_table,1);
range_rate_num = size(Q_table,2);
v_num = size(Q_table,3);
mytable_matrix_possi = zeros(range_num,range_rate_num,v_num);
for i = 1:size(mytable,1)
    mytable_matrix_possi(mytable_num(i,1),mytable_num(i,2),mytable_num(i,3)) = D_table(i)/sum(D_table);
end
sum(sum(sum(mytable_matrix_possi)))
save mytable_matrix_possi.mat mytable_matrix_possi