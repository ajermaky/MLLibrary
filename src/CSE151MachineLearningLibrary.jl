module CSE151MachineLearningLibrary

# package code goes here
  files = ["DataManipulation","DataParser","LearningAlgorithms","DataSampling"]
  for file in files
    include(joinpath(file,"$file.jl"))
  end

end # module
