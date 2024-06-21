%plot.m
%This file plots a given simulation data.

function plotit(csv_filename, col_1, col_2, x_title, y_title)
    %csv_filename a string name for the file which has the csv table D.
    %col_1 first column to graph (x-variable)
    %col_2 second column to graph (y-variable)
   
    M = readmatrix(csv_filename+".csv");
    x = M(:,col_1);
    y = M(:,col_2);

    figure;
    scatter(x,y);
    xlabel(x_title, 'Interpreter','latex');
    ylabel(y_title, 'Interpreter','latex');
    title(y_title + "vs. " + x_title, 'Interpreter', 'latex');
    hold off

end