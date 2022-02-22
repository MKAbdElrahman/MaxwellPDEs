abstract type AbstractExcitation end

λ₀(excitation::AbstractExcitation) = c₀ / frequency(excitation)
ω₀(excitation::AbstractExcitation) = 2π * frequency(excitation)
k₀(excitation::AbstractExcitation) = 2π / λ₀(excitation)


@with_kw struct Harmonic <: AbstractExcitation
    freq
    amp = 1.0
end
frequency(signal::Harmonic) = signal.freq
function (signal::Harmonic)(t)
    @unpack freq, amp = signal
    ω₀ = 2π * freq
    amp * exp(-im * (ω₀ * t))
end
@with_kw struct Gaussian <: AbstractExcitation
    freq
    df
    t0 = 2 * inv(df)
    amp = 1.0
end
frequency(signal::Gaussian) = signal.freq
function (signal::Gaussian)(t)
    @unpack freq, df, t0, amp = signal
    ω₀ = 2π * freq
    σₜ = 1 / (2π * df)
    amp * exp(-0.5((t - t0) * inv(σₜ))^2) * exp(-im * (ω₀ * t))
end
