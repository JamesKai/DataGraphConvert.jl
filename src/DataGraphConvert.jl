module DataGraphConvert

using DataFrames
import RCall: RObject, @R_str
# using PrecompileTools

# Run when the module is loaded
function __init__()
    # Ensure DataGraph is installed in R's library
    R"library(DataGraph)"
end

# DTable
openDTable(path) = R"openDTable($path)"

function writeDTable(path, df)
    df_in_R = RObject(df)
    R"writeDTable($path, $df_in_R)"
end

addDTable(path, df) = R"addDTable($path, $df)"
syncDTable(path, df) = R"syncDTable($path, $df)"
closeDTable(path) = R"closeDTable($path)"

# DTBin
openDTBin(path) = R"openDTBin($path)"
addDTBin(path, df_name, df) = R"addDTBin($path, $df_name, $df)"
syncDTBin(path) = R"syncDTBin($path)"
closeDTBin(path) = R"closeDTBin($path)"

# export function
export openDTable, writeDTable, addDTable, syncDTable, closeDTable, openDTBin, addDTBin, closeDTBin, syncDTBin

end
