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

% results of the 2017 tournament
%results = readtable('TourneySlots.csv');

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
current_round = 1;

% Creating our simulation of the bracket
conf_size = 16;
round_matches = conf_size * 2;
total_matches = round_matches;
total_correct = 0;

%{
% variables for computing correlation between statistics
turnovers
srs
rebounds
%}

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
            [u_score, l_score] = match(u_team, l_team, teams, adv_season);

            % higher seeded team won
            if (u_score <= l_score)
                losing_teams = [losing_teams l_index];
            else
                losing_teams = [losing_teams u_index];
            end
        end
    end
    
    % calculate how accurate this round was
    seeds(losing_teams, :) = [];    
    matching = real_check(seeds, real_results{current_round}, round_matches);
    total_correct = total_correct + matching;
    current_round = current_round + 1;
    
    conf_size = conf_size / 2;
    round_matches = round_matches / 2;
    total_matches = total_matches + round_matches;
    
    % if you've found a champ of each conference, pretend it's a new four
    % man fake conference to finish out the final four
    if (conf_size <= 1)
        conf_size = 4;
        round_matches = conf_size / 2;
    end
end

% print out accuracy
disp('Accuracy: ');
disp(total_correct / total_matches);
disp(total_matches);
disp('------------------');

% add three random categories to the algorithm
for i = 1:3
    random = rand;
    slice = 1/7;
end
