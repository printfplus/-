whole_num_cnt = 0;
for i = 1:size(Dis_CF,1)
    for j = 1:size(Dis_CF,2)
        cell_tmp = Dis_CF(i,j);
        matrix_tmp = cell_tmp{1,1};
        for m = 1:size(matrix_tmp,1)
            for n = 1:size(matrix_tmp,2)
                if matrix_tmp(m,n) >0 
                    whole_num_cnt = whole_num_cnt+1;
                end
            end
        end
    end
end
        