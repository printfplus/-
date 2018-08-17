clear;
clc;
CF_data_process;
load('Dis_CF.mat');
load('final_table.mat');
final_table = final_table/sum(sum(sum(final_table)));
test_num = 100000;
range_label = 0:5:115;
range_rate_label = -10:1:8;
v_label = 20:1:40;
dis_R = 5;
dis_RR = 1;
dis_V = 1;
possi = 0;
possi_list = [];
NDD_scenario_set = zeros(test_num,303);

for i = 1:test_num
    i
    [r_num,rr_num,v_num] = threed_sample(final_table);
    range = range_label(r_num);%+dis_R*rand();
    range_rate = range_rate_label(rr_num);%+dis_RR*rand();
    v = v_label(v_num);%+dis_V*rand();
    [flag,a_list] = value_function3(range,range_rate,v);
    if  flag== 0
        possi = (possi*(i-1)+1)/i;
    else
        possi = possi*(i-1)/i;
    end
    possi_list = [possi_list,possi];
    NDD_scenario_set(i,:) = [range,range_rate,v,a_list];
end
%save('NDD_scenario_set.mat','NDD_scenario_set');
