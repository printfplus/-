clear
load possi_list.mat
sum(possi_list)
unit = 1e3;
final_possi_list(1) = sum( possi_list(1:1*unit) ) / (1*unit);
whole_test_num = 1e8;
for i = 2:whole_test_num/unit
    final_possi_list(i) = (final_possi_list(i-1)*(i-1)*unit+sum( (possi_list((i-1)*unit+1:i*unit)) ) )/ (i*unit);

end
plot(final_possi_list);