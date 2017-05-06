function [ accuracy ] = run_tournament( seeds, teams, adv_season, weights, real_results, random )
%RUN_TOURNAMENT A simulation of an NCAA bracket
%   Given a table seeds, a table of stats about that team, and an actual
%   result of the tournament real_results, simulates the tournament using
%   our custom algorithm and returns how accurate the bracket turned out

    % Creating our simulation of the bracket
    current_round = 1;
    conf_size = 16;
    round_matches = conf_size * 2;
    total_matches = round_matches;
    total_correct = 0;
    
    % tournament simulation
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
                [u_score, l_score] = match(u_team, l_team, teams, adv_season, weights, random);

                % higher seeded team won
                if (u_score <= l_score)
                    losing_teams = [losing_teams l_index];
                else
                    losing_teams = [losing_teams u_index];
                end
            end
        end

        % calculate how accurate this round was
        % and update variables for next round
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

        % display the final participants
%         if (size(seeds, 1) == 4)
%             disp('FINAL FOUR');
%             %disp('------------------------------');        
%             for k = 1:size(seeds, 1)
%                 disp(teams{seeds{k, 3} - 1100, 2}{1});
%             end
%             disp('------------------------------');
%         end
    end
    
    % print out accuracy
    total_matches = total_matches - .5;
    accuracy = total_correct / total_matches;

end

