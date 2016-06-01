module LearningAlgorithms
  files = ["KNeighbors","LinearRegression","KMeans","MultinomialBayes"]
  for f in files
    include("$f.jl")
  end
end
