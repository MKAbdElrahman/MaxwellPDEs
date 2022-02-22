using MaxwellPDEs
using Documenter

DocMeta.setdocmeta!(MaxwellPDEs, :DocTestSetup, :(using MaxwellPDEs); recursive=true)

makedocs(;
    modules=[MaxwellPDEs],
    authors="Mohamed Kamal AbdElrahman",
    repo="https://github.com/MKAbdElrahman/MaxwellPDEs.jl/blob/{commit}{path}#{line}",
    sitename="MaxwellPDEs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MKAbdElrahman.github.io/MaxwellPDEs.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MKAbdElrahman/MaxwellPDEs.jl",
    devbranch="main",
)
