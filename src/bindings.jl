# DTable
openDTable(path) = R"openDTable($path)"

function writeDTable(path, df)
    df_in_R = RObject(df)
    R"writeDTable($path, $df_in_R)"
end

addDTable(path, df) = R"addDTable($path, $df)"
syncDTable(path) = R"syncDTable($path)"
closeDTable(path) = R"closeDTable($path)"

# DTBin
openDTBin(path) = R"openDTBin($path)"
addDTBin(path, df_name, df) = R"addDTBin($path, $df_name, $df)"
syncDTBin(path) = R"syncDTBin($path)"
closeDTBin(path) = R"closeDTBin($path)"
