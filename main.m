% An prediction tool for the NCAA March Madness 2017 basketball tournament.
% The tournament already happened, so this is kind of moot.  Oh well.
% -------------------------------------------------------------------------

% Read in data into Matlab tables below.  Tables have columns with names,
% so to access the actual data, you must use curly braces {}.  Otherwise,
% parentheses return a smaller table.

% detailed results of games played during the season
season = readtable('RegularSeasonDetailedResults.csv');

% teams competing in the tournament and their associated id
teams = readtable('Teams.csv');

% the seed ranking of each team for the 2017 NCAA tournament.
seeds = readtable('TourneySeeds.csv');