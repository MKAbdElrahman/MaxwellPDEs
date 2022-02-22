struct FreqRange{T}
    range::T
end
function FreqRange(; min, max)
    return FreqRange([min, max])
end
Base.first(r::FreqRange) = first(r.range)
Base.last(r::FreqRange) = last(r.range)


@with_kw struct DispersionModel{S<:AbstractSusceptibility}
    inf = 1.0
    inf_diag = inf * [1, 1, 1]
    inf_offdiag = [0, 0, 0]
    susceptibilities::Vector{S}
    valid_freq_range::FreqRange
end

function eval_dispersion_model(m::DispersionModel, f)
    @unpack inf, inf_diag, inf_offdiag, susceptibilities, valid_freq_range = m
    f_min = first(valid_freq_range)
    f_max = last(valid_freq_range)
    if !(f_min ≤ f ≤ f_max)
        throw("frequency outside the model valid range $(f_min):$(f_max)")
    end
    val =
        [
            inf_diag[1] inf_offdiag[1] inf_offdiag[2]
            inf_offdiag[1] inf_diag[2] inf_offdiag[3]
            inf_offdiag[2] inf_offdiag[3] inf_diag[3]
        ]
    for sus in susceptibilities
        val += eval_susceptibility(sus, f)
    end
    return val
end



epsilon(model::DispersionModel, freq) = eval_dispersion_model(model, freq)
mu(model::DispersionModel, freq) = eval_dispersion_model(model, freq)




@recipe function plot(model::DispersionModel;
    comp = 1,
    transform_epsilon = real,
    transform_freq = inv,
    nfreq = 100,
    xlabel = "λ[μm]",
    ylabel = "Re[ϵᵣ]",
    label = "ϵ_11"
)
    xlabel --> xlabel
    ylabel --> ylabel
    label --> label

    freq_range = model.valid_freq_range.range

    fmin = first(freq_range)
    fmax = last(freq_range)

    freq_points = LinRange(fmin, fmax, nfreq)

    ϵ_freqs = map(f -> eval_dispersion_model(model, f)[:], freq_points)
    m = reduce(hcat, ϵ_freqs)'
    transform_freq.(freq_points), transform_epsilon.(m[:, Int(comp)])
end

