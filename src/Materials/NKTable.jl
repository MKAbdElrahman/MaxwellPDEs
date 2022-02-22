@with_kw struct NKTable
    wavelength::Vector{Float64}
    n::Vector{Float64}
    k::Vector{Float64}
    wavelength_unit::Float64 = 1 * 10^-6
end

epsilon_real(model::NKTable) = model.n .^ 2 .- model.k .^ 2
epsilon_imag(model::NKTable) = 2 * model.n .* model.k

epsilon(model::NKTable) = epsilon_real(model) + im * epsilon_imag(model)

wavelength_range(model::NKTable) = (first(model.wavelength),
    last(model.wavelength))



@recipe function plot(model::NKTable;
    xlabel = "Wavelength μm", color = [:blue :red], label = ["n" "k"], linewidth = [3, 3])
    xlabel --> xlabel
    color --> color
    model.wavelength, [model.n, model.k]
end

n_from_epsilon(eps) = real(sqrt(eps))
k_from_epsilon(eps) = imag(sqrt(eps))
epsilon_from_nk(n, k) = n^2 - k^2 + 2 * im * n * k


function load_nk(filepath::String)
    data = readdlm(filepath)
    return NKTable(wavelength = data[:,1],n = data[:,2], k = data[:,3])
end
