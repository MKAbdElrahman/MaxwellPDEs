@with_kw struct UniformSource{GeometryType,E <: AbstractExcitation} <: AbstractSource
    geometry::GeometryType
    excitation::E
    polarization::Vec
end
