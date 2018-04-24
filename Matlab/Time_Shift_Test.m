% Time Shifting

filename=['Group4_Test',num2str(4),'.csv'];
data=importdata(filename,',',16);
time=data.data(:,1);
v_incident=data.data(:,2);
v_transmitted=data.data(:,4);


speed = 5.0732e+03;
L= 2.438;
dt=8.0000e-09;

time_shift=L/speed;
index_shift=round(time_shift/dt);

v_forward=[zeros(index_shift,1);v_incident];
v_back=[v_incident;zeros(index_shift,1)];

plot((1:length(v_forward))*dt,v_forward,(1:length(v_back))*dt,v_back)
hold on
plot((1:length(v_forward))*dt,v_forward+v_back)