function a_list = random_sample( )

a_list = zeros(1,31);
a_num = 31;
for i = 1:a_num
    a_list(i) = rand();
end

newpossi = rand();
a_list = newpossi*a_list/sum(a_list);
    

end

