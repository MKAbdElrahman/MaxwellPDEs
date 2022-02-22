"""
    AbsorberParameters

This struct is used to store the sigma parameters of the PML.

# Examples

```julia
absorber_params = AbsorberParameters(sigma_order=3, sigma_min=0.0, sigma_max=1.5)
```
# Fields
- `sigma_order`: The order of the sigma function.
- `sigma_min`: The minimum value of the sigma function.
- `sigma_max`: The maximum value of the sigma function.
"""
@with_kw struct AbsorberParameters
    sigma_order::Int = 3
    sigma_min::Float64 = 0.0
    sigma_max::Float64 = 1.5
end
DefaultAbsorberParameters = AbsorberParameters(sigma_order = 3, sigma_min = 0.0, sigma_max = 6.4)
"""
    Absorber

Specifies an adiabatic absorber along a single dimension.
This absorber is well-suited for dispersive materials 
intersecting with absorbing edges of the simulation at the expense of more layers.

# Examples

```julia
pml = Absorber(num_layers=40)
```
"""
@with_kw struct Absorber  <: AbstractBoundaryLayer
    num_layers::Int = 40
    parameters::AbsorberParameters = DefaultAbsorberParameters
end
"""
    PMLParameters

This struct is used to store the kappa and alpha parameters of the PML.

# Examples
```julia
pmal_params = PMLParameters(sigma_order=3, sigma_min=0.0, sigma_max=1.5, kappa_min=0.0)
```
# Fields
- `kappa_order`: The order of the kappa function.
- `kappa_min`: The minimum value of the kappa function.
- `kappa_max`: The maximum value of the kappa function.
- `alpha_order`: The order of the alpha function.
- `alpha_min`: The minimum value of the alpha function.
- `alpha_max`: The maximum value of the alpha function.
- `absorber_params`: The parameters of the PML absorber.
"""
@with_kw struct PMLParameters
    kappa_order::Int = 3
    kappa_min::Float64 = 0.0
    kappa_max::Float64 = 1.5
    alpha_order::Int = 3
    alpha_min::Float64 = 0.0
    alpha_max::Float64 = 1.5
    absorber_params = DefaultAbsorberParameters
end

DefaultPMLParameters = PMLParameters(
    kappa_order = 3,
    kappa_min = 1.0,
    kappa_max = 3.0,
    alpha_order = 1,
    alpha_min = 0.0,
    alpha_max = 0.0,
    absorber_params = AbsorberParameters(sigma_order = 3, sigma_min = 0.0, sigma_max = 1.5)
)

DefaultStablePMLParameters = PMLParameters(
    kappa_order = 3,
    kappa_min = 1.0,
    kappa_max = 5.0,
    alpha_order = 1,
    alpha_min = 0.0,
    alpha_max = 0.9,
    absorber_params = AbsorberParameters(sigma_order = 3, sigma_min = 0.0, sigma_max = 1.0)
)
"""
    PML

Specifies a standard PML along a single dimension.
# Fields
- `num_layers`: The number of PML layers
- `pml_params`: Parameters of the complex frequency-shifted absorption poles
- `absorber_params`: Parameters to fine tune the absorber profile and properties

# Examples
```julia

pml = PML(num_layers=10)

```  
"""
@with_kw struct PML <: AbstractBoundaryLayer
    num_layers::Int = 12
    pml_params::PMLParameters = DefaultPMLParameters
end

"""
    StablePML

Specifies a 'stable' PML along a single dimension.
This PML deals handles possbly divergent simulations better, but at the expense of more layers.

# Example
```julia
 pml = StablePML(num_layers=40)
```
"""
@with_kw struct StablePML <: AbstractBoundaryLayer
    num_layers::Int = 40
    pml_params::PMLParameters = DefaultStablePMLParameters
end