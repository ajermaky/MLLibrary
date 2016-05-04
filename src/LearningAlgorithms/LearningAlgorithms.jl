module LearningAlgorithms
  files = ["KNeighbors"]
  for f in files
    include("$f.jl")
  end
end
