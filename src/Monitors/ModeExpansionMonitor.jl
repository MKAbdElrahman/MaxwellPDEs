@with_kw struct ModeExpansionMonitor{GeometryType} <: AbstractMonitor
	geometry::GeometryType
	frequency::Float
	mode_spec::ModeSpec
end