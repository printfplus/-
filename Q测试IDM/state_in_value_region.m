function [flag] = state_in_value_region( state )

global range_label;
global range_rate_label;
global v_label;
global mytable_num;

range_num = find_num(state(1),range_label);
range_rate_num = find_num(state(2),range_rate_label);
v_num = find_num(state(3),v_label);
if isequal(range_num,[]) || isequal(range_rate_num,[]) || isequal(v_num,[])
    flag = 0;
    return;
end
[flag] = find_row([range_num,range_rate_num,v_num],mytable_num);

end

