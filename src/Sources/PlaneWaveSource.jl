@with_kw struct PlaneWaveSource{GeometryType,E <: AbstractExcitation} <: AbstractSource
    geometry::GeometryType
    excitation::E
    polarization::Vec
    propagation_direction::Vec
end

excitation(planewave_source::PlaneWaveSource) = planewave_source.excitation
propagation_direction(planewave_source::PlaneWaveSource) = planewave_source.propagation_direction

k⃗₀(planewave_source::PlaneWaveSource) =  k₀(excitation(planewave_source))  .* propagation_direction(planewave_source)