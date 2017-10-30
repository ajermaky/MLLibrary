# CustomMachineLearningLibrary
This Library was a quarter long project where we create our own ML package.
This includes:
* Parsing large data sets that cannot fit in memory
* Sampling and dividing data into training and test sets
* Implementions of basic ML algorithms utilizing Linear Algebra methods

I decided to create the project in Julia for the purposes of learning the
language, which was v0.4 at the time. As a result, the codebase itself is
was not created to make use of Julia's full functionality. In addition
the actual implementations may be buggy and incomplete in some sections
as a result of time constraints. This project is abandoned and should not be
used under any circumstances, and is only for viewing purposes!

## Dependencies:
This package depends on unregistered packages:
```julia
  #Unit Test Framework
  Pkg.clone("https://github.com/ajermaky/RunTests.jl")
```

## Install
```julia
Pkg.clone("https://github.com/ajermaky/MLLibrary.jl")
Pkg.resolve()
```

## Use:

To use this module:
```julia
  using MLLibrary
```
## Different Branches
Previous Branches:
Week1&2 Branch: week1_and_2_refactor
Week 3 Branch: week3
Week 4 Branch: week_4

To see previous branches, simply do
```git
  git fetch <branch_name>
  git checkout <branch_name>

```

## Test:

To Run Unit Tests:
```julia
  Pkg.test("MLLibrary")
```

To run custom test that regenerates resource files:
```julia
  cd("~/.julia/v0.4/MLLibrary")
  include("test/high_level_tests/Statistics.jl")
  include("test/high_level_tests/KNeighbors.jl")
  include("test/high_level_tests/LinearRegression.jl")
  include("test/high_level_tests/KMeans.jl")
```
## Unintsall
```julia
  Pkg.rm("MLLibrary.jl")
```
