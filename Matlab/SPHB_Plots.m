%% SHPB Test Data Plots

time=zeros(125000,15);
v_incident=zeros(125000,15);
v_transmitted=zeros(125000,15);

for i=1:14
    filename=['Group4_Test',num2str(i),'.csv'];
    data=importdata(filename,',',16);
    time(:,i)=data.data(:,1);
    v_incident(:,i)=data.data(:,2);
    v_transmitted(:,i)=data.data(:,4);
end

color=[0 0 0; 1 0 0; 0 1 0; 0 0 1; .5 .5 .5];
    
figure
hold on
   
for ii=1:5
    plot(time(:,ii),v_incident(:,ii),'.-','Color',color(ii,:))
    %plot(time(:,ii),v_transmitted(:,ii),'.','Color',color(ii,:))
end
legend({'Calibration','0.625 in Lead', '0.5 in Lead','0.375 in Lead','0.625 in Paper'})