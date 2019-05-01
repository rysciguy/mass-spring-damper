function f = pseudoFitness(objectiveArray)
% Returns a single fitness value from two objectives

f = 700*objectiveArray(1) + 0.5*objectiveArray(2);

end