%COMB_Bifurc_Driver.m
%Driver file for plotting bifurcation diagrams for inputted paramter sets

clc, clear all, close all


name = 'A_bifurc_resonance';
plotit(name,1,2,'Amplitude (N)', '$\dot{w}(t_{k-1}), \dot{w}(t_{k})$');