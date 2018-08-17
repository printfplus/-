% LC simulation by NDD
clear global;
clear; clc;

load('Dis_CF.mat');

n_dis_V = size(V,2);
n_dis_R = size(R,2);
n_dis_RR = size(RR,2);
n_dis_U = size(U,2);


N_BV = 2;

%% sample initial condition
% calculate conditional probability
% V, Range, Range Rate
P_RR_Cond = cell(n_dis_V,n_dis_R);
P_V_Cond = cell(n_dis_R,n_dis_RR);
P_R_Cond = cell(n_dis_V,n_dis_RR);
for i=1:n_dis_V
    for j=1:n_dis_R
        P_RR_Cond{i,j} = zeros(1,n_dis_RR);
        if sum(Ini_CF_M(i,j,:)) ~= 0
            P_RR_Cond{i,j}(:) = Ini_CF_M(i,j,:) ./ sum(Ini_CF_M(i,j,:));
        end
    end
end
for i=1:n_dis_R
    for j=1:n_dis_RR
        P_V_Cond{i,j} = zeros(1,n_dis_V);
        if sum(Ini_CF_M(:,i,j)) ~= 0
            P_V_Cond{i,j}(:) = Ini_CF_M(:,i,j) ./ sum(Ini_CF_M(:,i,j));
        end
    end
end
for i=1:n_dis_V
    for j=1:n_dis_RR 
        P_R_Cond{i,j} = zeros(1,n_dis_R);
        if sum(Ini_CF_M(i,:,j)) ~= 0
            P_R_Cond{i,j}(:) = Ini_CF_M(i,:,j) ./ sum(Ini_CF_M(i,:,j));
        end
    end
end
x0 = [ mean(V), mean(R), mean(RR) ];
total = 1e6;
x0_vec = Gibbs(x0, {P_V_Cond,P_R_Cond,P_RR_Cond},{V,R,RR},total);
% save Initial_Cond.mat x0_vec;


%compare
% load('CF.mat');
load('Dis_NDD.mat');
err = Compare_Dis(x0_vec(:,2),Dis_NDD(:,2),R);

x_initial = x0_vec( randi([1,size_initial],1) );