function [ val ] = n( table, col )
%NUM_CONV Converts number from a matlab table to a numeric value
%   Does above stuff
    val = str2double(table{1, col}{1});
end

