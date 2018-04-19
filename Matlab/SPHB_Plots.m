
%% SHPB Test Data Plots

clc
clear

time=zeros(125000,14);
v_incident=zeros(125000,14);
v_transmitted=zeros(125000,14);

for i=1:14
    filename=['Group4_Test',num2str(i),'.csv'];
    data=importdata(filename,',',16);
    time(:,i)=data.data(:,1);
    v_incident(:,i)=data.data(:,2);
    v_transmitted(:,i)=data.data(:,4);
end

color=[0 0 0; 1 0 0; 0 1 0; 0 0 1; .5 .5 .5];
    
figure(1)
hold on
   
for ii=1:5
    plot(time(:,ii),v_incident(:,ii),'.-','Color',color(ii,:))
    %plot(time(:,ii),v_transmitted(:,ii),'.','Color',color(ii,:))
end
legend({'Calibration','0.625 in Lead', '0.5 in Lead','0.375 in Lead','0.625 in Paper'})

%% Wave data analysis

speed = BarSpeed(5,2.4384);                                                %compute bar speed from recorded data
strength = zeros(1,14);                                                    %vector to store computed strength values
for i=6:6                                                                  %each iteration of i will compute the strength value for a single dataset, set to just compute 1 to limit time
                                               
    dt = time(2,i)-time(1,i);                                              %time step in recorded data
    
    
    incident_avg = mean(v_incident(1:100,i));                              %average in signal noise of incident wave
    count = 1;                                                             %used to index
    
    [a, b] = max(v_incident(:,i));                                         %a is max value of incident wave, b is index of this value
    [c, d] = min(v_incident(:,i));                                         %c is max value of reflected wave, d is index of this value

    index = floor((d-b)/2);                                                %midpoint of incident/reflected waves. This is the number of index values to transform incident/reflected waves
        
    num = floor((0.9652/speed)/dt);                                        %used bar speed to find index of transmitted wave rise
    
    for j=1:125000
        if v_incident(j,i) > 9.15*incident_avg                             %average computed earlier used to trigger start of incident wave
            incident(count,1) = time(j,i);                                 %time values for incident wave
            incident(count,2) = v_incident(j,i);                           %voltage values for incident wave
            if count == 1
                mark = j;                                                  %index of trigger for incident wave
            end
            count = count+1;                                               %increased index
        end

    end
    
    n=1:1:length(incident);                                                    %number of recorded data points for incident wave
    N = floor(length(incident)/2);                                                               %this is an input for the equations I think
    T = incident(length(incident),1)-incident(1,1);                                       %total elapsed time from start of incident wave to end
    rate = length(incident)/T;                                                            %sampling rate of system
    k=1:1:N;
    w0 = (2*pi)/T;
    
    for m=1:n
    
        reflect(m,1) = time(mark+m+(d-b),i);                               %center index value found earlier used to compute start of reflected wave pulse, time values
        reflect(m,2) = v_incident(mark+m+(d-b),i);                         %voltage values for reflected pulse
        transmitted(m,1) = time(mark+num+index+m,i);                       %center index value used to compute start of reflected pulse, time values
        transmitted(m,2) = v_transmitted(mark+index+num+m,i);              %voltage values for reflected pulse
        
    end
    
    frequencies = zeros(1,N);
    Ck = zeros(1,N);
    frequencies(1:end) = k(1:end).*(rate/N);
    Ck(1:end) = k(1:end).*w0.*frequencies(1:end)./(2*pi);
    
    incident_t = fft(incident(:,2))/(N/2);
    F_incident = zeros(1,length(n));
    for q=1:length(n)
%         F_incident(q) = (A0/2)+sum;
        check = 0;
        
        for l=1:N
            phi(l) = k(l)*w0*(1.2192/Ck(l));
            check = check + F_incident(q)+imag(incident_t(l))*cos((k(l)*w0*incident(q,1))-phi(l))+...
                real(incident_t(l))*sin((k(i)*w0*incident(q,1))-phi(l));
        end
        
        F_incident(q) = check;
        
    end
    
    reflect_t = fft(reflect)/(N/2);
    transmit_t = fft(transmitted)/(N/2);
    
    
    
    figure(2)
    plot(incident(:,1),incident(:,2))
    figure(3)
    plot(incident(:,1),F_incident(:))
    
    
    
end
