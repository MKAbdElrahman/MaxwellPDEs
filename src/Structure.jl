"""
    Structure{GeometryType}

Defines a physical object with a shape and medium.

# Fields
- `geometry`: Defines the geometry of the structure.
- `medium`: Defines the material of the structure.
"""
@with_kw struct Structure{GeometryType}
    geometry::GeometryType
    medium::Medium
end

medium(s::Structure) = s.medium
geometry(s::Structure) = s.geometry


epsilon(s::Structure, freq = Inf) = epsilon(medium(s), freq)
mu(s::Structure, freq = Inf) = mu(medium(s), freq)

