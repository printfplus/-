Parameter;
load('Q_table.mat');
Q_table_little = zeros(size(mytable,1),31);
for i = 1:size(mytable,1)
    for j = 1:31
        range_num = mytable_num(i,1);
        range_rate_num = mytable_num(i,2);
        v_num = mytable_num(i,3);
        Q_table_little(i,j) = Q_table(range_num,range_rate_num,v_num,j);
    end
end
V_state = sum(Q_table_little');

save Q_table_little.mat Q_table_little  