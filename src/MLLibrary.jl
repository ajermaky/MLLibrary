module MLLibrary

# package code goes here
  files = ["DataParser","Statistics","LearningAlgorithms","DataSampling","DataManipulation","Utils","LinearAlgebra"]
  for file in files
    include(joinpath(file,"$file.jl"))
  end

end # module
