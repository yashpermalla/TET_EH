%COMB_Bifurc_Driver.m
%Driver file for plotting bifurcation diagrams for inputted paramter sets

clc, clear all, close all


name = 'beta_bifurc_varied_A_6pi';
plotit(name,1,2,'beta', '$\dot{w}(t_{k-1}), \dot{w}(t_{k})$');