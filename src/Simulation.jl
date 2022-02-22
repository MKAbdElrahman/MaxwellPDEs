abstract type AbstractSimulation end
"""
    Simulation

Contains all data needed by mesher and em-solver to run a simulation.

The simulation object shouldn't include any information about space or time discretization
or any information related to the solver or numerical algorithms used.
Its only purpose is to hold all the data needed by the solver and mesher to run a simulation.

The workflow is as follows:
- Construct all simulation componenets
- Call the mesh function to get a mesh object
- Discretize the simulation data
- Initalize fields for storing the solution
- Call the solve function to get the solution

"""
@with_kw struct Simulation <: AbstractSimulation 
    background
    structures
    sources
    boundaryconditions
    # symmetries = NoSymmetry()
    # monitors = []
end
