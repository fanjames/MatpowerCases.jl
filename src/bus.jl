struct Bus
    BUS_I::Vector{Int64}    # "bus number"
    BUS_TYPE::Vector{Int64} # "bus type"
    PD::Vector{Float64}     # "real power demand [MW]"
    QD::Vector{Float64}     # "reactive power demand [MVar]"
    GS::Vector{Float64}     # "shunt conductance [MW at V = 1 pu]"
    BS::Vector{Float64}     # "shunt susceptance [MVar at V = 1 pu]"
    BUS_AREA::Vector{Int64} # "area number"
    VM::Vector{Float64}     # "voltage magnitude [pu]"
    VA::Vector{Float64}     # "voltage angle [deg]"
    BASE_KV::Vector{Float64}    # "base voltage [kV]"
    ZONE::Vector{Int64}     # "loss zone"
    VMAX::Vector{Float64}   # "maximum voltage magnitude [pu]"
    VMIN::Vector{Float64}   # "minimum voltage magnitude [pu]"
    LAM_P::Vector{Float64}  # "Lagrange multiplier on real power mismatch (u/MW)"
    LAM_Q::Vector{Float64}  # "Lagrange multiplier on reactive power mismatch (u/MVAr)"
    MU_VMAX::Vector{Float64}    # "Kuhn-Tucker multiplier on upper voltage limit (u/p.u.)"
    MU_VMIN::Vector{Float64}    # "Kuhn-Tucker multiplier on lower voltage limit (u/p.u.)"
end

"""
Extract bus information from mpc Dict. Return instance of Bus.

IN:

* mpc. Instance of MPC dict (loaded, for instance, by loadcase())

OUT:

* Instance of Bus containing all bus data.
"""
function extract_bus(mpc)
    bus = mpc["bus"]
    nc = size(bus, 2)
    nf = length(fieldnames(Bus))
    blanks = fill([NaN], nf - nc)
    return Bus([bus[:, i] for i in 1:size(bus, 2)]..., blanks...)
end

"""
Shortcut for returning bus info for one of the cases listed by
`casenames()`.
"""
function extract_bus(cname::AbstractString)
    mpc = loadcase(cname; describe=false)
    extract_bus(mpc)
end
