# CSE151MachineLearningLibrary

## Dependencies:
This package depends on unregistered packages:
```julia
  #Unit Test Framework
  Pkg.clone("https://github.com/ajermaky/RunTests.jl")
```

## Install
```julia
Pkg.clone("https://bitbucket.org/arajermakyan/cse151machinelearning.jl")
Pkg.resolve()
```

##Use:

To use this module:
```julia
  using CSE151MachineLearningLibrary
```
##Different Branches
Previous Branches:
Week1&2 Branch: week1_and_2_refactor
Week 3 Branch: week3
Week 4 Branch: week_4

To see previous branches, simply do
```git
  git fetch <branch_name>
  git checkout <branch_name>

```

##Test:

To Run Unit Tests:
```julia
  Pkg.test("CSE151MachineLearningLibrary")
```

To run custom test that regenerates resource files:
```julia
  cd("~/.julia/v0.4/CSE151MachineLearningLibrary")
  include("test/high_level_tests/Statistics.jl")
  include("test/high_level_tests/KNeighbors.jl")
  include("test/high_level_tests/LinearRegression.jl")
  include("test/high_level_tests/KMeans.jl")
```
##Unintsall
```julia
  Pkg.rm("CSE151MachineLearning.jl")
```
