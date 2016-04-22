module DataSampling
  using ..DataParser
  files = ["ThresholdSampling","DataReader"]
  for f in files
    include("$f.jl")
  end

  function getDataSetIndicies(fn,file, size, isTest, options)
    return fn(file,size,isTest,options)
  end


end
