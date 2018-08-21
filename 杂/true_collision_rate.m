clear;
clc;
Parameter;
load('mytable_num.mat');
load('final_table.mat')
final_table = final_table/sum(sum(sum(final_table)));
possi_list = zeros(size(mytable_num,1),1);
for i = 1:size(mytable_num,1)
    possi_list(i) = final_table(mytable_num(i,1),mytable_num(i,2),mytable_num(i,3));
end
value_region_possi = [mytable_num,possi_list];
                                                                                                                                                                                      
load('mytable.mat');
load('Dis_FF.mat');
global a_possi_table;
a_possi_table = Dis_FF;
a_possi_table(21,:) = 1/31*ones(1,31);

global v_label;
v_label = 20:1:40;
a_label = -4:0.2:2;
dis_R = 1;
dis_RR = 1;
dis_v = 1;
dis_a = 0.2;
final_value = zeros(338,31);
final_possi = 0;
possi_list = [];
load V_table.mat
for i = 1:size(mytable,1)
    i
    possi_tmp  = V_table(i);
    final_possi = final_possi + possi_tmp*value_region_possi(i,4);
    possi_list = [possi_list,possi_tmp];
    
end

        
