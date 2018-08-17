

whole_list = 1/31*ones(max(size(range_label)),max(size(range_rate_label)),max(size(v_label)),max(size(a_label)));

for i = 1:max(size(range_label))
    for j = 1:max(size(range_rate_label))
        for k = 1:max(size(v_label))
            tmp_list = random_sample();
            for w = 1:max(size(a_label))
                whole_list(i,j,k,w) = tmp_list(w);
            end
        end
    end
end
Q_table = whole_list;
Q_table_little_ini = zeros(size(mytable,1),31);
for i = 1:size(mytable,1)
    for j = 1:31
        range_num = mytable_num(i,1);
        range_rate_num = mytable_num(i,2);
        v_num = mytable_num(i,3);
        Q_table_little_ini(i,j) = Q_table(range_num,range_rate_num,v_num,j);
    end
end


    




