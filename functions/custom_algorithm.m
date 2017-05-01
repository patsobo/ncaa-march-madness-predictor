function [ val ] = custom_algorithm( table )
%CUSTOM_ALGORITHM Our custom metrics for calculating a team's value.
%   This function, given a table of statistics for a certain team,
%   determines the "strength" of that team through our calculations.
    sos = n(table, 8);
    def = n(table, 16) / n(table, 3) - 3*sos;
    to = n(table, 33) - 2*sos;
    wl = n(table, 6) * sos;
    ppg = n(table, 15) / n(table, 3) + 5*sos;
    srs = n(table, 8);
    
    val = .25*def + .2*to - .16*wl - .16*ppg - .5*srs;

end

