function [genome, chromosome] = initialize_variables(N, M)

%% function f = initialize_variables(N, M, V, min_tange, max_range) 
% This function initializes the chromosomes. Each chromosome has the
% following at this stage
%       * set of decision variables (genome)
%       * objective function values
% 
% where,
% N - Population size
% M - Number of objective functions

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

% K is the total number of array elements. For ease of computation decision
% variables and objective functions are concatenated to form a single
% array. For crossover and mutation only the decision variables are used
% while for selection, only the objective variable are utilized.

%% Initialize each chromosome
stiffness = 1;

g0 = {
Gene_Link(Gene.incrementPoints(), [0,0,0], Gene.incrementPoints(), [5,0,0], stiffness, 'A_static', 'B_static'),...
Gene_Link(2, [5,0,0], Gene.incrementPoints(), [10,0,0], stiffness, 'A_static', 'B_static'),...
Gene_Link(1, [0,0,0], Gene.incrementPoints(), [5,3,0], stiffness),...
Gene_Link(4, [5,3,0], 2, [5,0,0], stiffness),...
Gene_Link(4, [5,3,0], 3, [10,0,0], stiffness)
};

num_genes = size(g0,2);
genome = cell(0, num_genes); %initialize genome

% For each chromosome perform the following (N is the population size)
for i = 1 : N
    mutant = mutate(g0);
    genome = appendMutant(genome, mutant);
%     chromosome(i,1:M) = evaluate_objective(genome, M);
end

chromosome(:,1:M) = testGenomes(genome);