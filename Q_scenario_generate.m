clear;
clc;
CF_data_process;
load('Q_table_little.mat');
global Q_table_little;
for i = 1:size(Q_table_little,1)
    Q_table_little(i,:) = Q_table_little(i,:)/sum(Q_table_little(i,:));
end

load('Dis_CF.mat');
load('final_table.mat');
final_table = final_table/sum(sum(sum(final_table)));
test_num = 100000;
global range_label;
global range_rate_label;
global v_label;
global a_label;
global mytable;
global mytable_num;
load('mytable.mat');
load('mytable_num.mat');
range_label = 0:5:115;
range_rate_label = -10:1:8;
v_label = 20:1:40;
a_label = -4:0.2:2;
dis_R = 5;
dis_RR = 1;
dis_V = 1;
possi = 0;
possi_list = [];
Q_scenario_set = zeros(test_num,303);

for i = 1:test_num
    i
    tmp_num = randi(size(mytable,1));
    range = mytable(tmp_num,1);
    range_rate = mytable(tmp_num,2);
    v = mytable(tmp_num,3);
    [flag,a_list] = value_function3q(range,range_rate,v);
    if  flag== 0
        possi = (possi*(i-1)+1)/i;
    else
        possi = possi*(i-1)/i;
    end
    possi_list = [possi_list,possi];
    NDD_scenario_set(i,:) = [range,range_rate,v,a_list];
end