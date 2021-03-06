function [ u_score, l_score ] = match( u_team, l_team, teams, adv_season, weights, random )
%MATCH Simulates a match between the two given teams.
%   Given two team indexes, gets data for those teams and creates a "score"
%   for each of the teams, the lower score winning the matchup.
   
    % our hand-picked categories
    categories = ['defense', 'ppg', 'reb', 'fg', '3pt', 'ft', 'ftm', '3pm', 'wl', 'oreb', 'to'];
    pmf = [.25, .15, .08, .08, .08, .08, .08, .08, .16, .08, .20];

    % these four categories will always be used in the algorithm
    indexes = [1, 2, 9, 11];
    
    % get the team name
    u_team_name = teams{u_team - 1100, 2}{1};
    l_team_name = teams{l_team - 1100, 2}{1};
    
    %disp(u_team_name);
    %disp(l_team_name);
    
    index = find(strcmp(u_team_name, adv_season{:, 2}));
    u_stats = adv_season(index, :);
    index = find(strcmp(l_team_name, adv_season{:, 2}));
    l_stats = adv_season(index, :);
    
    % calculate choosing the highest seed
    u_score = 0;
    l_score = 1;
   
    % calculate based on one metric
    %l_score = str2double(u_stats{1, 8}{1});
    %u_score = str2double(l_stats{1, 8}{1});
    
    % calculate using custom metrics
    u_score = custom_algorithm(u_stats, weights, random);
    l_score = custom_algorithm(l_stats, weights, random);
    
end
