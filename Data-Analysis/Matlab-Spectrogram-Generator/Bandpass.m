clc;
close all;
clear all;
%% Check Data
cd_name=['C:\Data\Nov\11-19\2\'];
cd(cd_name) 
[FileName,PathName] = uigetfile('*.mat','cd');
load([PathName FileName]);
fs=250e3;% we are using 400e3;
f=data;
t0= 0;  % Select the start time t0, time duration you want to do the bandpass
t1= 1;  % Select the end time t1
t=t0:1/fs:t1;
inp=f;Alltime_start=[];Alltime_end=[];
%% FIR Bandpass filter Parameters
FilPara.Fstop1 = 45e3;      % First Stopband Frequency
FilPara.Fpass1 = 48e3;      % First Passband Frequency
FilPara.Fpass2 = 66e3;      % Second Passband Frequency
FilPara.Fstop2 = 70e3;      % Second Stopband Frequency
FilPara.Astop1 = 60;        % First Stopband Attenuation (dB)
FilPara.Apass = 0.5;        % Passband Ripple (dB)
FilPara.Astop2 = 60;        % Second Stopband Attenuation (dB)                            % fs: sampling frequency
%% make the bandpass filter 
h = fdesign.bandpass(FilPara.Fstop1, FilPara.Fpass1, FilPara.Fpass2, FilPara.Fstop2, FilPara.Astop1, FilPara.Apass, FilPara.Astop2, fs);
Hd = design(h, 'equiripple');
fil=Hd.Numerator;
%% save the filter
name=['Band_fil_' num2str(fs) '_' num2str(FilPara.Fpass1) '_' num2str(FilPara.Fpass2) '.wav'];
save(name,'fil','fs','FilPara');
%% Filter Process
out=filtfilt(fil,1,inp);
save('out','out','fs');% Save the filtered data
%%Plot
subplot(2,1,1);
spectrogram(out(:,mic_n),hanning(256),128,256,fs,'yaxis');
 [~,ps] = spectrogram(out(:,mic_n),[],[],[],fs,'yaxis');
caxis([-100 -40]);
oldcmap = colormap;
colormap( flipud(oldcmap) );
xlim([1.05 1.15]);  % Set the plot duration 
ylim([47500 66500]);% Set the spectrogram frequency range 
subplot(2,1,2);
plot((1:length(out))/fs,out(:,mic_n));
axis([1.05 1.15 -1.2*max(out(:,1)) 1.2*max(out(:,1))]);