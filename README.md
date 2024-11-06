# DataGraphConvert
## Introduction
Wrapper for the DataGraph R package to convert the output of julia DataFrames to DataGraph file formats,\
which can be read on-the-fly by DataGraph.

## Requirements
1. Make sure you have R installed on your system, and can be found by the `julia` executable.
2. Install the `DataGraph` R package. You can do this by running the following command in R:
```R
install.packages("DataGraph")
```
**Note**: If you have installed R on your system, but still see error regarding not finding R when you load the package with \
`using DataGraphConvert`, you may need to set the path to R in julia. You can check the path of the R executable by running the following command in R:
```R
R.home()
```
Then, you can set the path to R in julia by running the following command:
```julia
ENV["R_HOME"] = "path/to/R"
```
where `path/to/R` is the path to the R executable.

## Installation
You can install the package by running the following command in julia:
```julia
using Pkg
Pkg.add("DataGraphConvert")
```

## Tutorials
All of the tutorials can be found in the R DataGraph package documentation.\
This can be found from the following website: [DataGraph Documentation](https://www.visualdatatools.com/DataGraph/Documentation/)

[![Build Status](https://github.com/jameskai/DataGraphConvert.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jameskai/DataGraphConvert.jl/actions/workflows/CI.yml?query=branch%3Amain)
