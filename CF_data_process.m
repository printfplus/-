clear;
clc;
Parameter;
load('Dis_CF.mat');
load('Dis_FF.mat');

new_table = zeros(21,24,19);
for i = 1:v_cnt
    for j = 1:range_cnt
        for k = 1:range_rate_cnt
            new_table(i,j,k) = sum(Dis_CF_M(i,j,k,:));
        end
    end
end
final_table = zeros(24,19,21);
for i = 1:v_cnt
    for j = 1:range_cnt
        for k = 1:range_rate_cnt
            final_table(j,k,i) = new_table(i,j,k);
        end
    end
end
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
save final_table.mat final_table
            


