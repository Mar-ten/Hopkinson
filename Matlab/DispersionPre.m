function [ Data ] = DispersionPre( amplitude,time )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Data.time=time;
Data.amp=amplitude;
Data.SampleTime=Data.time(2)-Data.time(1);
Data.Frequency=1/Data.SampleTime;
Data.Length=length(Data.time);


end

