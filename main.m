clc; 
clear; 
close all; 

fileName=strcat('Data_RP3_Breath_T2');
mvAvgWindow=750;
timeinterval_start=5;
timeinterval_end=30;

[Inhalation,Exhalation,Resp_Rate,MagnitudeParameters,entropy,exvol0]=FinalizedBreathingIndex(fileName,mvAvgWindow,timeinterval_start,timeinterval_end)
