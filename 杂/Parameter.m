global mytable_matrix;
global Dis_FF;
global v_label;
global a_label;
global range_label;
global range_rate_label;
load('mytable.mat'); 
load('mytable_num.mat');
load('mytable_matrix.mat');
load('Dis_FF.mat');

new_matrix = 1e-6*ones(size(Dis_FF));
Dis_FF = Dis_FF + new_matrix;
for i = 1:size(Dis_FF,1)
    Dis_FF(i,:) = Dis_FF(i,:)/sum(Dis_FF(i,:));
end
a_possi_table = Dis_FF;
% range_lb = range_label(1);
% range_ub = range_label(end);
% range_rate_lb = range_rate_label(1);
% range_rate_ub = range_rate_label(end);
% v_lb = v_label(1);
% v_ub = v_label(end);
alpha = 1;
alpha_Q = 1;
test_num = 1.2e20;
dis_R = 1;
dis_RR = 1;
dis_V = 1;
dis_U = 0.2;

load('mytable.mat'); 
load('final_table.mat');
final_table = final_table/sum(sum(sum(final_table)));
%[range_label,range_rate_label,possi_table] = table_read(csvread('6-11cutin_table.csv'));
range_label = 0:dis_R:115;
range_rate_label = -10:dis_RR:8;
v_label = 20:dis_V:40;
a_label = -4:dis_U:2;
range_cnt = size(range_label,2);
range_rate_cnt = size(range_rate_label,2);
v_cnt = size(v_label,2);
