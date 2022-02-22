@with_kw struct ModeSpec{Tneff<:Number}
    target_neff::Tneff
end

@with_kw struct ModeSource{GeometryType,E <: AbstractExcitation} <: AbstractSource
    geometry::GeometryType
    excitation::E
    propagation_direction::Vec
    mode_spec::ModeSpec
    mode_index::Int = 1
end
