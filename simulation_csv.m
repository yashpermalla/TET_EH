%COMB_SimulationToCSV.m
%This file runs a simulation of the base VIEH system and writes the results
%as a CSV file to be read by other programs later.

function simulation_csv(param_file, filename)
    %param_file a string name for the file to take parameters from. MUST
    %HAVE .mat AT THE END.
    %filename a name for the csv file to be saved to. MUST HAVE .csv AT THE
    %END.
    load(param_file);

    %Conduct simulation
    simulation_data = rk(equ, z0, h, t0, t_end, coll_etol);
    simulation_table = array2table(simulation_data, 'VariableNames', ...
        {'Time', 'Z', 'Z_dot', 'Collision'});

    %Write results to CSV
    writetable(simulation_table, filename);
end