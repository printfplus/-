load V_table.mat;
load mytable_num.mat;
load final_table.mat;
final_table = final_table/sum(sum(sum(final_table)));
D_table = zeros(size(V_table));
for i = 1:size(V_table,2)
    range_num = mytable_num(i,1);
    range_rate_num = mytable_num(i,2);
    v_num = mytable_num(i,3);
    D_table(i) = V_table(i) * final_table(range_num,range_rate_num,v_num);
end
D_table = D_table/sum(D_table);
save D_table.mat D_table
