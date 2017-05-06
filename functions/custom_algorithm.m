function [ val ] = custom_algorithm( table, weights, random )
%CUSTOM_ALGORITHM Our custom metrics for calculating a team's value.
%   This function, given a table of statistics for a certain team,
%   determines the "strength" of that team through our calculations.
    sos = n(table, 8);
    def = n(table, 16) / n(table, 3) - 3*sos;
    to = n(table, 33) - 2*sos;
    wl = n(table, 6) * sos;
    ppg = n(table, 15) / n(table, 3) + 5*sos;
    srs = n(table, 8);
    
    val = weights(1)*def + weights(2)*to - weights(3)*wl - weights(4)*ppg - weights(5)*srs + (rand(1) * random);
    %val
end

