function [ err ] = Compare_Dis( data1,data2,V )
% compare the probability distribution difference between data1 and data2

% delt = V(2)-V(1);
% V = V + delt / 2;

[N1,X1] = hist(data1,V);
[N2,X2] = hist(data2,V);

P1 = N1 ./ max(size(data1));
P2 = N2 ./ max(size(data2));

figure;
plot(X1,P1, 'r-' ,'linewidth', 3);
hold on;
plot(X2,P2, 'k-' ,'linewidth', 3);
legend('Data by Gibbs Sampling', 'Original Data');

n = max(size(V));
err = 0;
for i=1:n
   err = err + (P1(i)-P2(i))^2; 
end
err = sqrt(err) / n;

end

