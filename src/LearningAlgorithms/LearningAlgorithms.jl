module LearningAlgorithms
  files = ["KNeighbors","LinearRegression"]
  for f in files
    include("$f.jl")
  end
end
