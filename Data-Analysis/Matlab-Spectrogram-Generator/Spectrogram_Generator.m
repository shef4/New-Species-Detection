clc;
close all;
clear all;
%%Data Information
%CompressionMethod: 'Uncompressed'
%NumChannels: 2
%SampleRate: 16000
%TotalSamples: 28768000
%Duration: 1798
%Title: []
%Comment: []
%Artist: []
%BitsPerSample: 16
%% Information Collector
%myDir = uigetdir; %gets directory
%sampleFiles = dir(fullfile(myDir,'Sample-Audio/Rainforest-Audio (1).wav');

%info = audioinfo(sampleFiles)

%% Spectrogram Generator
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.wav')); %gets all wav files in struct

for i = 1:length(myFiles)
    baseFileName = myFiles(i).name;
    fullFileName = fullfile(myDir, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    [wavData, fs] = audioread(fullFileName);
%    [x, fs] = audioread('Sample-Audio/Rainforest-Audio (1).wav');
    spectrogram(wavData(:,1),hanning(256),128,256,fs,'yaxis');
    name = 'Rainforest Spectrogram Sample ' + string(i);
    title(name)
    colormap Jet
    filename = 'Spectrogram/Rainforest-Spectrogram(' + string(i) +').png'
    saveas(gcf,filename);
end

