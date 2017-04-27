function [ matching ] = real_check( sim, actual, num_matches )
%REAL_CHECK Compares how close a prediction is to actual.
%   Compares the given results with the actual results (both are inputs).
%   Returns the number of matches out of num_matches that are correct.

    matching = 0;
    for i = 1:num_matches
        i
        disp(sim{i, 3});
        disp(actual(i));
        disp('----------------------------');
        if (sim{i, 3} == actual(i))
            matching = matching + 1;
        end
    end

end

