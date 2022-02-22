@with_kw struct TimeDomainMonitior{TQuantity,GeometryType} <: AbstractMonitor
	geometry::GeometryType
	quantity::TQuantity
	start_time::Float = 0.0 #  The time to start recording
	stop_time::Float = Inf # The time to stop recording
end	
