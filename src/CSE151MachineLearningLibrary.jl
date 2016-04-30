module CSE151MachineLearningLibrary

# package code goes here
  files = ["DataParser","Statistics","LearningAlgorithms","DataSampling","DataManipulation","Utils"]
  for file in files
    include(joinpath(file,"$file.jl"))
  end

end # module
