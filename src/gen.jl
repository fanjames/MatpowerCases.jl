mutable struct Gen
    GEN_BUS::Vector{Int64}  # "bus number"
    PG::Vector{Float64}     # "Pg, real power output (MW)"
    QG::Vector{Float64}     # "Qg, reactive power output (MVAr)"
    QMAX::Vector{Float64}   # "Qmax, maximum reactive power output at Pmin (MVAr)"
    QMIN::Vector{Float64}   # "Qmin, minimum reactive power output at Pmin (MVAr)"
    VG::Vector{Float64}     # "Vg, voltage magnitude setpoint (p.u.)"
    MBASE::Vector{Float64}  # "mBase, total MVA base of this machine, defaults to baseMVA"
    GEN_STATUS::Vector{Bool}    # "status, 1 - machine in service, 0 - machine out of service"
    PMAX::Vector{Float64}   # "Pmax, maximum real power output (MW)"
    PMIN::Vector{Float64}   # "Pmin, minimum real power output (MW)"
    PC1::Vector{Float64}    # "Pc1, lower real power output of PQ capability curve (MW)"
    PC2::Vector{Float64}    # "Pc2, upper real power output of PQ capability curve (MW)"
    QC1MIN::Vector{Float64} # "Qc1min, minimum reactive power output at Pc1 (MVAr)"
    QC1MAX::Vector{Float64} # "Qc1max, maximum reactive power output at Pc1 (MVAr)"
    QC2MIN::Vector{Float64} # "Qc2min, minimum reactive power output at Pc2 (MVAr)"
    QC2MAX::Vector{Float64} # "Qc2max, maximum reactive power output at Pc2 (MVAr)"
    RAMP_AGC::Vector{Float64}   # "ramp rate for load following/AGC (MW/min)"
    RAMP_10::Vector{Float64}    # "ramp rate for 10 minute reserves (MW)"
    RAMP_30::Vector{Float64}    # "ramp rate for 30 minute reserves (MW)"
    RAMP_Q::Vector{Float64}     # "ramp rate for reactive power (2 sec timescale) (MVAr/min)"
    APF::Vector{Float64}    # "area participation factor"
    MU_PMAX::Vector{Float64}    # "Kuhn-Tucker multiplier on upper Pg limit (u/MW)"
    MU_PMIN::Vector{Float64}    # "Kuhn-Tucker multiplier on lower Pg limit (u/MW)"
    MU_QMAX::Vector{Float64}    # "Kuhn-Tucker multiplier on upper Qg limit (u/MVAr)"
    MU_QMIN::Vector{Float64}    # "Kuhn-Tucker multiplier on lower Qg limit (u/MVAr)"
end

"""
Extract gen information from mpc Dict. Return instance of Gen.

IN:

* mpc. Instance of MPC dict (loaded, for instance, by loadcase())

OUT:

* Instance of Gen containing all gen data.
"""
function extract_gen(mpc)
    gen = mpc["gen"]
    nc = size(gen, 2)
    nf = length(fieldnames(Gen))
    blanks = fill([NaN], nf - nc)
    return Gen([gen[:, i] for i in 1:nc]..., blanks...)
end

"""
Shortcut for returning gen info for one of the cases listed by
`casenames()`.
"""
function extract_gen(cname::AbstractString)
    mpc = loadcase(cname; describe=false)
    extract_gen(mpc)
end
