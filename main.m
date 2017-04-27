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
rows = seeds.Season == 2017;
seeds = seeds(rows, :);

% Creating our simulation of the bracket
conf_size = 16;

% keep running rounds until you''re left with one champion
while (size(seeds, 1) > 1)
    losing_teams = [];
    for u_index = 1:size(seeds, 1)
        % get the teams for the match-up
        u_seed = mod(u_index, conf_size);
        % adjust for error in mod calculation
        if (u_seed == 0)
            u_seed = conf_size;
        end
        l_seed = conf_size - u_seed + 1;

        % only execute algorithm for top half of teams as upper seeds
        if (l_seed > u_seed)
            l_index = l_seed - u_seed + u_index;
            u_team = seeds.Team(u_index);
            l_team = seeds.Team(l_index);

            % simulate a match, get the scores of each team
            % lower score wins
            [u_score, l_score] = match(u_team, l_team);

            % higher seeded team won
            if (u_score <= l_score)
                losing_teams = [losing_teams l_index];
            else
                losing_teams = [losing_teams u_index];
            end
        end
    end
    seeds(losing_teams,:) = [];
    conf_size = conf_size / 2;
    if (conf_size <= 1)
        conf_size = 4;
    end
end

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