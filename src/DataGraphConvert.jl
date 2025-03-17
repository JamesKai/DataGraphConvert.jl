module DataGraphConvert

using DataFrames
import Base
import RCall: RObject, @R_str
# using PrecompileTools

# Run when the module is loaded
function __init__()
    # Ensure DataGraph is installed in R's library
    R"library(DataGraph)"
end

# export binding function
export openDTable, writeDTable, addDTable, syncDTable, closeDTable, openDTBin, addDTBin, closeDTBin, syncDTBin
# export data wrappers
export DGraph, DTable, DTBin, add_df!, is_open, open, close, @sync_dgraph

include("bindings.jl")
include("data_wrappers.jl")

end
