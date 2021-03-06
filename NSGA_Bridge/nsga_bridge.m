function [properties, genome] = nsga_bridge(pop, gen)
%  Modified by Ryan Reedy (2019)

% chromosome
    % properties(:, 1:M)            fitness
    % properties(:, M+1)            rank
    % properties(:, end)            crowding

close all;
clear Gene; %resets persistant class variables

M = 2; %number of objectives

%% Initialize the population
% Population is initialized with random values which are within the
% specified range. Each properties consists of the decision variables. Also
% the value of the objective functions, rank and crowding distance
% information is also added to the properties vector but only the elements
% of the vector which has the decision variables are operated upon to
% perform the genetic operations like corssover and mutation.
[properties, genome] = initialize_variables(pop, M);

%% Sort the initialized population
% Sort the population using non-domination-sort. This returns two columns
% for each individual which are the rank and the crowding distance
% corresponding to their position in the front they belong. At this stage
% the rank and the crowding distance for each properties is added to the
% properties vector for easy of computation.
[properties, genome] = non_domination_sort_mod(properties, genome, M);

%% Start the evolution process
% The following are performed in each generation
% * Select the parents which are fit for reproduction
% * Perfrom crossover and Mutation operator on the selected parents
% * Perform Selection from the parents and the offsprings
% * Replace the unfit individuals with the fit individuals to maintain a
%   constant population size.

for i = 1 : gen
    % Select the parents
    % Parents are selected for reproduction to generate offspring. The
    % original NSGA-II uses a binary tournament selection based on the
    % crowded-comparision operator. The arguments are 
    % pool - size of the mating pool. It is common to have this to be half the
    %        population size.
    % tour - Tournament size. Original NSGA-II uses a binary tournament
    %        selection, but to see the effect of tournament size this is kept
    %        arbitary, to be choosen by the user.
    pool = round(pop/2);
    tour = 2;
    % Selection process
    % A binary tournament selection is employed in NSGA-II. In a binary
    % tournament selection process two individuals are selected at random
    % and their fitness is compared. The individual with better fitness is
    % selcted as a parent. Tournament selection is carried out until the
    % pool size is filled. Basically a pool size is the number of parents
    % to be selected. The input arguments to the function
    % tournament_selection are properties, pool, tour. The function uses
    % only the information from last two elements in the properties vector.
    % The last element has the crowding distance information while the
    % penultimate element has the rank information. Selection is based on
    % rank and if individuals with same rank are encountered, crowding
    % distance is compared. A lower rank and higher crowding distance is
    % the selection criteria.
    [parent_properties, parent_genome] = tournament_selection(properties, genome, pool, tour);

    % Perfrom crossover and Mutation operator
    % The original NSGA-II algorithm uses Simulated Binary Crossover (SBX) and
    % Polynomial  mutation. Crossover probability pc = 0.9 and mutation
    % probability is pm = 1/n, where n is the number of decision variables.
    % Both real-coded GA and binary-coded GA are implemented in the original
    % algorithm, while in this program only the real-coded GA is considered.
    % The distribution indeices for crossover and mutation operators as mu = 20
    % and mum = 20 respectively.
    [offspring_properties, offspring_genome] = ...
        genetic_operator(parent_properties, parent_genome, M);

    % Intermediate population
    % Intermediate population is the combined population of parents and
    % offsprings of the current generation. The population size is two
    % times the initial population.
    
    [main_pop,columns] = size(properties);
    [offspring_pop,~] = size(offspring_properties);
    intermediate_pop = main_pop + offspring_pop;

    % intermediate_properties is a concatenation of current population and
    % the offspring population.
    intermediate_properties = zeros(intermediate_pop, columns);
    intermediate_properties(1:main_pop,:) = properties;
    intermediate_properties(main_pop + 1 : intermediate_pop, 1:M) = ...
        offspring_properties;
    intermediate_genome = appendGenome(genome, offspring_genome);

    % Non-domination-sort of intermediate population
    % The intermediate population is sorted again based on non-domination sort
    % before the replacement operator is performed on the intermediate
    % population.
    [intermediate_properties, intermediate_genome] = ...
        non_domination_sort_mod(intermediate_properties, intermediate_genome, M);
    % Perform Selection
    % Once the intermediate population is sorted only the best solution is
    % selected based on it rank and crowding distance. Each front is filled in
    % ascending order until the addition of population size is reached. The
    % last front is included in the population based on the individuals with
    % least crowding distance
    [properties, genome] = replace_chromosome(intermediate_properties, intermediate_genome, M, pop);
    if ~mod(i,100)
        clc
        fprintf('%d generations completed\n',i);
    end
end

testGenomes(genome, 'plotting', 0);
plotPopulation(properties, genome, 2);
% save('results.mat','properties','genome');

end