load possi_list_Q.mat
load like_list.mat
whole_test_num = 1e4;
sum(possi_list_Q.*like_list)/whole_test_num
possi_list_Q1 = possi_list_Q.*like_list;
unit = 1;
final_possi_list = [];
%final_possi_list(1) = sum( possi_list_Q1(1:1*unit) ) / (i*unit);
for i = 1:whole_test_num/unit
    i;
    final_possi_list(i) = sum( possi_list_Q1(1:i*unit) ) / (i*unit);
end
plot(final_possi_list);

final_possi_list_w = [];
%final_possi_list(1) = sum( possi_list_Q1(1:1*unit) ) / (i*unit);
for i = 1:whole_test_num/unit
    i;
    final_possi_list_w(i) = sum( possi_list_Q1(1:i*unit) ) / sum( like_list(1:i*unit) );
end
%plot(final_possi_list_w);
save final_possi_list_Q.mat final_possi_list