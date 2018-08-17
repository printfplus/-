% LC simulation by NDD
clear global;
clear; clc;

load('Dis_CF.mat');
load('Initial_Cond.mat');
load('Dis_FF.mat');

Parameter;

%% numerical experiment by NDD
total_time = 1e5;
result = {};
% parpool('local', 2); 
parfor exp_num = 1:total_time
    
   
    if mod(exp_num,1e3) == 0
        exp_num
    end
%     exp_num
    %% sample initial condition
    % calculate conditional probability
    % V, Range, Range Rate

    BV = {};
    size_initial = max(size(x0_vec));
    x_initial = [];
    while 1
        x_initial = x0_vec( randi([1,size_initial],1),: );

        % the last vehicle
        p1_0 = rand(1)*2*L - L;
        v1_0 = x_initial(1);
        u1_0 = 0;
        BV{1} = [p1_0; v1_0; u1_0];

        % the front vehicle
        p2_0 = p1_0 + x_initial(2);
        v2_0 = v1_0 + x_initial(3);
        u2_0 = 0;
        BV{2} = [p2_0; v2_0; u2_0];
        
        % judge constraints
        if v2_0<Vmax && v2_0>Vmin && (p2_0-p1_0>safe_D)
            break;
        end
    end


    %% sample trajectories

    % sampling the front vehicle trajectories
    for i=1:N
        % sample acceleration
        id_V = getID( BV{2}(2,i), V );
        
        if BV{2}(2,i)<min(V)
            id_V = 1;
        end
        if BV{2}(2,i)>max(V)
            id_V = n_dis_V;
        end
        
        if sum( Dis_FF(id_V,:) ) ==0
            BV{2}(3,i) = 0;
        else
            Con_P1 = Dis_FF(id_V,:) ./ sum( Dis_FF(id_V,:) );
            BV{2}(3,i) = D_1_smp( Con_P1,U );
        end

        % update v and x
        BV{2}(2,i+1) = BV{2}(2,i) + BV{2}(3,i) * delt_T;
        BV{2}(1,i+1) = BV{2}(1,i) + BV{2}(2,i) * delt_T + 0.5 * BV{2}(3,i) * delt_T^2;
    end

    % sampling the following BV
    Con_P2 = [];
    for i=1:N
        % sample acceleration
        id_V = getID( BV{1}(2,i), V );
        id_R = getID( BV{2}(1,i)-BV{1}(1,i), R );
        id_RR = getID( BV{2}(2,i)-BV{1}(2,i), RR );

        if BV{1}(2,i)<min(V)
            id_V = 1;
        end
        if BV{1}(2,i)>max(V)
            id_V = n_dis_V;
        end
        
        if BV{2}(1,i)-BV{1}(1,i)>max(R)
            % range is too long
            id_R = n_dis_R;
        end
        
        if BV{2}(2,i)-BV{1}(2,i)>max(RR)
            id_RR = n_dis_RR;
        end
        
        if BV{2}(2,i)-BV{1}(2,i)<min(RR)
            id_RR = 1;
        end
        
        if sum( Dis_CF_M(id_V,id_R,id_RR,:) ) ~= 0 
            % if have data, then update the conditional distribution and sample
            Con_P2 = Dis_CF_M(id_V,id_R,id_RR,:) ./ sum( Dis_CF_M(id_V,id_R,id_RR,:) );      
            BV{1}(3,i) = D_1_smp( Con_P2,U );
        else if sum(Con_P2) ~=0
                % if no data, keep the same distribution
                BV{1}(3,i) = D_1_smp( Con_P2,U );
            else
                BV{1}(3,i) = 0;
            end
        end

        % update v and x
        v_new = BV{1}(2,i) + BV{1}(3,i) * delt_T;
        v_new = max(v_new, Vmin);
        v_new = min(v_new, Vmax);
        BV{1}(2,i+1) = v_new;

        % consider the safety constraints
        x_new = BV{1}(1,i) + BV{1}(2,i) * delt_T + 0.5 * BV{1}(3,i) * delt_T^2;
        x_new = min(x_new, BV{2}(1,i+1)-safe_D );
        BV{1}(1,i+1) = x_new;
    end

    % figure;
    % t_series = 0:delt_T:T;
    % for i=1:N_BV
    %     plot(t_series,BV{i}(1,:), 'linewidth',2);
    %     hold on;
    % end
    % plot(t_series, Vmin*t_series, 'k--', 'linewidth',2);
    % hold on;
    % plot(t_series, Vmax*t_series,'k--', 'linewidth',2);
    % hold on;
    % plot(t_series, L*ones(1,size(t_series,2)),'k--', 'linewidth',2);
    % hold on;
    % 
    % [diff, y ] = Difficulty(x_B0, u_B);
    % 
    % plot(y(1),y(2),'r*');
    % title(sprintf('Difficulty is %d', diff));

    result{exp_num} = F_Sim_LC(1, BV, [], N_BV, N, T, Vmin, Vmax, u_Max, L, delt_T, 0);
    
end

failure = zeros(1,total_time);
for i=1:total_time
    if result{i} == 1
        failure(i) = 0;
    else
        failure(i) = 1;
    end
end
prob_fail = zeros(1,total_time);
for i = 1:total_time
    prob_fail(i) = sum( failure(1:i) ) / i;
end

save failure-3.mat failure prob_fail;






