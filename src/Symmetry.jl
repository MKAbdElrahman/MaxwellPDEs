abstract type AbstractSymmetry end
struct EvenSymmetry <: AbstractSymmetry end
struct OddSymmetry <: AbstractSymmetry end
struct NoSymmetry <: AbstractSymmetry end
const Even = EvenSymmetry()
const Odd = OddSymmetry()
