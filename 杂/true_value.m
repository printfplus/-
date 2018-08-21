clear;
clc;
load('mytable.mat');
load('Dis_FF.mat');
global a_possi_table;
a_possi_table = Dis_FF;
a_possi_table(21,:) = 1/31*ones(1,31);
range_label = 0:5:115;
range_rate_label = -20:0.4:10;
global v_label;
v_label = 20:1:40;
a_label = -4:0.2:2;
dis_R = 5;
dis_RR = 0.4;
dis_v = 1;
dis_a = 0.2;
final_value = zeros(338,31);
for i = 1:size(mytable,1)
    i
    possi_tmp  = 0;
    for a_get = 1:31
        a_get
        possi_tmp = 0;
        for j = 1:100
            
            range_tmp = mytable(i,1)+dis_R*rand();
            range_rate_tmp = mytable(i,2)+dis_RR*rand();
            v_tmp = mytable(i,3)+dis_v*rand();
            a_tmp = a_label(a_get)+dis_a*rand();
            state = update_state([range_tmp,range_rate_tmp,v_tmp],a_tmp);
            if state(1)<0 || value_function3(range_tmp,range_rate_tmp,v_tmp) == 0
                possi_tmp = (possi_tmp*(j-i)+1)/j;
            else
                possi_tmp = (possi_tmp*(j-1))/j;
            end
        end
        final_value(i,a_get) = possi_tmp;
    end
    
end

        
