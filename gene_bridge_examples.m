genome = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1)};
            
        
genomeA = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Split(6, 1);
            Gene_Nudge(7, 4, [0, 5, 0]);
            Gene_Split(8, 2);
            Gene_Nudge(9, 5, [0, 5, 0]);
            Gene_Connect(10, 4, 5, 1);
            Gene_Split(11, 4);
            Gene_Split(12, 7);
            Gene_Nudge(13, 6, [-1.25, -2.5, 0]);
            Gene_Nudge(14, 4, [-1.25, 0, 0]);
            Gene_Nudge(15, 7, [-1.25, 0, 0]);
            Gene_Connect(16, 7, 6, 1);
            Gene_Connect(17, 7, 2, 1);
            Gene_Connect(18, 6, 1, 1);
            Gene_Split(19, 11);
            Gene_Split(20, 5);
            Gene_Nudge(21, 9, [1.25, -2.5, 0]);
            Gene_Nudge(22, 8, [0.625, 0, 0]);
            Gene_Nudge(23, 5, [1.25, 0, 0]);
            Gene_Connect(24, 9, 3, 1);
            Gene_Connect(25, 8, 9, 1);
            Gene_Connect(26, 8, 2, 1);
            Gene_Split(27, 16);
            Gene_Nudge(28, 4, [0, -2.5, 0]);
            Gene_Nudge(29, 5, [0, -2.5, 0]);
            Gene_Nudge(30, 7, [0, -2.5, 0]);
            Gene_Nudge(31, 8, [0, -2.5, 0])
            Gene_Connect(32, 4, 8, 1)};
     
genomeB = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Split(6, 1);
            Gene_Nudge(7, 4, [2.5, 5, 0]);
            Gene_Connect(8, 4, 3, 1);
            Gene_Connect(9, 2, 1, 1);
            Gene_Split(10, 2);
            Gene_Split(11, 3);
            Gene_Split(12, 5);
            Gene_Connect(13, 5, 7, 1);
            Gene_Connect(14, 7, 2, 1);
            Gene_Connect(15, 6, 2, 1);
            Gene_Node(16, [2.5, 0, 0]);
            Gene_Connect(17, 6, 8, 1);
            Gene_Connect(18, 8, 2, 1);
            Gene_Connect(19, 8, 1, 1)};
            
        
genomeC = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Node(6, [5, 5, 0]);
            Gene_Connect(7, 4, 1, 1);
            Gene_Connect(8, 4, 2, 1);
            Gene_Connect(9, 4, 3, 1);
            Gene_Split(10, 3);
            Gene_Split(11, 5);
            Gene_Split(12, 7);
            Gene_Split(13, 9);
            Gene_Connect(14, 5, 2, 1);
            Gene_Connect(15, 6, 2, 1);
            Gene_Connect(16, 7, 2, 1);
            Gene_Connect(17, 8, 2, 1)
            Gene_Nudge(18, 5, [0.5, 1.5 ,0]);
            Gene_Nudge(19, 6, [-0.5, 1.5, 0]);
            Gene_Nudge(20, 7, [0, 1.5, 0]);
            Gene_Nudge(21, 8, [0, 1.5, 0])};
            
        
genomeD = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Split(6, 1);
            Gene_Nudge(7, 4, [0, -5, 0]);
            Gene_Split(8, 2);
            Gene_Nudge(9, 5, [0, -5, 0]);
            Gene_Connect(10, 4, 5, 1);
            Gene_Connect(11, 1, 2, 1);
            Gene_Connect(12, 2, 3, 1)};
        
genomeE = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Split(6, 1);
            Gene_Split(7, 2);
            Gene_Split(8, 3);
            Gene_Split(9, 6);
            Gene_Nudge(10, 7, [-0.42, 1.67, 0]);
            Gene_Nudge(11, 6, [0.42, 1.67, 0]);
            Gene_Split(12, 9);
            Gene_Split(13, 7);
            Gene_Nudge(14, 9, [0.835, -0.835, 0]);
            Gene_Nudge(15, 8, [-0.835, -0.835, 0]);
            Gene_Connect(16, 9, 1, 1);
            Gene_Connect(17, 8, 3, 1);
            Gene_Split(18, 4);
            Gene_Split(19, 5);
            Gene_Split(20, 17);
            Gene_Nudge(21, 10, [-1.25, 3.33, 0]);
            Gene_Nudge(22, 11, [1.25, 3.33, 0]);
            Gene_Nudge(23, 12, [0.625, 5, 0]);
            Gene_Connect(24, 12, 11, 1);
            Gene_Connect(25, 10, 2, 1); %fix
            Gene_Connect(26, 6, 10, 1);
            Gene_Connect(27, 1, 6, 1); %fix
            Gene_Connect(28, 9, 4, 1);
            Gene_Connect(29, 4, 2, 1); %fix
            Gene_Connect(30, 2, 5, 1);%fix
            Gene_Connect(31, 5, 8, 1);
            Gene_Connect(32, 3, 7, 1); %fix
            Gene_Connect(33, 7, 11, 1)};
        
genomeF = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Nudge(6, 2, [2,1,0]);
            Gene_Split(7, 1)
            Gene_Nudge(8, 4, [-1, -1, 0])};
        
genomeG = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Nudge(6, 2, [2,1,0]);
            Gene_Split(7, 1)
            Gene_Nudge(8, 4, [-1, -1, 0])};