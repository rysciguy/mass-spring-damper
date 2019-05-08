
# Building NEAT Bridges
Ryan Reedy and Chris Rosemann
## NEAT or NeuroEvolution of Augmenting Topologies
- Genetic algorithm used for evolving artificial neural networks
- Contains three key techniques
  1. Tracks genes with an innovation number
  2. Applies speciation to maintain a diverse population
  3. Develops topologies incrementally from simple initial structures

## Inspiration from Neural Networks
  - Observed that NEAT Neural Networks look similar to truss bridge designs
    - Nodes in a network are like joints in a bridge
    - Links in a network are like the bars connecting joints in a bridge
  - NEAT can take simple networks and create complex networks
    - Can NEAT take a simple initial bridge structure and create a complex bridge
        that can withstand a force with minimal deflection?

        ![NEAT to Truss](/images/Similarities.PNG)

## Key Features
- Direct stiffness solver
- Genetic representation
  - Allows for crossover of differing topologies
  - Genes represent connections between nodes
- Hybrid NEAT/NSGA-II optimization algorithm
  - Multi-objective optimization for mass and displacement from NSGA-II
  - Topology crossover using innovation history from NEAT

## Direct Stiffness

## Crossover

## Mutations
- Each individual gene has a probability to be mutated by each type of mutations
  - So there is a probability that every gene could be mutated in a cycle or none
  - Also a probability that one gene will be mutated by more than one type of
    mutation in a cycle
### Six types of mutations:
- **Stiffness**
  - Changes the stiffness of a link
  - Randomly chooses from an array of set stiffness values
  - Adjusts the mass of the link based on new stiffness

  ![Stiffness](/images/Stiffness.PNG =269x168)

- **Split Link**
  - Adds a node in the center of a randomly chosen gene/link
  - This disables the old gene and creates two new genes/links

  ![Split Link](/images/Split.PNG =269x143)

- **New Node**
  - Creates a new node with two new genes/links, but does not disable the original gene/link
  - This mutation utilizes a "repulsion force" to push the new node away from the original Nodes
  - This creates helps to create a triangle structure connected to the original gene

  ![New Node](/images/New_Node.PNG =257x145)

- **Nudge**
  - Takes a random node and moves it in a random direction
  - Can increase or decrease the mass of the bridge since it changes the size of the links
      attached to the node

  ![Nudge](/images/Nudge.PNG =268x152)

- **Toggle**
  - Disables a randomly chosen gene
  - This mutation is not used here, but is kept in the code for the future
  - Is not useful to delete a link/gene in a bridge, it usually causes a collapse

![Toggle](/images/Toggle.PNG =270x141)

- **New Connection**
  - Adds a new link from two randomly selected nodes that were not previously connected

![New Connection](/images/Connection.PNG =266x153)
