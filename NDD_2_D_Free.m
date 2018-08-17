% free flow NDD to Distribution
clear;clc;
load('FF.mat');

data = FF;
clear FF;

% ID
V_id = 4;
U_id = 9;
event_id = 12;

% discrete variables
n_data = size(data,1);
n_event = max(data(:,event_id));

dis_V = 1;
V = 20:dis_V:40;
n_dis_V = size(V,2);

dis_U = 0.2;
U = -4:dis_U:2;
n_dis_U = size(U,2);

size_all = n_dis_V * n_dis_U;

% initial the distribution
Dis_FF = zeros(n_dis_V, n_dis_U);


% main loop: check all data
curr_event = 1;
last_event = 1;
n_valid_data_dis = 0;
for i=2:n_data
    
    % a new event?
    curr_event = data(i,event_id);
    if curr_event == last_event % not a new event
        
        % get the ID
        tmp_dis_V = getID( data(i-1,V_id), V );
        tmp_dis_U = getID( data(i,U_id), U );
        
        % if the ID is positive (not extreme value)
        % add one sample to CF distribution
        if tmp_dis_V>0  && tmp_dis_U>0
            Dis_FF(tmp_dis_V,tmp_dis_U) = Dis_FF(tmp_dis_V,tmp_dis_U) + 1;
            n_valid_data_dis = n_valid_data_dis + 1;
        end
        
    end
    last_event = curr_event;    
    
end


% calculate probability
Dis_FF = Dis_FF ./ sum(Dis_FF(:));

save Dis_FF.mat Dis_FF ;

