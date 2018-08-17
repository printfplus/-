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
dis_R = 5;
dis_RR = 0.4;
dis_v = 1;
dis_a = 0.2;
final_value = zeros(338,31);
final_possi = 0;
possi_list = [];
for i = 1:size(mytable,1)
    i
    possi_tmp  = 0;
    
        for j = 1:1000
            
            range_tmp = mytable(i,1);
            range_rate_tmp = mytable(i,2);
            v_tmp = mytable(i,3);
            %a_tmp = a_label(a_get)+dis_a*rand();
            %state = update_state([range_tmp,range_rate_tmp,v_tmp],a_tmp);
            if value_function3(range_tmp,range_rate_tmp,v_tmp) == 0
                possi_tmp = (possi_tmp*(j-i)+1)/j;
            else
                possi_tmp = (possi_tmp*(j-1))/j;
            end
        end
        final_possi = final_possi + possi_tmp*value_region_possi(i,4);
        possi_list = [possi_list,possi_tmp];
    
end

        
