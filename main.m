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

% the seed ranking of each team for the 2017 NCAA tournament.
seeds = readtable('TourneySeeds.csv');