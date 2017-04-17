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


% Building our algorithm now

% our hand-picked categories
categories = ['defense', 'ppg', 'reb', 'fg', '3pt', 'ft', 'ftm', '3pm', 'wl', 'oreb', 'to'];
pmf = [.25, .15, .08, .08, .08, .08, .08, .08, .16, .08, .20];

% these four categories will always be used in the algorithm
indexes = [1, 2, 9, 11];

% add three random categories to the algorithm
for i = 1:3
    random = rand;
    slice = 1/7;
end

% run through each category and determine a winner, add to a total score
l_score = 0;
r_score = 0;

% determine winner
winner = 'UNC';