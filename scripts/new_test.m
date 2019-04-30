clear all;

stiffness = 1;

genome = {
Gene_Link(1, [0,0,0], 2, [5,0,0], stiffness, 'static');
Gene_Link(2, [5,0,0], 3, [10,0,0], stiffness, 'static');
Gene_Link(1, [0,0,0], 4, [5,3,0], stiffness);
Gene_Link(4, [5,3,0], 2, [5,0,0], stiffness);
Gene_Link(4, [5,3,0], 3, [10,0,0], stiffness);
};

sequences = {
1:2;
1:5;
};

testSequences(sequences, genome);