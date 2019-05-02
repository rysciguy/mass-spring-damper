function [offspring_props, offspring_genome]  = genetic_operator(parent_properties, parent_genome, M)
offspring_genome = cell(0,0);

%% function f  = genetic_operator(parent_chromosome, M, V, mu, mum, l_limit, u_limit)
% 
% This function is utilized to produce offsprings from parent chromosomes.
% The genetic operators corssover and mutation which are carried out with
% slight modifications from the original design. For more information read
% the document enclosed. 
%
% parent_chromosome - the set of selected chromosomes.
% M - number of objective functions
% V - number of decision varaiables
% mu - distribution index for crossover (read the enlcosed pdf file)
% mum - distribution index for mutation (read the enclosed pdf file)
% l_limit - a vector of lower limit for the corresponding decsion variables
% u_limit - a vector of upper limit for the corresponding decsion variables
%
% The genetic operation is performed only on the decision variables, that
% is the first V elements in the chromosome vector. 

%  Copyright (c) 2009, Aravind Seshadri
%  All rights reserved.
%
%  Redistribution and use in source and binary forms, with or without 
%  modification, are permitted provided that the following conditions are 
%  met:
%
%     * Redistributions of source code must retain the above copyright 
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright 
%       notice, this list of conditions and the following disclaimer in 
%       the documentation and/or other materials provided with the distribution
%      
%  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%  POSSIBILITY OF SUCH DAMAGE.

[N,~] = size(parent_properties);

p = 1;
% Flags used to set if crossover and mutation were actually performed. 
was_crossover = 0;
was_mutation = 0;


for i = 1 : N
    % With 90 % probability perform crossover
    if rand(1) < 0.5
        % Select the first parent
        parent_1 = randi(N);
        % Select the second parent
        parent_2 = randi(N);
        % Make sure both the parents are not the same. 
        while parent_1==parent_2
            parent_2 = randi(N);
        end
        % Get the chromosome information for each randomnly selected
        % parents
        g1 = parent_genome(parent_1, :);
        g2 = parent_genome(parent_2, :);
        f1 = pseudoFitness(parent_properties(parent_1, 1:M));
        f2 = pseudoFitness(parent_properties(parent_2, 1:M));
        
        [child_1, child_2] = crossover(g1, f1, g2, f2);
        
        % Evaluate the objective function for the offsprings and as before
        % concatenate the offspring chromosome with objective value.
        new_children = [child_1; child_2];
        new_fitness = testGenomes(new_children, 'plotting', 0);

        % Set the crossover flag. When crossover is performed two children
        % are generate, while when mutation is performed only only child is
        % generated.
        was_crossover = 1;
        was_mutation = 0;
    % With 10 % probability perform mutation. Mutation is based on
    % polynomial mutation. 
    else
        % Select at random the parent.
        parent_3 = randi(N);
        if parent_3 < 1
            parent_3 = 1;
        end
        % Get the chromosome information for the randomnly selected parent.
        child_3 = parent_genome(parent_3,:);
        % Perform mutation on eact element of the selected parent.
        child_3 = mutate(child_3);
        
        % Evaluate the objective function for the offspring and as before
        % concatenate the offspring chromosome with objective value.    
        new_fitness = testGenomes(child_3, 'plotting', 0);
%         child_3(:,V + 1: M + V) = evaluate_objective(child_3, M, V);
        % Set the mutation flag
        was_mutation = 1;
        was_crossover = 0;
    end
    % Keep proper count and appropriately fill the child variable with all
    % the generated children for the particular generation.
    if was_crossover
        offspring_props(p:p+1,:) = new_fitness;
        offspring_genome = appendGenome(offspring_genome, child_1);
        offspring_genome = appendGenome(offspring_genome, child_2);
%         child(p,:) = child_1;
%         child(p+1,:) = child_2;
        p = p + 2;
    elseif was_mutation
        offspring_props(p,:) = new_fitness;
        offspring_genome = appendGenome(offspring_genome, child_3);
%         child(p,:) = child_3(1,1 : M + V);
        p = p + 1;
    end
end
