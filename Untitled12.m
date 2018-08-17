load('possi_table.mat');
load('mytable.mat');
load('mytable_num.mat');
load('final_table.mat');
final_table = final_table/sum(sum(sum(final_table)));
global a_label;
global range_label;
global range_rate_label;
global v_label;

a_label = -4:0.2:2;
range_label = 0:5:115;
range_rate_label = -10:1:8;
v_label = 20:1:40;
load('Q_table_little.mat')
final_possi = 0;

for i = 1:size(mytable,1)
    range_num = mytable_num(i,1);
    range_rate_num = mytable_num(i,2);
    v_num = mytable_num(i,3);
    possi_tmp = final_table(range_num,range_rate_num,v_num);
    final_possi = final_possi+possi_tmp*sum(Q_table_little(i,:));
end
