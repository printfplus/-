clear;
clc;
Parameter;
final_possi_list = [];
possi_tmp = 0;
whole_test_num = 1e4;
load V_table.mat;
load D_table.mat;
global Q_table;
load Q_table.mat;
global mytable_matrix_possi;
load mytable_matrix_possi.mat;
global final_table;
load final_table.mat;
likelyhood = [];
result = {};
m = 0;
possi_list_Q  = [];
like_list = [];
for i = 1:whole_test_num
    i
    test_item_num = one_row_sample(1:size(mytable,1),D_table);
    range = mytable(test_item_num,1);
    range_rate = mytable(test_item_num,2);
    v = mytable(test_item_num,3);
    [~,a_list,possi_list,~] = value_function3_generate_IDM(range,range_rate,v);
    
    [flag,v_num_list] = value_function3_test_FVDM(range,range_rate,v,a_list);
    NDD_possi_list = Q_possi_2_NDD_possi(v_num_list,a_list);
    likelyhood = calculate_like([range,range_rate,v],possi_list,NDD_possi_list);
    
    if flag == 0
        result{i} = [1,likelyhood];
        possi_list_Q(i) = 1;
        like_list(i) = likelyhood;
    else
        result{i} = [0,likelyhood];
        possi_list_Q(i) = 0;
        like_list(i) = likelyhood;
    end
    
end
save possi_list_Q.mat possi_list_Q
save like_list.mat like_list
