function [genome, chromosome] = nsga_bridge(pop, gen)
%  Modified by Ryan Reedy (2019)

% chromosome
    % chromosome(:, 1:M)            fitness
    % chromosome(:, M+1)            rank
    % chromosome(:, end)            crowding

clear Gene; %resets persistant class variables

M = 2; %number of objectives

%% Initialize the population
% Population is initialized with random values which are within the
% specified range. Each chromosome consists of the decision variables. Also
% the value of the objective functions, rank and crowding distance
% information is also added to the chromosome vector but only the elements
% of the vector which has the decision variables are operated upon to
% perform the genetic operations like corssover and mutation.
[genome, chromosome] = initialize_variables(pop, M);


end