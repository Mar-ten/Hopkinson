function [ Dispersed ] = Dispersion( Data, WaveSpeed )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
NFFT=2^nextpow2(Data.Length);
FT=fft(Data.amp,NFFT)/Data.Length;
Freq=Data.Frequency/2*linspace(0,1,NFFT/2+1);

%figure; plot(Freq,2*abs(FT(1:NFFT/2+1)))


end

