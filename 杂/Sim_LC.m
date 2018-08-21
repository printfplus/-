% simulation of lane change
clear;clc;
clear global;
load('Opt_4.mat');
% Traj_plot(xgs, N_BV, N, T, Vmin, Vmax);
% hold on;

flag = F_Sim_LC(0, [], xgs, N_BV, N, T, Vmin, Vmax, u_Max, L, delt_t_true,1);


