Matlab code for simulating networks of masses connected to each other with springs and dampers. 

# Key Features
- Direct stiffness solver
- Genetic representation
  - Allows for crossover of differing topologies
  - Genes represent connections between nodes
- Hybrid NEAT/NSGA-II optimization algorithm
  - Multi-objective optimization for mass and displacement from NSGA-II
  - Topology crossover using innovation history from NEAT
