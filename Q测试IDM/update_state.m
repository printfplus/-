function [state,reward,a2] = update_state(state,a)
    reward = 0;
    dt = 0.1;
    vmin = 20;
    vmax = 40;
    mindis = 1;
   
    % Update by SHUO 0818
    % The unit time is changed to 1s
    T = 1;
    N = T/dt;
    for i=1:N
        range = state(1);
        range_rate = state(2);
        v1 = state(3);
        v2 = v1-range_rate;
        x2 = 0;
        x1 = x2+range;
        
        a2 = IDM(x1,x2,v1,v2);
        a1 = a;
        
        state1 = update_xv(x1,v1,a1,dt,vmin,vmax);
        state2 = update_xv(x2,v2,a2,dt,vmin,vmax);
        state(1) = state1(1)-state2(1);
        state(2) = state1(2)-state2(2);
        state(3) = state1(2);  
        
        if state1(1) <= state2(1)+mindis
            reward = 1;
            break;
        end 
        if range <= mindis
            reward = 1;
            break;
        end
        
    end
 
end
