abstract type DGraph end

function DGraph(path::AbstractString)
    ext = split(path, ".") |> last
    if ext == "dtable"
        return DTable(path)
    elseif ext == "dtbin"
        return DTBin(path)
    else
        @show "Invalid DataGraph file type"
    end
end

mutable struct DTable <: DGraph
    path::AbstractString
    file_name::AbstractString
    is_open::Bool
    function DTable(path::AbstractString)
        ext = split(path, ".") |> last
        @assert ext == "dtable" 
        file_name = split(path, ".")[1:end-1] |> join
        return new(path, file_name, false)
    end
end

mutable struct DTBin <: DGraph
    path::AbstractString
    file_name::AbstractString
    is_open::Bool
    function DTBin(path::AbstractString)
        ext = split(path, ".") |> last
        @assert ext == "dtbin" 
        file_name = split(path, ".")[1:end-1] |> join
        return new(path, file_name, false)
    end
end

is_open(dg::DGraph) = dg.is_open
file_name(dg::DGraph) = dg.file_name

function _toggle_status!(dg::DGraph)
    dg.is_open = !is_open(dg)
    return dg
end

function Base.open(dg::DGraph) 
    fn = file_name(dg)
    if dg isa DTable
        openDTable(fn)
    elseif dg isa DTBin
        openDTBin(fn)
    end
    dg = _toggle_status!(dg)
    return dg
end

function Base.open(func::Function, dg::DGraph)
    dg isa DTable ? (openDTable(dg.path)) : (openDTBin(dg.path))
    dg = _toggle_status!(dg)
    out = func(dg)
    close(dg)
    return out
end

function Base.close(dg::DGraph)
    dg isa DTable ? (closeDTable(dg.path)) : (closeDTBin(dg.path))
    dg = _toggle_status!(dg)
    return dg
end

function add_df!(dg::DGraph, df_name::String, df::DataFrame)
    @assert is_open(dg)
    addDTBin(dg.path, df_name, df)
end

function add_df!(dg::DGraph, df::DataFrame)
    @assert is_open(dg)
    addDTable(dg.path, df)
end

# Macro to add a DataFrame to a DGraph and sync the changes 
# equilvalent to add_DTable_df!(dt, df) or add_DTBin_df!(dtb, df_name, df) followed by syncDTable(dt) or syncDTBin(dtb)
# e.g., sync_dgraph add_DTable_df!(dt, df) or sync_dgraph add_DTBin_df!(dtb, df_name, df)
macro sync_dgraph(expr)
    quote
        $(esc(expr)) # escape the expression to evaluate in the calling scope and not the global scope
        local dg = $(esc(expr.args[2])) # avoid leaking the dg variable to calling/global scope
        dg isa DTable ? (syncDTable(dg.path)) : (syncDTBin(dg.path))
    end
end