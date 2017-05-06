% An prediction tool for the NCAA March Madness 2017 basketball tournament.
% The tournament already happened, so this is kind of moot.  Oh well.
%
% Authors:
%   Patrick Sobolewski - psobolew@mines.edu
%   Jeffrey Stephens - jstephen@mines.edu
%   James Neal - janeal@mines.edu
% -------------------------------------------------------------------------

% Read in data into Matlab tables below.  Tables have columns with names,
% so to access the actual data, you must use curly braces {}.  Otherwise,
% parentheses return a smaller table.

% detailed results of games played during the season
season = readtable('RegularSeasonDetailedResults.csv');
adv_season = readtable('2016-2017 Season Statistics.csv');

% teams competing in the tournament and their associated id
teams = readtable('Teams.csv');

% results of the 2017 tournament
%results = readtable('TourneySlots.csv');

% the seed ranking of each team for the 2017 NCAA tournament.
seeds_original = readtable('TourneySeeds.csv');
rows = seeds_original.Season == 2017;
seeds_original = seeds_original(rows, :);

% Represents the actual results of the tournament to compare against
% results should be starting from the top, and in W-X-Y-Z
% (east-west-midwest-south) order
real_results = {
    [1437, 1181, 1124, 1196, 1438, 1425, 1376, 1458, 1211, 1112, 1199, 1452, 1323, 1462, 1388, 1321, 1242, 1257, 1332, 1345, 1235, 1348, 1276, 1277, 1314, 1246, 1417, 1139, 1292, 1153, 1455, 1116], ...
    [1458, 1376, 1124, 1196, 1211, 1112, 1462, 1452, 1242, 1276, 1332, 1345, 1314, 1246, 1417, 1139], ...
    [1196, 1376, 1211, 1462, 1242, 1332, 1314, 1246], ...
    [1376, 1211, 1332, 1314], ...
    [1211, 1314], ...
    [1314] ...
};

% weights for custom algorithm
% original values are our human-biased predictions
weights = [.25, .2, .16, .16, .5];
%weights = zeros(5, 1);

%{
% variables for computing correlation between statistics
turnovers
srs
rebounds
%}

% keep running rounds until you''re left with one champion
num_trials = 100;
accuracies = zeros(num_trials, 1);
random = 0;

% optimize the algorithm
weights_optimized = weights;%zeros(length(weights), 1);
data_plot = [];
for i = 1:length(weights_optimized)
    best_accuracy = 0;
    for j=linspace(0, 2, 100)
        weights_optimized(i) = j;
        accuracy = run_tournament(seeds, teams, adv_season, weights_optimized, real_results, 0);
        if (accuracy > best_accuracy)
            %disp(weights_optimized(i));
            disp(accuracy);
            data_plot = [data_plot accuracy];
            weights(i) = weights_optimized(i) / 2;
            best_accuracy = accuracy;
        end
    end
    weights_optimized(i) = weights(i);
    disp('+++++++++++++++++++++++++++');
end

figure;
plot(data_plot);
ylabel('Accuracy');
xlabel('Improvement Cycles');
title('Optimization of Custom Algorithm Accuracy');

% run with optimal inputs
disp('OPTIMIZED ALGORITHM RESULTS');
accuracy = run_tournament(seeds, teams, adv_season, weights_optimized, real_results, 0);
disp(accuracy);

for i = 1:num_trials
    seeds = seeds_original;
    
    accuracy = run_tournament(seeds, teams, adv_season, weights, real_results, random);
    disp('Accuracy: ');
    disp(accuracy);
    disp(total_matches);
    disp('------------------');
    
    % update randomness, store accuracy
    random = random + 5;
    accuracies(i) = accuracy;
end
    
plot(accuracies);

%{
% add three random categories to the algorithm
for i = 1:3
    random = rand;
    slice = 1/7;
end
%}