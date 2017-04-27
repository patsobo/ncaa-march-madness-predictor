function [ val ] = custom_algorithm( table )
%CUSTOM_ALGORITHM Summary of this function goes here
%   Detailed explanation goes here
    sos = n(table, 8);
    def = n(table, 16) / n(table, 3) - 3*sos;
    to = n(table, 33) - 2*sos;
    wl = n(table, 6) * sos;
    ppg = n(table, 15) / n(table, 3) + 5*sos;
    srs = n(table, 8);
    
    val = .25*def + .2*to - .16*wl - .16*ppg - .5*srs;

end

