clear;
clc;
load('Dis_CF.mat');
load('final_table.mat');
load('Q_table.mat');
final_table = final_table/sum(sum(sum(final_table)));
test_num = 10000000;
range_label = 0:5:115;
range_rate_label = -10:1:8;
v_label = 20:1:40;
dis_R = 5;
dis_RR = 1;
dis_V = 1;
possi = 0;
possi_list = [];