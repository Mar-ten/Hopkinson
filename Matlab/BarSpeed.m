function [ c] = BarSpeed( FileNumber,del_x )
%Calulate bar speed for SPHP
%   Detailed explanation goes here
filename=['Group4_Test',num2str(FileNumber),'.csv'];
data=importdata(filename,',',16);
t=data.data(:,1);
v_i=data.data(:,2);

v_max = max(v_i);
v_min = min(v_i);
InxStart= find(v_i==v_max);
InxStop = find(v_i==v_min);
t1= t(InxStart);
t2 = t(InxStop);
del_t=t2(length(t2))-t1(1);
c = del_x/del_t;

end

