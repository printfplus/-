function [ Flag_LC ] = F_Sim_LC(flag_BV, BV, xgs, N_BV, N, T, Vmin, Vmax, u_Max, L, delt_t_true, flag_display)
% lane change of simulation 
% flag_BV : 1, input the trajectories of BV not xgs;
% BV: 1, back vehicle; N, leader vehicle
% flag_display: 1, plot the results
% Flag_LC: 1, LC successfully!

Flag_LC = 0; % success:1;
PT = 10; %10s
tF = 0.5;
tB = 0.5;
ds = 1;

% threshold
Th_LC_x = 10;
T_tF = 3;
T_tB = 3;
        
if flag_BV==0
    % true trajectories of BV
    BV = cell(1,N_BV);
    d_BV = 2 + N;
    z = N_BV;
    for i=1:N_BV
        BV{z}(1,1) = xgs(d_BV*(i-1)+1);
        BV{z}(2,1) = xgs(d_BV*(i-1)+2);
        for j=1:N
            BV{z}(3,j) = xgs(d_BV*(i-1)+2+j);
        end
        z = z - 1;
    end

    for t = delt_t_true : delt_t_true : T
        index_t = round(t / delt_t_true) + 1;
        for i=1:N_BV
            % update acceleration
            if size(BV{i}(3,:),2) < index_t
                BV{i}(3,index_t) = BV{i}(3,index_t-1); % keep the acceleration
            end
            BV{i}(2,index_t) = BV{i}(2,index_t-1)+BV{i}(3,index_t-1)*delt_t_true; % update v
            BV{i}(1,index_t) = BV{i}(1,index_t-1)+BV{i}(2,index_t-1)*delt_t_true+0.5*BV{i}(3,index_t-1)*delt_t_true^2; % update x
        end
    end
end



% initial AV
AV = zeros(3,T/delt_t_true+1);
AV(1,1) = 0;
AV(2,1) = 15;
AV(3,1) = 0;

% simulation
for t = delt_t_true : delt_t_true : T
    
    index_t = round(t / delt_t_true) + 1;
    
    % update AV
    AV(2,index_t) = AV(2,index_t-1) + AV(3,index_t-1) * delt_t_true;
    AV(1,index_t) = AV(1,index_t-1) + AV(2,index_t-1) * delt_t_true + 0.5 * AV(3,index_t-1) * delt_t_true^2;
    
    % predict trajectories of BV
    P_BV = cell(1,N_BV);
    for i=1:N_BV
        P_BV{i}(1:3,1) = BV{i}(1:3,index_t);
        for j=2:PT+1
            P_BV{i}(1,j) = P_BV{i}(1,j-1)+P_BV{i}(2,j-1)*delt_t_true+0.5*P_BV{i}(3,j-1)*delt_t_true^2; % update x
            P_BV{i}(2,j) = P_BV{i}(2,j-1)+P_BV{i}(3,j-1)*delt_t_true; % update v
            P_BV{i}(3,j) = P_BV{i}(3,j-1); % keep the acceleration
        end
    end
    
 
    % Select a inter-vehicle gap and initiation time
    
    %reachable of AV
    AV_R_Max = zeros(2,PT+1);
    AV_R_Max(1:2,1) = AV(1:2,index_t);
    AV_R_Min = zeros(2,PT+1);
    AV_R_Min(1:2,1) = AV(1:2,index_t);
    for j=1:PT+1
        %update reachable set
        AV_R_Max(2,j+1) = min(Vmax,AV_R_Max(2,j) + u_Max * delt_t_true);
        AV_R_Max(1,j+1) = AV_R_Max(1,j) + delt_t_true * AV_R_Max(2,j);
        AV_R_Min(2,j+1) = min(Vmin,AV_R_Min(2,j) - u_Max * delt_t_true);
        AV_R_Min(1,j+1) = AV_R_Min(1,j) + delt_t_true * AV_R_Min(2,j);
    end
    
    % calculate "time-position"
    Ag = zeros(1,N_BV+1);
    AxMax = zeros(N_BV+1, PT+1);
    AxMin = zeros(N_BV+1, PT+1);
    for i=1:N_BV+1
        
        if i==1 % no front vehicle         
            
            for j=1:PT+1
                
                xB = P_BV{i}(1,j) + tB * P_BV{i}(2,j) + ds;
                
                AxMax(i,j) = min(L,Vmax*t);
                AxMax(i,j) = min(AxMax(i,j), AV_R_Max(1,j));
                AxMin(i,j) = max( P_BV{i}(1,j),AV_R_Min(1,j) );
                AxMin(i,j) = max(AxMin(i,j), Vmin*t);
                
                Ag(i) = Ag(i) + max( 0, AxMax(i,j) - AxMin(i,j));
            end
            
            else if i==N_BV+1 % no back vehicle
                    
                    for j=1:PT+1
                        
                        xF = P_BV{i-1}(1,j) + tF * P_BV{i-1}(2,j) + ds;
                        
                        AxMax(i,j) = min( P_BV{i-1}(1,j), AV_R_Max(1,j));
                        AxMax(i,j) = min(AxMax(i,j), Vmax*t);
                        AxMax(i,j) = min(AxMax(i,j), L);
                        AxMin(i,j) = max( Vmin*t, AV_R_Min(1,j));
                        
                        Ag(i) = Ag(i) + max( 0, AxMax(i,j) - AxMin(i,j) );
                        
                    end
                    
                else
                    for j=1:PT+1
                        
                        xF = P_BV{i-1}(1,j) + tF * P_BV{i-1}(2,j) + ds;
                        xB = P_BV{i}(1,j) + tB * P_BV{i}(2,j) + ds;

                        AxMax(i,j) = min( P_BV{i-1}(1,j), AV_R_Max(1,j));
                        AxMax(i,j) = min(AxMax(i,j), Vmax*t);
                        AxMax(i,j) = min(AxMax(i,j), L);
                        AxMin(i,j) = max( P_BV{i}(1,j),AV_R_Min(1,j) );
                        AxMin(i,j) = max(AxMin(i,j), Vmin*t);

                        Ag(i) = Ag(i) + max( 0, AxMax(i,j) - AxMin(i,j) );
                        
                    end

                    
                end
        end
        
        
        
    end
    
    % select a gap for lane-change
    if any(Ag)==1
        
        Gap_ID = find(Ag == max(Ag), 1, 'first');

        % judge lane change point
        if Gap_ID==1 % no front BV
            TTC_F = 1e3;
            TTC_B = (AV(1,index_t)-BV{Gap_ID}(1,index_t)) / (BV{Gap_ID}(2,index_t)-AV(2,index_t));      
            ds_F = 1e3;
            ds_B = AV(1,index_t)-BV{Gap_ID}(1,index_t);
        else if Gap_ID==N_BV+1 % no back BV
                TTC_F = (AV(1,index_t)-BV{Gap_ID-1}(1,index_t)) / (BV{Gap_ID-1}(2,index_t)-AV(2,index_t));   
                TTC_B = 1e3;
                ds_F = BV{Gap_ID-1}(1,index_t) - AV(1,index_t);
                ds_B = 1e3;
            else
                TTC_F = (AV(1,index_t)-BV{Gap_ID-1}(1,index_t)) / (BV{Gap_ID-1}(2,index_t)-AV(2,index_t));
                TTC_B = (AV(1,index_t)-BV{Gap_ID}(1,index_t)) / (BV{Gap_ID}(2,index_t)-AV(2,index_t));
                ds_F = BV{Gap_ID-1}(1,index_t) - AV(1,index_t);
                ds_B = AV(1,index_t)-BV{Gap_ID}(1,index_t);
            end
        end


        if ds_F>Th_LC_x && ds_B>Th_LC_x && abs(TTC_F)>T_tF && abs(TTC_B)>T_tB % AV can lane change now
            
            Flag_LC = 1;
            AV(1:3,index_t);
            if flag_display == 1
                fprintf('Lane Change Successfully!\n');
                plot(0:delt_t_true:t, AV(1,1:index_t),'g' , 'linewidth', 2);
                hold on;
                plot(t, AV(1,index_t),'ko','MarkerSize',6,'MarkerFaceColor','k');
            end

            break;
        end

        % can't lane change now;
        % to get the lane change point;
        % planning AV's trajectories P control
        P_x = 0.5;
        P_v = 0.5;
        if Gap_ID==1 % no front BV
            u_A = P_x * (P_BV{Gap_ID}(1,2)+Th_LC_x - AV(1,index_t)) + P_v * (P_BV{Gap_ID}(2,2)-AV(2,index_t));

        else if Gap_ID==N_BV+1 % no back BV
            u_A = P_x * (P_BV{Gap_ID-1}(1,2)-Th_LC_x - AV(1,index_t)) + P_v * (P_BV{Gap_ID-1}(2,2)-AV(2,index_t));

            else
                obj_x = 0.5 * (  P_BV{Gap_ID-1}(1,2) + P_BV{Gap_ID}(1,2)  );
                u_A = P_x * ( obj_x - AV(1,index_t)) + P_v * ( P_BV{Gap_ID}(2,2)-AV(2,index_t));
            end
        end
        u_A = min(u_A,u_Max);
        u_A = max(u_A,-u_Max);

        AV(3,index_t) = u_A;
        
    end
    
    
end

if Flag_LC==0
    fprintf('Lane Change Failure!\n');
end


end

