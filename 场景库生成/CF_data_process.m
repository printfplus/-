%clear;
%clc;
load('Dis_CF.mat');
load('Dis_FF.mat');
range_label = 0:dis_R:115;
range_rate_label = -10:dis_RR:8;
global v_label;
v_label = 20:dis_V:40;
new_table = zeros(21,24,19);
for i = 1:21
    for j = 1:24
        for k = 1:19
            new_table(i,j,k) = sum(Dis_CF_M(i,j,k,:));
        end
    end
end
final_table = zeros(24,19,21);
for i = 1:21
    for j = 1:24
        for k = 1:19
            final_table(j,k,i) = new_table(i,j,k);
        end
    end
end
sum(sum(sum(final_table)))
global a_possi_table;
a_possi_table = zeros(size(Dis_FF));
for i = 1:size(Dis_FF,1)
    for j = 1:size(Dis_FF,2)
        if i < size(Dis_FF,1)
            a_possi_table(i,j) = Dis_FF(i,j)/sum(Dis_FF(i,:));
        else
            a_possi_table(i,j) = 1/size(Dis_FF,2);
        end
    end
end
            


