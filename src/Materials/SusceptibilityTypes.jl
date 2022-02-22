
"""
    AbstractSusceptibility

- A susceptibility is used to build dispersion models.
- A dispersion model is a collection of susceptibilities of the same type or different types.
- The supported susceptibilities  `LorentzianSusceptibility` `DrudeSusceptibility` 
  `PoleResidue` 
- Each susceptibility returns a symmetric 3*3 matrix.
- The sigma field is used when the susceptibility is isotropic
- The sigma_diag and sigma_offdiag vectors are used when the susceptibility is anisotropic and can
be used to turn on/off the anisotropic terms. 
"""
abstract type AbstractSusceptibility end

@with_kw struct LorentzianSusceptibility <: AbstractSusceptibility
    frequency
    gamma
    sigma = 1.0
    sigma_diag = sigma * [1, 1, 1]
    sigma_offdiag = [0, 0, 0]
end

@with_kw struct DrudeSusceptibility <: AbstractSusceptibility
    frequency
    gamma
    sigma = 1.0
    sigma_diag = sigma * [1, 1, 1]
    sigma_offdiag = [0, 0, 0]
end


@with_kw struct PoleResidueSusceptibility <: AbstractSusceptibility
    a
    c
    sigma = 1.0
    sigma_diag = sigma * [1, 1, 1]
    sigma_offdiag = [0, 0, 0]
end

function eval_susceptibility(s::LorentzianSusceptibility, f)
    @unpack frequency, gamma, sigma, sigma_diag, sigma_offdiag = s
    if iszero(gamma)
        κ = frequency^2 / (frequency^2 - f^2)
    else
        κ = frequency^2 / (frequency^2 - f^2 - im * gamma * f)
    end
    [
        sigma_diag[1] sigma_offdiag[1] sigma_offdiag[2]
        sigma_offdiag[1] sigma_diag[2] sigma_offdiag[3]
        sigma_offdiag[2] sigma_offdiag[3] sigma_diag[3]
    ] * κ

end



function eval_susceptibility(s::DrudeSusceptibility, f)
    @unpack frequency, gamma, sigma, sigma_diag, sigma_offdiag = s
    if iszero(gamma)
        κ = -frequency^2 / (f * (f + im * gamma))
    else
        κ = -frequency^2 / (f * (f))
    end
    [
        sigma_diag[1] sigma_offdiag[1] sigma_offdiag[2]
        sigma_offdiag[1] sigma_diag[2] sigma_offdiag[3]
        sigma_offdiag[2] sigma_offdiag[3] sigma_diag[3]
    ] * κ
end



function eval_susceptibility(s::PoleResidueSusceptibility, f)
    @unpack a, c, sigma, sigma_diag, sigma_offdiag = s
    ω = 2π * f
    κ = c /(im *  ω - a)
    [
        sigma_diag[1] sigma_offdiag[1] sigma_offdiag[2]
        sigma_offdiag[1] sigma_diag[2] sigma_offdiag[3]
        sigma_offdiag[2] sigma_offdiag[3] sigma_diag[3]
    ] * κ
end
