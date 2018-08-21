function [i,j,k] = threed_sample( table )

range_whole = size(table,1);
range_rate_whole = size(table,2);
v_whole = size(table,3);

my_possi  = rand();
possi_tmp = 0;

for i = 1:range_whole
    for j = 1:range_rate_whole
        for k = 1:v_whole
            possi_tmp = possi_tmp+table(i,j,k);
            if possi_tmp > my_possi
                return;
            end
        end
    end
end
            
end

