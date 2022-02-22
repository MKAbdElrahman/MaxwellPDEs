abstract type AbstractSource end


include("./Sources/ExcitationTypes.jl")
include("./Sources/UniformSource.jl")
include("./Sources/PlaneWaveSource.jl")
include("./Sources/ModeSource.jl")
include("./Sources/GaussianBeamSource.jl")


#=
point_source = UniformSource(geometry = Point(0,0), time_dependance = Harmonic(f₀ = 1/1.55),polarization = Vec3(1,0,0))
mode_source = ModeSource(geometry = Plane(Point(0,0,0),Vec3(1,0,0)), time_dependance = Gaussian(f₀ = 1,Δf = .1),propagation_direction = Vec3(1,0,0),mode_spec = ModeSpec(target_neff = 1.5))
=#