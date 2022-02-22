@with_kw struct PoleResidueDispersionModel
    inf
    activation_tensor
    poles
    residues
    wavelength_range
end

function PoleResidueDispersionModel(nktable::NKTable; activation_tensor = I(3), npoles = 5)
    @unpack wavelength, n, k = nktable
    s = im * wavelength
    Ns = length(s)
    f = reshape(epsilon(nktable), 1, Ns)
    poles = Array{ComplexF64}(-2 * pi * exp10.(range(0, stop = wavelength[end], length = npoles)))
    weight = ones(1 , Ns)
    ϵ_inf, a, c = vectfit3(f, s, poles, weight, asymp = 2, stable = true)
    PoleResidueDispersionModel(inf = ϵ_inf, poles = a, residues = c, activation_tensor = activation_tensor, wavelength_range = nktable.wavelength)
end
function epsilon(model::PoleResidueDispersionModel, wavelength)
    @unpack inf, activation_tensor, poles, residues, wavelength_range = model
    inf + sum([residues[i] / (im * wavelength - poles[i]) for i in 1:length(poles)])
end

function mu(model::PoleResidueDispersionModel, wavelength)
    @unpack inf, activation_tensor, poles, residues, wavelength_range = model
    inf + sum([residues[i] / (im * wavelength - poles[i]) for i in 1:length(poles)])
end

@recipe function plot(model::PoleResidueDispersionModel;
    xlabel = "Wavelength μm", color = [:blue :red], label = ["n" "k"], linewidth = [3, 3])
    xlabel --> xlabel
    color --> color
    n = map(λ -> n_from_epsilon(epsilon(model,λ)),model.wavelength_range)
    k = map(λ -> k_from_epsilon(epsilon(model,λ)),model.wavelength_range)
    model.wavelength_range , [n, k]
end