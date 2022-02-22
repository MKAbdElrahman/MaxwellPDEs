@with_kw struct FrequencyDomainMonitor{TQuantity ,GeometryType} <: AbstractMonitor
	geometry::GeometryType
	quantity::TQuantity
	frequency::Float
end
