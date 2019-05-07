Matlab code for simulating networks of masses connected to each other with springs and dampers.

# NEAT or NeuroEvolution of Augmenting Topologies
- Genetic algorithm used for evolving artificial neural networks
- Contains three key techniques
  1. Tracks genes with an innovation number
  2. Applies speciation to maintain a diverse population
  3. Develops topologies incrementally from simple initial structures

# Key Features
- Direct stiffness solver
  - Fast solutions that take 0.04 secs vs. 1.4 secs using ode23
- Genetic representation
  - Allows for crossover of differing topologies
  - Genes represent connections between nodes
- Hybrid NEAT/NSGA-II optimization algorithm
  - Multi-objective optimization for mass and displacement from NSGA-II
  - Topology crossover using innovation history from NEAT

# Inspiration from Neural Networks
- Observed that NEAT Neural Networks look similar to truss bridge designs
  - Nodes in a network are like joints in a bridge
  - Links in a network are like the bars connecting joints in a bridge
- NEAT can take simple networks and create complex networks
  - Can NEAT take a simple initial bridge structure and create a complex bridge
      that can withstand a force with minimal deflection?

# Mutations
- Each individual gene has a probability to be mutated by each type of mutations
  - So there is a probability that every gene could be mutated in a cycle or none
  - Also a probability that one gene will be mutated by more than one type of
    mutation in a cycle 
Six types of mutations:
- Stiffness
  - Changes the stiffness of a link
- Split Link
- New Node
- Nudge
- Toggle
- New Connection
