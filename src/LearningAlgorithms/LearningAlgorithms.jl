module LearningAlgorithms
  files = ["KNeighbors","LinearRegression","KMeans"]
  for f in files
    include("$f.jl")
  end
end
