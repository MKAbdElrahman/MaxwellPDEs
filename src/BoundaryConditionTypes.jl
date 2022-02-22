abstract type AbstractBoundary end

abstract type AbstractBoundaryCondition <: AbstractBoundary end
abstract type AbstractBoundaryLayer <: AbstractBoundary end

include("./BoundaryConditions/PEC.jl")
include("./BoundaryConditions/PMC.jl")
include("./BoundaryConditions/Periodic.jl")
include("./BoundaryConditions/Bloch.jl")
include("./BoundaryConditions/ABC.jl")
include("./BoundaryConditions/PML.jl")
