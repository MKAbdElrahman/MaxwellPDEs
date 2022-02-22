module MaxwellPDEs


export Medium , epsilon , mu , LorentzianSusceptibility, DrudeSusceptibility, PoleResidueSusceptibility
export DispersionModel , NKTable , PoleResidueDispersionModel , load_nk
# define sim objects using the Structure type
export Structure
# Source Types
export PlaneWaveSource, ModeSource, UniformSource , GaussianBeamSource
# Excitation Types
export Harmonic, Gaussian
# Boundary Conditions
export Bloch,Periodic,PEC, PMC, PML, PMLStable , Absorber
# Symmetry Conditions
export Even, Odd
# Contains all data need to define a simulation
export Simulation


export EField,HField,Ex,Ey,Ez,Hx,Hy,Hz

using Parameters, LinearAlgebra , RecipesBase , DelimitedFiles
using Reexport
@reexport using Meshes



include("UtilTypes.jl")
include("Medium.jl")
include("Structure.jl")
include("SourceTypes.jl")
include("MonitorTypes.jl")
include("BoundaryConditionTypes.jl")
include("Symmetry.jl")
include("Simulation.jl")


end
