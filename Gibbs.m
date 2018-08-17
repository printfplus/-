function [ x_sample ] = Gibbs( x0, Cond_P, ID, n_total )
% 3-dimensional Gibbs sampling
n = size(Cond_P,2);

x_new = x0;
x_sample = zeros(n_total,n);

for k=1:n_total 
%     i = randi([1,n],1);
    for i =1:n
        
        switch i
            case 1
                id_R = getID(x_new(2),ID{2});
                id_RR = getID(x_new(3),ID{3});
                Cond_P_M = Cond_P{i}(id_R,id_RR);
                x_new(i) = D_1_smp(Cond_P_M{1},ID{1});
            case 2
                id_V = getID(x_new(1),ID{1});
                id_RR = getID(x_new(3),ID{3});
                Cond_P_M = Cond_P{i}(id_V,id_RR);
                x_new(i) = D_1_smp( Cond_P_M{1}, ID{2});
            case 3
                id_V = getID(x_new(1),ID{1});
                id_R = getID(x_new(2),ID{2});
                Cond_P_M = Cond_P{i}(id_V,id_R);
                x_new(i) = D_1_smp( Cond_P_M{1}, ID{3});
        end
        
    end


    x_sample(k,:) = x_new;
end
    
end

