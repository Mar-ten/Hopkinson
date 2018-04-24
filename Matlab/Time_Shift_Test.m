% Time Shifting
close all
clear all

filename=['Group4_Test',num2str(8),'.csv'];
data=importdata(filename,',',16);
time=data.data(:,1);
v_incident=data.data(:,2);
v_transmitted=data.data(:,4);


speed = 5.0732e+03;
L= 2.438;
dt=8.0000e-09;

time_shift=L/speed;
index_shift=round(time_shift/dt);


%% Pad and Shift Data
v_forward=[zeros(index_shift,1);v_incident];
v_back=[v_incident;zeros(index_shift,1)];
v_diff=v_forward+v_back;
%% Trim Data
Lcut=round(length(v_diff)/3);

v_forward(1:Lcut)=[]; v_forward(end-Lcut:end)=[];
v_back(1:Lcut)=[]; v_back(end-Lcut:end)=[];
v_diff(1:Lcut)=[]; v_diff(end-Lcut:end)=[];

%% Plots

plot((1:length(v_forward))*dt,v_forward,(1:length(v_back))*dt,v_back,(1:length(v_back))*dt,v_diff)
legend('Incident','Reflected','Difference');
