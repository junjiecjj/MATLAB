clear;
clc;
close all;


Nt = 4;
Nr = 4;


H = (randn(Nr,Nt)+1j*randn(Nr,Nt)).*sqrt(1/2);
data = randi([0 1], Nt*4, 1);
x = qammod(data, 16, 'UnitAveragePower', true, 'InputType','bit');
x = x.';
h = randn(Nr,1);
%h = h.';
x4 =  soft_decision_sigma(x,h);