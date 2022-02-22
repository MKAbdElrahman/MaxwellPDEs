
@with_kw struct Medium{Tϵ,Tμ}
    epsilon_model::Tϵ = 1.0 * I(3)
    mu_model::Tμ = 1.0 * I(3)
end

include("./Materials/Vecfit.jl")
include("./Materials/NKTable.jl")
include("./Materials/SusceptibilityTypes.jl")
include("./Materials/DispersionModels.jl")
include("./Materials/PoleResidueDispersionModel.jl")
include("./Materials/MaterialLibrary.jl")



epsilon(medium::Medium,freq) = epsilon(medium.epsilon_model,freq)
mu(medium::Medium,freq) = mu(medium.epsilon_model,freq)

epsilon(medium::Medium{<: AbstractMatrix,<:Any},freq) = medium.epsilon_model
mu(medium::Medium{<: Any,<: AbstractMatrix},freq) = medium.mu_model
epsilon(medium::Medium{<: Number,<:Any},freq) = medium.epsilon_model * I(3)
mu(medium::Medium{<: Any,<: Number},freq) = medium.mu_model * I(3)


