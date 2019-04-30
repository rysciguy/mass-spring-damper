% Script that plots and evaluates the fitness of a sample of manually
% generated Bridge structures

clear all %necessary to get rid of persistant variables in Gene class

%% Build bridge from genome
% genome0 = {Gene_Node([0, 0, 0]);
%             Gene_Node([5, 0, 0]);
%             Gene_Node([10, 0, 0]);
%             Gene_Connect(1, 2, 1);
%             Gene_Connect(2, 3, 1);
%             Gene_Nudge(2, [2,1,0]);
%             Gene_Split(1)
%             Gene_Nudge(4, [-1, -1, 0])};

        
genome = {Gene_Node([0, 0, 0]);
    Gene_Node([5, 0, 0]);
    Gene_Node([10, 0, 0]);
    Gene_Connect(1, 2, 1);
    Gene_Connect(2, 3, 1);
    Gene_Split(1);
    Gene_Nudge(4, [0, 5, 0]);
    Gene_Split(2);
    Gene_Nudge(5, [0, 5, 0]);
    Gene_Connect(4, 5, 1);
    Gene_Split(4);
    Gene_Split(7);
    Gene_Nudge(6, [-1.25, -2.5, 0]);
    Gene_Nudge(4, [-1.25, 0, 0]);
    Gene_Nudge(7, [-1.25, 0, 0]);
    Gene_Connect(7, 6, 1);
    Gene_Connect(7, 2, 1);
    Gene_Connect(6, 1, 1);
    Gene_Split(11);
    Gene_Split(5);
    Gene_Nudge(9, [1.25, -2.5, 0]);
    Gene_Nudge(8, [0.625, 0, 0]);
    Gene_Nudge(5, [1.25, 0, 0]);
    Gene_Connect(9, 3, 1);
    Gene_Connect(8, 9, 1);
    Gene_Connect(8, 2, 1);
    Gene_Split(16);
    Gene_Nudge(4, [0, -2.5, 0]);
    Gene_Nudge(5, [0, -2.5, 0]);
    Gene_Nudge(7, [0, -2.5, 0]);
    Gene_Nudge(8, [0, -2.5, 0])
    Gene_Connect(4, 8, 1)};


        
sequences = {1:5;
             1:10;
             1:15;
             1:20;
             1:29;
             1:32};
p1 = [1:5,7:10,15:32];
p2 = [1:8,13:32];
f1 = 1;
f2 = 1;
[c1, c2] = crossover(p1, f1, p2, f2);
% sequences = {p1;p2;c1;c2};
% 
% sequences = {1:3;
%              1:8};

testSequences(sequences, genome);