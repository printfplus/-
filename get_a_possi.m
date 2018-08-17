function a_list = get_a_possi( range_num,range_rate_num,v_num,whole_list )
a_list_size = size(whole_list,4);
a_list = zeros(1,a_list_size);
for i = 1:a_list_size
    a_list(i) = whole_list(range_num,range_rate_num,v_num,i);
end

end

