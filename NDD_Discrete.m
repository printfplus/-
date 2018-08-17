%% discrete original data
clear;clc;
load('CF.mat');

data = CF;
clear CF;

% ID
V_id = 4;
U_id = 9;
R_id = 10;
RR_id = 11;

% discrete variables
n_data = size(data,1);

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

Dis_NDD = zeros(n_data,4);
n_valid_data_dis = 1;
for i=1:n_data
    
    % get the ID
    tmp_dis_V = getID( data(i,V_id), V );
    tmp_dis_R = getID( data(i,R_id), R );
    tmp_dis_RR = getID( data(i,RR_id), RR );
    tmp_dis_U = getID( data(i,U_id), U );
        
    if tmp_dis_V>0 && tmp_dis_R>0 && tmp_dis_RR>0 && tmp_dis_U>0
        Dis_NDD(n_valid_data_dis,1) = V(tmp_dis_V);
        Dis_NDD(n_valid_data_dis,2) = R(tmp_dis_R);
        Dis_NDD(n_valid_data_dis,3) = RR(tmp_dis_RR);
        Dis_NDD(n_valid_data_dis,4) = U(tmp_dis_U);
        n_valid_data_dis = n_valid_data_dis + 1;
    end
    
end
Dis_NDD = Dis_NDD(1:n_valid_data_dis,:);
save Dis_NDD.mat Dis_NDD;
