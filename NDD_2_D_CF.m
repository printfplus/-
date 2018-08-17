% CF NDD to Distribution
clear;clc;
load('CF.mat');

data = CF;
clear CF;

% ID
V_id = 4;
U_id = 9;
R_id = 10;
RR_id = 11;
event_id = 12;

% discrete variables
n_data = size(data,1);
n_event = max(data(:,event_id));

dis_V = 1;
V = 20:dis_V:40;
n_dis_V = size(V,2);

dis_R = 5;
R = 0:dis_R:115;
n_dis_R = size(R,2);

dis_RR = 1;
RR = -10:dis_RR:8;
n_dis_RR = size(RR,2);

dis_U = 0.2;
U = -4:dis_U:2;
n_dis_U = size(U,2);

size_all = n_dis_V * n_dis_R * n_dis_RR * n_dis_U;

% initial the distribution
Dis_CF = cell(n_dis_V, n_dis_R);
for i=1:n_dis_V
    for j=1:n_dis_R
        Dis_CF{i,j} = zeros(n_dis_RR, n_dis_U);
    end
end

% initial the initial condition
Ini_CF = cell(1,n_dis_V);
for i=1:n_dis_V
    Ini_CF{i} = zeros(n_dis_R, n_dis_RR);
end


% main loop: check all data
curr_event = 1;
last_event = 1;
n_valid_data_dis = 0;
n_valid_data_ini = 0;
for i=2:n_data
    
    % a new event?
    curr_event = data(i,event_id);
    if curr_event == last_event % not a new event
        
        % get the ID
        tmp_dis_V = getID( data(i-1,V_id), V );
        tmp_dis_R = getID( data(i-1,R_id), R );
        tmp_dis_RR = getID( data(i-1,RR_id), RR );
        tmp_dis_U = getID( data(i,U_id), U );
        
        % if the ID is positive (not extreme value)
        % add one sample to CF distribution
        if tmp_dis_V>0 && tmp_dis_R>0 && tmp_dis_RR>0 && tmp_dis_U>0
            Dis_CF{tmp_dis_V,tmp_dis_R}(tmp_dis_RR,tmp_dis_U) = Dis_CF{tmp_dis_V,tmp_dis_R}(tmp_dis_RR,tmp_dis_U) + 1;
            n_valid_data_dis = n_valid_data_dis + 1;
        end
        % add one sampling to CF initial conditions
        if tmp_dis_V>0 && tmp_dis_R>0 && tmp_dis_RR>0
            Ini_CF{tmp_dis_V}(tmp_dis_R,tmp_dis_RR) = Ini_CF{tmp_dis_V}(tmp_dis_R,tmp_dis_RR) + 1;
            n_valid_data_ini = n_valid_data_ini + 1;
        end
        
    end
    last_event = curr_event;    
    
end

% matrix form
Dis_CF_M = zeros(n_dis_V, n_dis_R, n_dis_RR, n_dis_U);
Ini_CF_M = zeros(n_dis_V, n_dis_R, n_dis_RR);

for i=1:n_dis_V
    for j=1:n_dis_R
        Dis_CF_M(i,j,:,:) = Dis_CF{i,j};
    end
end

for i=1:n_dis_V
    Ini_CF_M(i,:,:) = Ini_CF{i};
end

% calculate probability
for i=1:n_dis_V
    for j=1:n_dis_R
        Dis_CF{i,j} = Dis_CF{i,j} ./ sum(Dis_CF{i,j}(:));
    end
end

for i=1:n_dis_V
    Ini_CF{i} = Ini_CF{i} ./ sum(Ini_CF{i}(:));
end


save Dis_CF.mat Dis_CF dis_R dis_RR dis_U Ini_CF R RR U V Dis_CF_M Ini_CF_M;

