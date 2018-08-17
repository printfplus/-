 
function [f] = value_function_FVDM(x)

    global v1;
    global v2;
    v2 = 20;
    global dt;
    dt = 1;
    global vmax;
    global vmin;
    vmin = 0;
    vmax = 40;
    range = x(1);
    range_rate = x(2);
    a1_list = [];
    for i = 3:size(x,2)
        a1_list = [a1_list,x(i)];
    end 
    %a1_list
    v1 = v2+range_rate;
    global STEP;
    STEP = size(x,2)-2;
    car1 = [range,v1];
    car2 = [0,v2];
    value_list = [];
    x1_list = [range];
    x2_list = [0];
    a2_list = [];
    v2_list = [];
    for i = 1:STEP
        a1 = a1_list(i);
        a2 = FVDM(car1(1),car2(1),car1(2),car2(2));
        car1 = update_state(car1(1),car1(2),a1,dt,vmin,vmax);
        car2 = update_state(car2(1),car2(2),a2,dt,vmin,vmax);
        x1_list = [x1_list,car1(1)];
        x2_list = [x2_list,car2(1)];
        v2_list = [v2_list,car2(2)];
        a2_list = [a2_list,a2];
        value_list = [value_list,time_interval(car1(1),car2(1),car1(2),car2(2))];
    end
    f = min(value_list); 
end
    



