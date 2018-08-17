function F = myfunc( x,xdata )

F = x(1)*(x(2)+x(3)*tanh(x(4)*(xdata(1)-x(5))-x(6))-xdata(2));

end

