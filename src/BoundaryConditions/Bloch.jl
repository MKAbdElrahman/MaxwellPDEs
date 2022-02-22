@with_kw struct BlochBoundaryCondition <: AbstractBoundaryCondition
    k⃗::Vec
end 

function BlochBoundaryCondition(planewave_source::PlaneWaveSource)
    # I think we need to include the refractive index of the surrounding medium
    BlochBoundaryCondition(k⃗₀(planewave_source))
end
