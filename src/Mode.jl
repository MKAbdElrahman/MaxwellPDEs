@with_kw struct ModeSpec
	num_modes::Int = 1
	target_neff::Float
	symmetries::Tuple{Symmetry,Symmetry} = (NoSymmetry,NoSymmetry)
end
