load('CF.mat');
v_list = CF(:,4)';
range_list = CF(:,10)';
range_rate_list = CF(:,11)';
a_list = CF(:,9)';

%beta = nlinfit(X,y,fun,beta0)


 %x = [k,V1,V2,C1,L,C2];
beta0 = [0.85,6.75,7.91,0.13,5,1.57];
xdata = [range_list;v_list];
ydata = a_list;
fun = @(x,xdata)x(1)*(x(2)+x(3)*tanh(x(4)*(xdata(1,:)-x(5))-x(6))-xdata(2,:));
beta = nlinfit(xdata,ydata,fun,beta0);

