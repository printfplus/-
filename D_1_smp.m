function [ x ] = D_1_smp( Cond_P, ID )
% sample 1-dimensional x from conditional distribution Cond_P

% Cond_P = Cond_P{1};
n = max(size(Cond_P));
u = rand(1);
s = 0;
for i=1:n
    s = s + Cond_P(i);
    if s>=u
        x = ID(i);
        break;
    end
end


end

